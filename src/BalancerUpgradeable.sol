// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.19;

import "openzeppelin-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "openzeppelin-upgradeable/utils/structs/EnumerableSetUpgradeable.sol";
import "openzeppelin-upgradeable/access/AccessControlUpgradeable.sol";
import "openzeppelin-upgradeable/utils/math/SafeCastUpgradeable.sol";
import "openzeppelin-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol";
import "openzeppelin-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "openzeppelin-upgradeable/security/ReentrancyGuardUpgradeable.sol";

import "./interfaces/IAdapter.sol";
import "./interfaces/IBalancer.sol";
import "./helpers/SwapExecutor.sol";

contract BalancerUpgradeable is IBalancer, ERC20Upgradeable, AccessControlUpgradeable, UUPSUpgradeable, ReentrancyGuardUpgradeable {
    using EnumerableSetUpgradeable for EnumerableSetUpgradeable.AddressSet;

    bytes32 public constant TIMELOCK_ADMIN_ROLE = keccak256("TIMELOCK_ADMIN_ROLE"); // timelock
    bytes32 public constant ADD_ADAPTER_ROLE = keccak256("ADD_ADAPTER_ROLE"); // timelock
    bytes32 public constant REMOVE_ADAPTER_ROLE = keccak256("REMOVE_ADAPTER_ROLE"); // timelock
    bytes32 public constant ACTIVATE_ADAPTER_ROLE = keccak256("ACTIVATE_ADAPTER_ROLE");
    bytes32 public constant DEACTIVATE_ADAPTER_ROLE = keccak256("DEACTIVATE_ADAPTER_ROLE");
    bytes32 public constant REBALANCE_ROLE = keccak256("REBALANCE_ROLE");
    bytes32 public constant COMPOUND_ROLE = keccak256("COMPOUND_ROLE");
    bytes32 public constant TAKE_PERFORMANCE_FEE_ROLE = keccak256("TAKE_PERFORMANCE_FEE_ROLE"); // timelock
    bytes32 public constant UPGRADE_ROLE = keccak256("UPGRADE_ROLE"); // timelock

    uint256 public constant PERCENTAGE_COEFFICIENT = 1e6; // 100%
    uint256 public constant MAX_REBALANCE_VALUE_LOSS = PERCENTAGE_COEFFICIENT / 100; // 1%
    uint256 public constant MAX_COMPOUND_PERFORMANCE_FEE = PERCENTAGE_COEFFICIENT / 20; // 5%
    uint256 public constant MAX_PROFIT_FACTOR = PERCENTAGE_COEFFICIENT / 100;  // 1%
    uint32 public constant REBALANCE_COOLDOWN = 6 hours; // 6 hour
    uint32 public constant TAKE_PROFIT_COOLDOWN = 1 days;

    uint256 public constant VALUE_DEGRADATION_COEFFICIENT = 1e18; // 100%
    
    uint32  public constant VALUE_DEGRADATION_DURATION = 7 days;
    uint256 public constant VALUE_DEGRADATION_RATE = VALUE_DEGRADATION_COEFFICIENT / VALUE_DEGRADATION_DURATION; // (0.0000016534*100)% per sec, 100% in 7 days

    
    SwapExecutor public immutable SWAP_EXECUTOR;
    uint256 public immutable DEPOSIT_FEE;
    EnumerableSetUpgradeable.AddressSet private $adapters;
    EnumerableSetUpgradeable.AddressSet private $chargedAdapters;    
    mapping(address => bool) public $isActiveAdapter;

    /**
     * @dev valueDecay holds amount of value that has to be subtracted from totalValue
     * When a strategy receives profit through gradual increase of it's undelyings value
     * we must periodically subtract our performance fee from the vault
     */
    /// @dev February 7, 2106 ought to be enough for anybody
    uint32  public $lastValueLock;
    uint112 public $valueDecayTarget; 
    uint112 public $valueReleaseTarget;

    uint32  public $lastRebalanceTime;
    uint32  public $lastTakeProfitTime;
    address public $feeReceiver;

    constructor(address _swapExecutor, uint256 _depositFee) {
        if (_depositFee > PERCENTAGE_COEFFICIENT) {
            revert ('invalid deposit fee');
        }
        SWAP_EXECUTOR = SwapExecutor(_swapExecutor);
        DEPOSIT_FEE = _depositFee;
    }

    function initialize(string memory name_, string memory symbol_, address feeReceiver_) public initializer {
        __ERC20_init(name_, symbol_);
        __AccessControl_init();
        __ReentrancyGuard_init();
        $feeReceiver = feeReceiver_;
        _grantRole(DEFAULT_ADMIN_ROLE, _msgSender()); // must be transferred to MULTISIG after deployment
        _grantRole(TIMELOCK_ADMIN_ROLE, _msgSender()); // must be transferred to TIMELOCK after deployment
        
        _setRoleAdmin(ADD_ADAPTER_ROLE, TIMELOCK_ADMIN_ROLE); 
        _setRoleAdmin(REMOVE_ADAPTER_ROLE, TIMELOCK_ADMIN_ROLE); 
        _setRoleAdmin(TAKE_PERFORMANCE_FEE_ROLE, TIMELOCK_ADMIN_ROLE); 
        _setRoleAdmin(UPGRADE_ROLE, TIMELOCK_ADMIN_ROLE); 

        emit FeeReceiverChanged(address(0), feeReceiver_);
    }

    /** 
     * @param targetAdapter adapter which have been supplied with liquidity and should be accounted in minting
     * 
     */
    function invest(address targetAdapter, address receiver) external override nonReentrant returns (uint sharesWithChargedFee) {
        if (!$isActiveAdapter[targetAdapter]) {
            revert InvalidAdapter(targetAdapter);
        }

        uint l = $chargedAdapters.length();
        uint valuePrior;
        uint valueAdded;
        bool isNewAdapter = true;

        for (uint i=0; i < l; i++) {
            IAdapter adapter = IAdapter($chargedAdapters.at(i));
            if (targetAdapter == address(adapter)) {
                isNewAdapter = false;
                (uint valueBefore, uint valueAfter) = adapter.invest(receiver);
                valuePrior += valueBefore;
                valueAdded += valueAfter - valueBefore;
            } else {
                (uint v,) = adapter.value();
                valuePrior += v;
            }
        }


        if (isNewAdapter) {
            $chargedAdapters.add(targetAdapter);
            IAdapter adapter = IAdapter(targetAdapter);
            (, uint valueAfter) = adapter.invest(receiver);
            valueAdded += valueAfter;
        }

        // subtract all unreleased profits and taken fees;
        // Note that nav can be 0 while valuePrior > 0 
        (uint nav,,) = _totalNAV(valuePrior);


        // shouldn't be susceptible to inflation attacks, since `valuePrior` can only increase through adding shares (???)
        uint sharesAdded = _convertToShares(valueAdded, nav);

        // still, some protection isn't going to hurt
        if (sharesAdded == 0) {
            revert SharesInflationError(valueAdded, nav);
        }

        sharesWithChargedFee = sharesAdded * (PERCENTAGE_COEFFICIENT - DEPOSIT_FEE) / PERCENTAGE_COEFFICIENT;

        emit Invest(targetAdapter, receiver, valuePrior, valueAdded, sharesAdded, sharesWithChargedFee);
        _mint(receiver, sharesWithChargedFee);
    }

    function redeem(uint shares, IAdapter targetAdapter, address receiver)
        external
        override 
        nonReentrant
        returns (
            address[] memory tokens,
            uint[] memory amounts
        )
    {
        uint b = balanceOf(msg.sender);
        if (b < shares) revert InsufficientFunds(b, shares);

        (uint tv, AdapterCache memory adapterCache) = _totalValueAndDetails(targetAdapter);
        (uint nav,,) = _totalNAV(tv);

        uint redeemValue = _convertToValue(shares, nav);
        
        if (redeemValue > adapterCache.value) {
            revert AdapterRedeemExceeds(adapterCache.value, redeemValue);
        }

        if (redeemValue == 0) {
            revert EmptyRedeem(shares, redeemValue, address(targetAdapter), adapterCache.value, adapterCache.lpAmount);
        }

        emit Redeem(address(targetAdapter), receiver, shares, tv, redeemValue);
        _burn(msg.sender, shares);

        uint lpsToRedeem = adapterCache.lpAmount * redeemValue / adapterCache.value;
        uint lpsLeft = adapterCache.lpAmount - lpsToRedeem;

        if (lpsToRedeem == 0) {
            revert EmptyRedeem(shares, redeemValue, address(targetAdapter), adapterCache.value, adapterCache.lpAmount);
        }     

        if (lpsLeft == 0) {
            $chargedAdapters.remove(address(targetAdapter));
        }

        (tokens, amounts) = targetAdapter.redeem(lpsToRedeem, receiver);
    }

    function _convertToShares(uint value, uint nav) internal view returns (uint) {
        if (nav == 0) {
            return value;
        }
        uint totalSupply = totalSupply();
        if (totalSupply == 0) {
            return value;
        }
        return value * totalSupply / nav;
    }

    function _convertToValue(uint shares, uint nav) internal view returns (uint) {
        return shares * nav / totalSupply();
    }

    function _lockedFunds() internal view returns (uint112 lockedProfit, uint112 lockedFee) {        
        uint degradationRatio = uint256(block.timestamp - $lastValueLock) * VALUE_DEGRADATION_RATE;
        // if releaseRatio >= 100% we consider that all profits were unlocked
        if (degradationRatio < VALUE_DEGRADATION_COEFFICIENT) {
            uint112 unlocked = uint112(uint($valueReleaseTarget) * degradationRatio / VALUE_DEGRADATION_COEFFICIENT);
            lockedProfit = $valueReleaseTarget - unlocked;
        }
 
        // if decayRatio >= 100% we consider that all fees were locked so, from now on we use entire target value
        if (degradationRatio < VALUE_DEGRADATION_COEFFICIENT) {
           lockedFee = uint112(uint256($valueDecayTarget) * degradationRatio / VALUE_DEGRADATION_COEFFICIENT);
        } else {
           lockedFee = $valueDecayTarget;
        }
    }

    /**
     * @param value Value in equivalent
     * @return nav Net Asset Value
     * @return lockedProfit Profit locked from selling reward tokens, must be released gradually over time, decreasing each second
     * @return lockedFee Performance fee that we periodically take, increases every second
     */
    function _totalNAV(uint value) internal view returns (uint nav, uint112 lockedProfit, uint112 lockedFee) {
        (lockedProfit, lockedFee) = _lockedFunds();
        nav = value > lockedProfit + lockedFee ? value - lockedProfit - lockedFee : 0;
    }
    
    function totalNAV() external override view returns (uint nav, uint112 lockedProfit, uint112 lockedFee) {
        uint tv = totalValue();
        return _totalNAV(tv);
    }

    function totalValue() public override view returns (uint value) {
       (value,) = _totalValueAndDetails(IAdapter(address(0)));
    }

    function _totalValueAndDetails(IAdapter targetAdapter) internal view returns (uint value, AdapterCache memory cache) {
        uint l = $chargedAdapters.length();

        for (uint i=0; i < l; i++) {
            IAdapter adapter = IAdapter($chargedAdapters.at(i));
            (uint v, uint a) = adapter.value();             
            value += v;
            if (adapter == targetAdapter) {
                cache.value = v;
                cache.lpAmount = a;
            }
        }
    }

    /**
     * @dev Return the entire set of adapters in an array
     *
     * WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
     * to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
     * this function has an unbounded cost, and using it as part of a state-changing function may render the function
     * uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
     */
    function adapters() external override view returns (address[] memory) {
        return $adapters.values();
    }

    /**
     * @dev Return the entire set of charged adapters in an array
     *
     * WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
     * to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
     * this function has an unbounded cost, and using it as part of a state-changing function may render the function
     * uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
     */
    function chargedAdapters() external override view returns (address[] memory) {
        return $chargedAdapters.values();
    }

    function swapExecutor() external override view returns (address) {
        return address(SWAP_EXECUTOR);
    }

    //╔═══════════════════════════════════════════ ADMINISTRATIVE FUNCTIONS ═══════════════════════════════════════════╗

    function setFeeReceiver(address feeReceiver_) external override onlyRole(DEFAULT_ADMIN_ROLE) {
        emit FeeReceiverChanged($feeReceiver, feeReceiver_);
        $feeReceiver = feeReceiver_;
    }

    function addAdapter(address adapterAddress) external override onlyRole(ADD_ADAPTER_ROLE) returns (bool isAdded) {
        IAdapter adapter = IAdapter(adapterAddress);
        (uint v, uint a) = adapter.value();
        if (v != 0 || a != 0) {
            revert AdapterNotEmpty(adapterAddress);
        }
        isAdded = $adapters.add(adapterAddress);
        if (isAdded) {
            emit AdapterAdded(adapterAddress);
        }
    }

    function removeAdapter(address adapterAddress) external override onlyRole(REMOVE_ADAPTER_ROLE) returns (bool) {
        if ($adapters.contains(adapterAddress)) {
            IAdapter adapter = IAdapter(adapterAddress);
            (uint v, uint a) = adapter.value();
            if (v != 0 || a != 0) {
                revert AdapterNotEmpty(adapterAddress);
            }
            _deactivateAdapter(adapterAddress);
            emit AdapterRemoved(adapterAddress);
            return $adapters.remove(adapterAddress);
        }
        return false;
    }

    function activateAdapter(address adapterAddress) external override onlyRole(ACTIVATE_ADAPTER_ROLE) returns (bool) {
        uint l = $adapters.length();

        for (uint i=0; i < l; i++) {
            if ($adapters.at(i) == adapterAddress) {
                $isActiveAdapter[adapterAddress] = true;
                emit AdapterActivityChanged(adapterAddress, true);
                return true;
            }
        }

        return false;
    }

    function deactivateAdapter(address adapterAddress) external override onlyRole(DEACTIVATE_ADAPTER_ROLE) {
        _deactivateAdapter(adapterAddress);
    }

    function _deactivateAdapter(address adapterAddress) internal {
        $isActiveAdapter[adapterAddress] = false;
        emit AdapterActivityChanged(adapterAddress, false);
    }

    function rebalance(
        IAdapter fromAdapter,
        IAdapter toAdapter,
        uint lpAmount,
        SwapInfo[] calldata swaps,
        TransferInfo[] calldata transfers,
        uint minRebalancedValue,
        uint32 deadline
    ) external override onlyRole(REBALANCE_ROLE) nonReentrant {
        if (deadline < block.timestamp) {
            revert Expired(deadline);
        }
        if (!$isActiveAdapter[address(toAdapter)]) {
            revert InvalidAdapter(address(toAdapter));
        }
        if ($lastRebalanceTime + REBALANCE_COOLDOWN > block.timestamp) {
            revert Cooldown($lastRebalanceTime + REBALANCE_COOLDOWN);
        }        
        
        (uint valueTotalBefore, uint totalLp) = fromAdapter.value();
        if (totalLp < lpAmount) {
            revert InsufficientFunds(totalLp, lpAmount);
        }
        uint rebalancedValueBefore = lpAmount * valueTotalBefore / totalLp;              

        fromAdapter.redeem(lpAmount, address(this));

        for (uint i = 0; i < swaps.length; i++) {
            IBalancer.SwapInfo calldata swap = swaps[i];
            SafeERC20Upgradeable.safeTransfer(IERC20Upgradeable(swap.token), address(SWAP_EXECUTOR), swap.amount);
        }
        SWAP_EXECUTOR.executeSwaps(swaps);

        for (uint i = 0; i < transfers.length; i++) {
            TransferInfo calldata transfer = transfers[i];
            SafeERC20Upgradeable.safeTransfer(IERC20Upgradeable(transfer.token), address(toAdapter), transfer.amount);
        }

        (uint vb, uint va) = toAdapter.invest(address(this));
        
        {
            uint rebalancedValueAfter = va - vb;
            if (rebalancedValueAfter < rebalancedValueBefore) { 
                uint diff = rebalancedValueBefore - rebalancedValueAfter;
                if (diff * PERCENTAGE_COEFFICIENT / rebalancedValueBefore > MAX_REBALANCE_VALUE_LOSS) {
                    revert ValueLost(diff);
                }
            }
            if (rebalancedValueAfter < minRebalancedValue) {
                revert MinRebalanceSlippageExceeds(minRebalancedValue, rebalancedValueAfter);
            }
        }

        $lastRebalanceTime = uint32(block.timestamp);
        emit Rebalance(address(fromAdapter), address(toAdapter), lpAmount);
    }
        
    function compound(
        address adapter, 
        uint performanceFee, 
        SwapInfo[] calldata swaps, 
        uint256 minValue,
        uint32 deadline
    ) external override onlyRole(COMPOUND_ROLE) nonReentrant returns (uint addedValue) {
        if (deadline < block.timestamp) {
            revert Expired(deadline);
        }
        if (!$adapters.contains(adapter)) {
            revert InvalidAdapter(adapter);
        }
        if (performanceFee > MAX_COMPOUND_PERFORMANCE_FEE) {
            revert InvalidPerformanceFee(performanceFee);
        }

        (uint valueBefore, uint valueAfter) = IAdapter(adapter).compound(swaps);
        addedValue = valueAfter - valueBefore;
        if (minValue > addedValue) {
            revert InsufficientLiquidityAdded(addedValue, minValue);
        }
        uint fee = addedValue * performanceFee / PERCENTAGE_COEFFICIENT;

        _lockValue(SafeCastUpgradeable.toUint112(addedValue), SafeCastUpgradeable.toUint112(fee));
    }

    function takePerformanceFee(uint112 feeValue) external override onlyRole(TAKE_PERFORMANCE_FEE_ROLE) nonReentrant {
        if ($lastTakeProfitTime + TAKE_PROFIT_COOLDOWN > block.timestamp) {
            revert Cooldown($lastTakeProfitTime + TAKE_PROFIT_COOLDOWN);
        }

        uint tv = totalValue();
        if (feeValue > tv) {
            revert InsufficientFunds(tv, feeValue);
        }
        if (feeValue * PERCENTAGE_COEFFICIENT / tv > MAX_PROFIT_FACTOR) {
            revert HugePerformanceFee(feeValue, tv);
        }

        _lockValue(0, feeValue);

        $lastTakeProfitTime = uint32(block.timestamp);
    }

    function _lockValue(uint112 profitToLock, uint112 feeToLock) internal {
        uint tv = totalValue();
        (uint nav, uint112 lockedProfit, uint112 lockedFee) = _totalNAV(tv);

        // if there is any locked profit left, then new value will be remaining locked profit + new profit to lock
        $valueReleaseTarget = lockedProfit + profitToLock;

        // if any fee was locked then convert it to shares and decrease lock fee target
        if (lockedFee > 0) {
            uint shares = _convertToShares(lockedFee, nav);
            $valueDecayTarget -= lockedFee;
            _mint($feeReceiver, shares);
        }

        // new target for value decay
        $valueDecayTarget += feeToLock;

        $lastValueLock = uint32(block.timestamp);
        emit ProfitLocked(tv, profitToLock, feeToLock, block.timestamp + VALUE_DEGRADATION_DURATION);
    }

    function _authorizeUpgrade(address) internal override onlyRole(UPGRADE_ROLE) {}

}