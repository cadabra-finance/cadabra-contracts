// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IPairCallee {

    function hook(address sender, uint amount0, uint amount1, bytes calldata data) external;

}

interface IPair {

    function tokens() external view returns (address, address);
    function transferFrom(address src, address dst, uint amount) external returns (bool);
    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function burn(address to) external returns (uint amount0, uint amount1);
    function mint(address to) external returns (uint liquidity);
    function getReserves() external view returns (uint _reserve0, uint _reserve1, uint _blockTimestampLast);
    function getAmountOut(uint, address) external view returns (uint);

    function name() external view returns(string memory);
    function symbol() external view returns(string memory);
    function totalSupply() external view returns (uint);
    function decimals() external view returns (uint8);

    function current(address tokenIn, uint amountIn) external view returns (uint amountOut);
    function transfer(address dst, uint amount) external returns (bool);

}