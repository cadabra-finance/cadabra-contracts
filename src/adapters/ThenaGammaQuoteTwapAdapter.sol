// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.19;

import "../helpers/TwapUtils.sol";
import "./ThenaGammaAdapter.sol";

contract ThenaGammaQuoteTwapAdapter is ThenaGammaAdapter {
    address public immutable POOL;
    bool public immutable isToken1Quote;

    constructor(address _balancer, address _gauge, address _quoteToken) ThenaGammaAdapter(_balancer, _gauge) {
        isToken1Quote = _isToken1Quote(_quoteToken);
        POOL = address(HYPERVISOR.pool());
    }

    function _isToken1Quote(address _quoteToken) private view returns (bool) {
        if (address(TOKEN0) == _quoteToken) {
            return false;
        } else if (address(TOKEN1) == _quoteToken) {
            return true;
        } else {
            revert('invalid quote token');
        }
    }

    function token0Price() public virtual view override returns (uint256)  {
        return isToken1Quote ? TwapUtils.convertToken0ToToken1(1e18, POOL, 15) : 1e18;
    }

    function token1Price() public view virtual override returns (uint256) {
        return isToken1Quote ? 1e18 : TwapUtils.convertToken1ToToken0(1e18, POOL, 15);
    }
}
