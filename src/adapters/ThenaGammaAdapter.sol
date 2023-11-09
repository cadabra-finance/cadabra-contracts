// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;

import "openzeppelin/token/ERC20/IERC20.sol";
import "openzeppelin/token/ERC20/extensions/IERC20Metadata.sol";
import "openzeppelin/utils/Address.sol";
import "openzeppelin/utils/math/SafeCast.sol";
import "openzeppelin/utils/Strings.sol";
import "openzeppelin/token/ERC20/utils/SafeERC20.sol";

import "./BaseAdapter.sol";
import "../interfaces/IAdapter.sol";
import "../interfaces/thena/IGaugeV2.sol";
import "../interfaces/IBalancer.sol";
import "../interfaces/thena/IGammaHypervisor.sol";
import "../interfaces/thena/IUniProxy.sol";

abstract contract ThenaGammaAdapter is BaseAdapter {

    using SafeERC20 for IERC20;

    IHypervisor  public immutable HYPERVISOR;
    IGaugeV2     public immutable GAUGE;
    IERC20       public immutable TOKEN0;
    IERC20       public immutable TOKEN1;
    IERC20       public immutable REWARD_TOKEN;

    // TODO: move values calculation into derived classes
    uint public constant  PRICE_DECIMALS = 1e18;

    uint private immutable PRECISION_MULTIPLIER_0;
    uint private immutable PRECISION_MULTIPLIER_1;

    constructor(
        address _balancer,
        address _gauge
    ) BaseAdapter(_balancer) {
        GAUGE = IGaugeV2(_gauge);
        HYPERVISOR = IHypervisor(GAUGE.TOKEN());

        (TOKEN0, TOKEN1) = (HYPERVISOR.token0(), HYPERVISOR.token1());
        REWARD_TOKEN = IERC20(GAUGE.rewardToken());

        TOKEN0.approve(address(HYPERVISOR), type(uint256).max);
        TOKEN1.approve(address(HYPERVISOR), type(uint256).max);
        HYPERVISOR.approve(_gauge, type(uint256).max);

        uint8 decimals0 = IERC20Metadata(address(TOKEN0)).decimals();
        if (decimals0 > 18) {
            revert("UnsupportedToken");
        }
        PRECISION_MULTIPLIER_0 = 10**(18 - decimals0);

        uint8 decimals1 = IERC20Metadata(address(TOKEN1)).decimals();
        if (decimals1 > 18) {
            revert("UnsupportedToken");
        }
        PRECISION_MULTIPLIER_1 = 10**(18 - decimals1);
    }

    function _invest() internal override {
        uint deposit0;
        uint deposit1;
        {
            // Because pair requires a certain proportion of the tokens for the deposit we can't just deposit all
            // the tokens we have on our balance. We need to deposit them in accordance to the pair's ratio
            uint balance0 = TOKEN0.balanceOf(address(this));
            uint balance1 = TOKEN1.balanceOf(address(this));
            (uint reserve0, uint reserve1) = HYPERVISOR.getTotalAmounts();
            if(reserve0 == 0 || reserve1 == 0){
                revert ZeroReserveBalance(reserve0,reserve1);
            }

            deposit0 = balance0;
            deposit1 = deposit0 * reserve1 / reserve0;

            if (deposit1 > balance1) {
                deposit1 = balance1;
                deposit0 = deposit1 * reserve0 / reserve1;
            }
        }

        uint[4] memory minIn;
        IUniProxy uniProxy = IUniProxy(HYPERVISOR.whitelistedAddress());
        uniProxy.deposit(deposit0, deposit1, address(this), address(HYPERVISOR), minIn);

        GAUGE.depositAll();
    }

    function _redeem(uint lpAmount, address to)
        internal
        override
        returns (address[] memory tokens, uint[] memory amounts)
    {
        GAUGE.withdraw(lpAmount);
        uint[4] memory minAmounts;
        (uint a0, uint a1) = HYPERVISOR.withdraw(lpAmount, to, address(this), minAmounts);

        tokens = depositTokens();
        amounts = new uint[](2);

        amounts[0] = a0;
        amounts[1] = a1;
    }

    function _claimAll() internal override {
        GAUGE.getReward();
    }

    function value() public override view returns (uint estimatedValue, uint lps) {
        uint price0 = token0Price();
        uint price1 = token1Price();
        (estimatedValue, lps) = _value(price0, price1);
    }

    function _value(uint price0, uint price1) private view returns (uint estimatedValue, uint lps) {
        (uint reserve0, uint reserve1) = HYPERVISOR.getTotalAmounts();
        uint ts = HYPERVISOR.totalSupply();

        // total value of underlying reserves
        uint value0 = reserve0 * price0 * PRECISION_MULTIPLIER_0;
        uint value1 = reserve1 * price1 * PRECISION_MULTIPLIER_1;

        lps = GAUGE.balanceOf(address(this));
        estimatedValue = (value0 + value1) * lps / ts / PRICE_DECIMALS;
    }

    function negotiableTokens() public virtual override returns(address[] memory tokens) {
        tokens = new address[](3);
        tokens[0] = address(TOKEN0);
        tokens[1] = address(TOKEN1);
        tokens[2] = address(REWARD_TOKEN);
    }

    function depositTokens() public override view returns (address[] memory tokens) {
        tokens = new address[](2);
        tokens[0] = address(TOKEN0);
        tokens[1] = address(TOKEN1);
    }

    /// @notice returns amount of pending rewards in the reward token
    /// @dev for offchain use 
    function pendingRewards() external override view returns(address[] memory tokens, uint[] memory amounts) {
        tokens  = new address[](1);
        amounts = new uint[](1);

        tokens[0] = address(REWARD_TOKEN);
        amounts[0] = GAUGE.earned(address(this));
    }

    /// @dev for offchain use 
    function ratios()
        external
        override
        view
        returns (address[] memory tokens, uint[] memory ratio)
    {
        tokens = depositTokens();
        ratio  = new uint[](2);
        uint base = 1e18;

        (uint r0, uint r1) = IHypervisor(HYPERVISOR).getTotalAmounts();
        r0 = r0;
        r1 = r1;

        uint total = (r0 + r1);
        ratio[0] = base * r0 / total;
        ratio[1] = base * r1 / total;
    }

    /// @dev for offchain use 
    function description() external override view returns (string memory) {
        return string.concat('{"type":"thenaGauge","vaultAddress": "', Strings.toHexString(address(GAUGE)), '"}');
    }

    function token0Decimals() public view returns (uint8 decimals) {
        decimals = IERC20Metadata(address(TOKEN0)).decimals();
    }

    function token1Decimals() public view returns (uint8 decimals) {
        decimals = IERC20Metadata(address(TOKEN1)).decimals();
    }

    function token0Price() public virtual view returns (uint256);
    function token1Price() public virtual view returns (uint256);

}
