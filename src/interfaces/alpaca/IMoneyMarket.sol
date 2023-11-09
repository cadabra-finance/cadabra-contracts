// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.10;

interface IMoneyMarket {

  function getIbTokenFromToken(address _token) external view returns (address);

}