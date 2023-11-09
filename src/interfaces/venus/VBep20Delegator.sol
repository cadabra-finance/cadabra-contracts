pragma solidity ^0.8.19;

interface VTokenInterface {

    function transfer(address dst, uint amount) external returns (bool);
    function approve(address spender, uint amount) external returns (bool);
    function balanceOf(address owner) external view returns (uint);
    function supplyRatePerBlock() external view returns (uint);
    function exchangeRateStored() external view returns (uint);
    function exchangeRateCurrent() external returns (uint);
    function accrueInterest() external returns (uint);
    function comptroller() external view returns (address);

}

interface VBep20Interface {

    function mint(uint mintAmount) external returns (uint);
    function redeem(uint redeemAmount) external returns (uint);
    function redeemUnderlying(uint redeemAmount) external returns (uint);
    function underlying() external view returns (address);

}

interface VBep20Delegator is VTokenInterface, VBep20Interface {
    // nothing
}