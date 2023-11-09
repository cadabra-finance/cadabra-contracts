// SPDX-License-Identifier: BUSL-1.1

pragma solidity ^0.8.19;

import "openzeppelin-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "openzeppelin-upgradeable/access/manager/AccessManagedUpgradeable.sol";

import "./../interfaces/uniswap/INonfungiblePositionManager.sol";
import "./../token/Abra.sol";
import "./../interfaces/IBalancer.sol";

contract LiquidityMaster is AccessManagedUpgradeable, UUPSUpgradeable {

    struct MintParams {
        address token;
        uint24 fee;
        int24 tickLower;
        int24 tickUpper;
        uint256 abraAmount;
        uint256 deadline;
    }

    struct IncreaseLiquidityParams {
        uint256 tokenId;
        uint256 abraAmount;
        uint256 deadline;
    }

    mapping(uint16 => address) public recipientByChainId;

    mapping(address => bool) private permittedAssets;


    INonfungiblePositionManager public immutable nonfungiblePositionManager;
    Abra public immutable abra;

    constructor(address _nonfungiblePositionManager, address _abra) {
        nonfungiblePositionManager = INonfungiblePositionManager(_nonfungiblePositionManager);
        abra = Abra(_abra);
    }

    function initialize(address _authority) external initializer {
        __AccessManaged_init(_authority);
        __UUPSUpgradeable_init();
    }

    function permitAsset(address asset, bool permit) external restricted {
        permittedAssets[asset] = permit;
    }

    function setRecipientForChain(uint16 _dstChainId, address _recipient) external restricted {
        recipientByChainId[_dstChainId] = _recipient;
    }

    function mintLiquidity(MintParams calldata params)
        public
        restricted
        returns (
            uint256 tokenId,
            uint128 liquidity,
            uint256 amount0,
            uint256 amount1
        )
    {
        _checkAssetPermitted(params.token);
        abra.approve(address(nonfungiblePositionManager), params.abraAmount);

        address token0;
        address token1;
        (token0, token1, amount0, amount1) = params.token < address(abra)
                ? (params.token, address(abra), uint256(0), params.abraAmount)
                : (address(abra), params.token, params.abraAmount, uint256(0));

        INonfungiblePositionManager.MintParams memory mintParams = INonfungiblePositionManager.MintParams(
            token0,
            token1,
            params.fee,
            params.tickLower,
            params.tickUpper,
            amount0,
            amount1,
            amount0,
            amount1,
            address(this),
            params.deadline
        );
        return nonfungiblePositionManager.mint(mintParams);
    }

    function increaseLiquidity(IncreaseLiquidityParams calldata params)
        external
        restricted
        returns (
            uint128 liquidity,
            uint256 amount0,
            uint256 amount1
        )
    {
        (,,address token0, address token1,,,,,,,,) = nonfungiblePositionManager.positions(params.tokenId);

        require(token0 == address(abra) || token1 == address(abra), "LM: ABRA_TOKEN_REQUIRED");
        _checkAssetPermitted(token0 == address(abra) ? token1 : token0);

        (uint256 increaseAmount0, uint256 increaseAmount1) = token1 == address(abra)
            ? (uint256(0), params.abraAmount)
            : (params.abraAmount, uint256(0));

        abra.approve(address(nonfungiblePositionManager), params.abraAmount);

        return nonfungiblePositionManager.increaseLiquidity(INonfungiblePositionManager.IncreaseLiquidityParams(
                params.tokenId,
                increaseAmount0,
                increaseAmount1,
                increaseAmount0,
                increaseAmount1,
                params.deadline
            ));
    }

    function decreaseLiquidity(INonfungiblePositionManager.DecreaseLiquidityParams calldata params)
        public
        restricted
        returns (uint256 amount0, uint256 amount1)
    {
        (,,address token0, address token1,,,,,,,,) = nonfungiblePositionManager.positions(params.tokenId);
        require(token0 == address(abra) || token1 == address(abra), "LM: ABRA_TOKEN_REQUIRED");

        (amount0, amount1) = nonfungiblePositionManager.decreaseLiquidity(params);
        require(token0 == address(abra) ? amount1 == 0 : amount0 == 0, "LM: can not decrease liquidity");
    }

    function sendAbraToChain(uint16 _dstChainId, uint256 amount) payable external restricted {
        address target = recipientByChainId[_dstChainId];
        require(target != address(0), "LM: no recipient for target chain");
        abra.sendFrom{value: msg.value}(address(this), _dstChainId, abi.encodePacked(target), amount, payable(msg.sender), msg.sender, "");
    }

    function _authorizeUpgrade(address) internal override restricted {}

    function _checkAssetPermitted(address token) private view {
        require(permittedAssets[token], "LM: asset not permitted");
    }

    function compound(
        INonfungiblePositionManager.DecreaseLiquidityParams calldata decreaseLiquidityParams,
        MintParams calldata mintParams,
        IBalancer balancer,
        address adapter,
        uint performanceFee,
        IBalancer.SwapInfo[] calldata swaps,
        uint256 minTokensBought,
        uint32 deadline
    ) external restricted returns (uint tokensBought, uint liquidityMinted) {
        decreaseLiquidity(decreaseLiquidityParams);
        mintLiquidity(mintParams);
        return balancer.compound(adapter, performanceFee, swaps, minTokensBought, deadline);
    }

}