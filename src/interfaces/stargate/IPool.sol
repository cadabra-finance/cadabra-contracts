pragma solidity ^0.8.19;

import "openzeppelin/token/ERC20/IERC20.sol";

interface IPool {
    function balanceOf(address) external view returns (uint256);

    function poolId() external view returns (uint256);

    function token() external view returns (address);

    function router() external view returns (address);

    function totalLiquidity() external view returns (uint256);

    function totalSupply() external view returns (uint256);

    function convertRate() external view returns (uint256);

    function approve(address, uint256) external returns (bool);
}
