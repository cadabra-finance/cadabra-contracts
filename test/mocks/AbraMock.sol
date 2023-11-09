// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin/token/ERC20/ERC20.sol";

contract AbraMock is ERC20 {

    constructor() ERC20("ABRA mock", "ABRAM") {
        _mint(msg.sender, 1000000*1e18);
    }

}
