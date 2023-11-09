// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IPairFactory {

    event PairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint
    );

    function allPairsLength() external view returns (uint256);
    function allPairs(uint idx) external view returns (address pair);
    function isPair(address pair) external view returns (bool);
    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function createPair(address tokenA, address tokenB) external returns (address pair);
    function getFee(address pair) external view returns (uint256);
    function setDefaultFee(uint256 _defaultFee) external;
    function setFee(address pair, uint256 fee) external;
    function isPaused() external view returns (bool);
    function setPause(bool _isPaused) external;

}
