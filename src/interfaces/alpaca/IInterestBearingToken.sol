// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.10;

import "openzeppelin/token/ERC20/IERC20.sol";

interface IInterestBearingToken is IERC20 {

    function convertToAssets(uint256 shares) external view returns (uint256);

}