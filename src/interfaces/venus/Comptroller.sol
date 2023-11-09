pragma solidity ^0.8.19;

interface Comptroller {

    function claimVenus(address holder) external;
    function getXVSAddress() external view returns (address);

}