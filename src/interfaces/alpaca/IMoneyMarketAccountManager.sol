// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.10;

interface IMoneyMarketAccountManager {

  function deposit(address _token, uint256 _amount) external;

  function withdraw(address _ibToken, uint256 _ibAmount) external;

  function moneyMarket() external returns(address);

}