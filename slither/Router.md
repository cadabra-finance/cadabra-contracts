Summary
 - [unused-return](#unused-return) (2 results) (Medium)
 - [missing-zero-check](#missing-zero-check) (1 results) (Low)
 - [calls-loop](#calls-loop) (1 results) (Low)
 - [assembly](#assembly) (1 results) (Informational)
 - [dead-code](#dead-code) (11 results) (Informational)
 - [solc-version](#solc-version) (2 results) (Informational)
 - [low-level-calls](#low-level-calls) (4 results) (Informational)
 - [naming-convention](#naming-convention) (1 results) (Informational)
 - [external-function](#external-function) (1 results) (Optimization)
## unused-return
Impact: Medium
Confidence: Medium
 - [ ] ID-0
[SwapExecutor.executeSwaps(IBalancer.SwapInfo[])](../../share/Router.sol#L628-L634) ignores return value by [Address.functionCall(swap.callee,swap.data)](../../share/Router.sol#L632)

../../share/Router.sol#L628-L634


 - [ ] ID-1
[SwapExecutor.executeSwaps(IBalancer.SwapInfo[])](../../share/Router.sol#L628-L634) ignores return value by [IERC20(swap.token).approve(swap.callee,swap.amount)](../../share/Router.sol#L631)

../../share/Router.sol#L628-L634


## missing-zero-check
Impact: Low
Confidence: Medium
 - [ ] ID-2
[Router.constructor(address,address)._weth](../../share/Router.sol#L644) lacks a zero-check on :
		- [weth = _weth](../../share/Router.sol#L645)

../../share/Router.sol#L644


## calls-loop
Impact: Low
Confidence: Medium
 - [ ] ID-3
[SwapExecutor.executeSwaps(IBalancer.SwapInfo[])](../../share/Router.sol#L628-L634) has external calls inside a loop: [IERC20(swap.token).approve(swap.callee,swap.amount)](../../share/Router.sol#L631)

../../share/Router.sol#L628-L634


## assembly
Impact: Informational
Confidence: High
 - [ ] ID-4
[Address._revert(bytes,string)](../../share/Router.sol#L371-L383) uses assembly
	- [INLINE ASM](../../share/Router.sol#L376-L379)

../../share/Router.sol#L371-L383


## dead-code
Impact: Informational
Confidence: Medium
 - [ ] ID-5
[Address.verifyCallResult(bool,bytes,string)](../../share/Router.sol#L359-L369) is never used and should be removed

../../share/Router.sol#L359-L369


 - [ ] ID-6
[Address.sendValue(address,uint256)](../../share/Router.sol#L200-L205) is never used and should be removed

../../share/Router.sol#L200-L205


 - [ ] ID-7
[Address.functionCallWithValue(address,bytes,uint256)](../../share/Router.sol#L254-L260) is never used and should be removed

../../share/Router.sol#L254-L260


 - [ ] ID-8
[Address.functionDelegateCall(address,bytes,string)](../../share/Router.sol#L320-L327) is never used and should be removed

../../share/Router.sol#L320-L327


 - [ ] ID-9
[Address.functionDelegateCall(address,bytes)](../../share/Router.sol#L310-L312) is never used and should be removed

../../share/Router.sol#L310-L312


 - [ ] ID-10
[SafeERC20.safeIncreaseAllowance(IERC20,address,uint256)](../../share/Router.sol#L437-L444) is never used and should be removed

../../share/Router.sol#L437-L444


 - [ ] ID-11
[SafeERC20.safePermit(IERC20Permit,address,address,uint256,uint256,uint8,bytes32,bytes32)](../../share/Router.sol#L459-L473) is never used and should be removed

../../share/Router.sol#L459-L473


 - [ ] ID-12
[SafeERC20.safeApprove(IERC20,address,uint256)](../../share/Router.sol#L422-L435) is never used and should be removed

../../share/Router.sol#L422-L435


 - [ ] ID-13
[Address.functionStaticCall(address,bytes)](../../share/Router.sol#L285-L287) is never used and should be removed

../../share/Router.sol#L285-L287


 - [ ] ID-14
[SafeERC20.safeDecreaseAllowance(IERC20,address,uint256)](../../share/Router.sol#L446-L457) is never used and should be removed

../../share/Router.sol#L446-L457


 - [ ] ID-15
[Address.functionStaticCall(address,bytes,string)](../../share/Router.sol#L295-L302) is never used and should be removed

../../share/Router.sol#L295-L302


## solc-version
Impact: Informational
Confidence: High
 - [ ] ID-16
Pragma version[^0.8.19](../../share/Router.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.6.12/0.7.6/0.8.7

../../share/Router.sol#L2


 - [ ] ID-17
solc-0.8.19 is not recommended for deployment

## low-level-calls
Impact: Informational
Confidence: High
 - [ ] ID-18
Low level call in [Address.functionDelegateCall(address,bytes,string)](../../share/Router.sol#L320-L327):
	- [(success,returndata) = target.delegatecall(data)](../../share/Router.sol#L325)

../../share/Router.sol#L320-L327


 - [ ] ID-19
Low level call in [Address.functionStaticCall(address,bytes,string)](../../share/Router.sol#L295-L302):
	- [(success,returndata) = target.staticcall(data)](../../share/Router.sol#L300)

../../share/Router.sol#L295-L302


 - [ ] ID-20
Low level call in [Address.functionCallWithValue(address,bytes,uint256,string)](../../share/Router.sol#L268-L277):
	- [(success,returndata) = target.call{value: value}(data)](../../share/Router.sol#L275)

../../share/Router.sol#L268-L277


 - [ ] ID-21
Low level call in [Address.sendValue(address,uint256)](../../share/Router.sol#L200-L205):
	- [(success) = recipient.call{value: amount}()](../../share/Router.sol#L203)

../../share/Router.sol#L200-L205


## naming-convention
Impact: Informational
Confidence: High
 - [ ] ID-22
Function [IERC20Permit.DOMAIN_SEPARATOR()](../../share/Router.sol#L141) is not in mixedCase

../../share/Router.sol#L141


## external-function
Impact: Optimization
Confidence: High
 - [ ] ID-23
executeSwaps(IBalancer.SwapInfo[]) should be declared external:
	- [SwapExecutor.executeSwaps(IBalancer.SwapInfo[])](../../share/Router.sol#L628-L634)

../../share/Router.sol#L628-L634


