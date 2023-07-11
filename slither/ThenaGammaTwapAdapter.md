Summary
 - [divide-before-multiply](#divide-before-multiply) (17 results) (Medium)
 - [uninitialized-local](#uninitialized-local) (2 results) (Medium)
 - [unused-return](#unused-return) (6 results) (Medium)
 - [calls-loop](#calls-loop) (1 results) (Low)
 - [timestamp](#timestamp) (1 results) (Low)
 - [assembly](#assembly) (7 results) (Informational)
 - [dead-code](#dead-code) (93 results) (Informational)
 - [solc-version](#solc-version) (2 results) (Informational)
 - [low-level-calls](#low-level-calls) (4 results) (Informational)
 - [naming-convention](#naming-convention) (17 results) (Informational)
 - [similar-names](#similar-names) (21 results) (Informational)
 - [too-many-digits](#too-many-digits) (1 results) (Informational)
 - [unused-state](#unused-state) (1 results) (Informational)
 - [external-function](#external-function) (6 results) (Optimization)
## divide-before-multiply
Impact: Medium
Confidence: Medium
 - [ ] ID-0
[FullMath.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L3327-L3412) performs a multiplication on the result of a division:
	-[prod0 = prod0 / twos](../../share/ThenaGammaTwapAdapter.sol#L3377)
	-[result = prod0 * inv](../../share/ThenaGammaTwapAdapter.sol#L3409)

../../share/ThenaGammaTwapAdapter.sol#L3327-L3412


 - [ ] ID-1
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L1567-L1647) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaTwapAdapter.sol#L1614)
	-[inverse *= 2 - denominator * inverse](../../share/ThenaGammaTwapAdapter.sol#L1638)

../../share/ThenaGammaTwapAdapter.sol#L1567-L1647


 - [ ] ID-2
[FullMath.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L3327-L3412) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaTwapAdapter.sol#L3372)
	-[inv = (3 * denominator) ^ 2](../../share/ThenaGammaTwapAdapter.sol#L3392)

../../share/ThenaGammaTwapAdapter.sol#L3327-L3412


 - [ ] ID-3
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L1567-L1647) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaTwapAdapter.sol#L1614)
	-[inverse *= 2 - denominator * inverse](../../share/ThenaGammaTwapAdapter.sol#L1636)

../../share/ThenaGammaTwapAdapter.sol#L1567-L1647


 - [ ] ID-4
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L1567-L1647) performs a multiplication on the result of a division:
	-[prod0 = prod0 / twos](../../share/ThenaGammaTwapAdapter.sol#L1617)
	-[result = prod0 * inverse](../../share/ThenaGammaTwapAdapter.sol#L1644)

../../share/ThenaGammaTwapAdapter.sol#L1567-L1647


 - [ ] ID-5
[FullMath.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L3327-L3412) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaTwapAdapter.sol#L3372)
	-[inv *= 2 - denominator * inv](../../share/ThenaGammaTwapAdapter.sol#L3400)

../../share/ThenaGammaTwapAdapter.sol#L3327-L3412


 - [ ] ID-6
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L1567-L1647) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaTwapAdapter.sol#L1614)
	-[inverse *= 2 - denominator * inverse](../../share/ThenaGammaTwapAdapter.sol#L1633)

../../share/ThenaGammaTwapAdapter.sol#L1567-L1647


 - [ ] ID-7
[FullMath.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L3327-L3412) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaTwapAdapter.sol#L3372)
	-[inv *= 2 - denominator * inv](../../share/ThenaGammaTwapAdapter.sol#L3397)

../../share/ThenaGammaTwapAdapter.sol#L3327-L3412


 - [ ] ID-8
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L1567-L1647) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaTwapAdapter.sol#L1614)
	-[inverse *= 2 - denominator * inverse](../../share/ThenaGammaTwapAdapter.sol#L1634)

../../share/ThenaGammaTwapAdapter.sol#L1567-L1647


 - [ ] ID-9
[FullMath.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L3327-L3412) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaTwapAdapter.sol#L3372)
	-[inv *= 2 - denominator * inv](../../share/ThenaGammaTwapAdapter.sol#L3401)

../../share/ThenaGammaTwapAdapter.sol#L3327-L3412


 - [ ] ID-10
[FullMath.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L3327-L3412) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaTwapAdapter.sol#L3372)
	-[inv *= 2 - denominator * inv](../../share/ThenaGammaTwapAdapter.sol#L3396)

../../share/ThenaGammaTwapAdapter.sol#L3327-L3412


 - [ ] ID-11
[LiquidityUtils.ratio2(uint256,uint256,uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L2920-L2935) performs a multiplication on the result of a division:
	-[d1 = d0 * reserve1 / reserve0](../../share/ThenaGammaTwapAdapter.sol#L2929)
	-[d0 = d1 * reserve0 / reserve1](../../share/ThenaGammaTwapAdapter.sol#L2933)

../../share/ThenaGammaTwapAdapter.sol#L2920-L2935


 - [ ] ID-12
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L1567-L1647) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaTwapAdapter.sol#L1614)
	-[inverse *= 2 - denominator * inverse](../../share/ThenaGammaTwapAdapter.sol#L1635)

../../share/ThenaGammaTwapAdapter.sol#L1567-L1647


 - [ ] ID-13
[FullMath.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L3327-L3412) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaTwapAdapter.sol#L3372)
	-[inv *= 2 - denominator * inv](../../share/ThenaGammaTwapAdapter.sol#L3399)

../../share/ThenaGammaTwapAdapter.sol#L3327-L3412


 - [ ] ID-14
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L1567-L1647) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaTwapAdapter.sol#L1614)
	-[inverse = (3 * denominator) ^ 2](../../share/ThenaGammaTwapAdapter.sol#L1629)

../../share/ThenaGammaTwapAdapter.sol#L1567-L1647


 - [ ] ID-15
[FullMath.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L3327-L3412) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaTwapAdapter.sol#L3372)
	-[inv *= 2 - denominator * inv](../../share/ThenaGammaTwapAdapter.sol#L3398)

../../share/ThenaGammaTwapAdapter.sol#L3327-L3412


 - [ ] ID-16
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L1567-L1647) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaTwapAdapter.sol#L1614)
	-[inverse *= 2 - denominator * inverse](../../share/ThenaGammaTwapAdapter.sol#L1637)

../../share/ThenaGammaTwapAdapter.sol#L1567-L1647


## uninitialized-local
Impact: Medium
Confidence: Medium
 - [ ] ID-17
[ThenaGammaAdapter._invest().minIn](../../share/ThenaGammaTwapAdapter.sol#L3001) is a local variable never initialized

../../share/ThenaGammaTwapAdapter.sol#L3001


 - [ ] ID-18
[ThenaGammaAdapter._redeem(uint256,address).minAmounts](../../share/ThenaGammaTwapAdapter.sol#L3016) is a local variable never initialized

../../share/ThenaGammaTwapAdapter.sol#L3016


## unused-return
Impact: Medium
Confidence: Medium
 - [ ] ID-19
[SwapExecutor.executeSwaps(IBalancer.SwapInfo[])](../../share/ThenaGammaTwapAdapter.sol#L2186-L2192) ignores return value by [Address.functionCall(swap.callee,swap.data)](../../share/ThenaGammaTwapAdapter.sol#L2190)

../../share/ThenaGammaTwapAdapter.sol#L2186-L2192


 - [ ] ID-20
[ThenaGammaAdapter._invest()](../../share/ThenaGammaTwapAdapter.sol#L2983-L3008) ignores return value by [UNIPROXY.deposit(deposit0,deposit1,address(this),address(HYPERVISOR),minIn)](../../share/ThenaGammaTwapAdapter.sol#L3003)

../../share/ThenaGammaTwapAdapter.sol#L2983-L3008


 - [ ] ID-21
[ThenaGammaAdapter.constructor(address,address)](../../share/ThenaGammaTwapAdapter.sol#L2955-L2981) ignores return value by [HYPERVISOR.approve(_gauge,type()(uint256).max)](../../share/ThenaGammaTwapAdapter.sol#L2968)

../../share/ThenaGammaTwapAdapter.sol#L2955-L2981


 - [ ] ID-22
[ThenaGammaAdapter.constructor(address,address)](../../share/ThenaGammaTwapAdapter.sol#L2955-L2981) ignores return value by [TOKEN0.approve(address(HYPERVISOR),type()(uint256).max)](../../share/ThenaGammaTwapAdapter.sol#L2966)

../../share/ThenaGammaTwapAdapter.sol#L2955-L2981


 - [ ] ID-23
[SwapExecutor.executeSwaps(IBalancer.SwapInfo[])](../../share/ThenaGammaTwapAdapter.sol#L2186-L2192) ignores return value by [IERC20(swap.token).approve(swap.callee,swap.amount)](../../share/ThenaGammaTwapAdapter.sol#L2189)

../../share/ThenaGammaTwapAdapter.sol#L2186-L2192


 - [ ] ID-24
[ThenaGammaAdapter.constructor(address,address)](../../share/ThenaGammaTwapAdapter.sol#L2955-L2981) ignores return value by [TOKEN1.approve(address(HYPERVISOR),type()(uint256).max)](../../share/ThenaGammaTwapAdapter.sol#L2967)

../../share/ThenaGammaTwapAdapter.sol#L2955-L2981


## calls-loop
Impact: Low
Confidence: Medium
 - [ ] ID-25
[SwapExecutor.executeSwaps(IBalancer.SwapInfo[])](../../share/ThenaGammaTwapAdapter.sol#L2186-L2192) has external calls inside a loop: [IERC20(swap.token).approve(swap.callee,swap.amount)](../../share/ThenaGammaTwapAdapter.sol#L2189)

../../share/ThenaGammaTwapAdapter.sol#L2186-L2192


## timestamp
Impact: Low
Confidence: Medium
 - [ ] ID-26
[ChainLinkLib.getPrice(AggregatorV3Interface,uint256)](../../share/ThenaGammaTwapAdapter.sol#L3516-L3530) uses timestamp for comparisons
	Dangerous comparisons:
	- [(block.timestamp - updatedAt) > stalePriceInterval](../../share/ThenaGammaTwapAdapter.sol#L3521)

../../share/ThenaGammaTwapAdapter.sol#L3516-L3530


## assembly
Impact: Informational
Confidence: High
 - [ ] ID-27
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L1567-L1647) uses assembly
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L1578-L1582)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L1598-L1605)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L1612-L1621)

../../share/ThenaGammaTwapAdapter.sol#L1567-L1647


 - [ ] ID-28
[FullMath.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L3327-L3412) uses assembly
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3336-L3339)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3347-L3349)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3360-L3364)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3371-L3373)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3376-L3378)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3382-L3384)

../../share/ThenaGammaTwapAdapter.sol#L3327-L3412


 - [ ] ID-29
[Strings.toString(uint256)](../../share/ThenaGammaTwapAdapter.sol#L1869-L1889) uses assembly
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L1875-L1877)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L1881-L1883)

../../share/ThenaGammaTwapAdapter.sol#L1869-L1889


 - [ ] ID-30
[Address._revert(bytes,string)](../../share/ThenaGammaTwapAdapter.sol#L1499-L1511) uses assembly
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L1504-L1507)

../../share/ThenaGammaTwapAdapter.sol#L1499-L1511


 - [ ] ID-31
[TickMath.getTickAtSqrtRatio(uint160)](../../share/ThenaGammaTwapAdapter.sol#L3169-L3314) uses assembly
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3178-L3182)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3183-L3187)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3188-L3192)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3193-L3197)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3198-L3202)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3203-L3207)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3208-L3212)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3213-L3216)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3223-L3228)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3229-L3234)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3235-L3240)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3241-L3246)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3247-L3252)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3253-L3258)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3259-L3264)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3265-L3270)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3271-L3276)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3277-L3282)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3283-L3288)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3289-L3294)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3295-L3300)
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3301-L3305)

../../share/ThenaGammaTwapAdapter.sol#L3169-L3314


 - [ ] ID-32
[FullMath.unsafeDivRoundingUp(uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L3441-L3445) uses assembly
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3442-L3444)

../../share/ThenaGammaTwapAdapter.sol#L3441-L3445


 - [ ] ID-33
[FullMath.mulDivRoundingUp(uint256,uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L3419-L3434) uses assembly
	- [INLINE ASM](../../share/ThenaGammaTwapAdapter.sol#L3423-L3425)

../../share/ThenaGammaTwapAdapter.sol#L3419-L3434


## dead-code
Impact: Informational
Confidence: Medium
 - [ ] ID-34
[Address.verifyCallResult(bool,bytes,string)](../../share/ThenaGammaTwapAdapter.sol#L1487-L1497) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1487-L1497


 - [ ] ID-35
[SafeCast.toUint216(uint256)](../../share/ThenaGammaTwapAdapter.sol#L103-L106) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L103-L106


 - [ ] ID-36
[SafeCast.toUint248(uint256)](../../share/ThenaGammaTwapAdapter.sol#L35-L38) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L35-L38


 - [ ] ID-37
[SafeCast.toUint80(uint256)](../../share/ThenaGammaTwapAdapter.sol#L392-L395) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L392-L395


 - [ ] ID-38
[SafeCast.toUint240(uint256)](../../share/ThenaGammaTwapAdapter.sol#L52-L55) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L52-L55


 - [ ] ID-39
[Address.sendValue(address,uint256)](../../share/ThenaGammaTwapAdapter.sol#L1328-L1333) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1328-L1333


 - [ ] ID-40
[Math.ceilDiv(uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L1557-L1560) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1557-L1560


 - [ ] ID-41
[SafeCast.toInt96(int256)](../../share/ThenaGammaTwapAdapter.sol#L919-L922) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L919-L922


 - [ ] ID-42
[Address.functionCallWithValue(address,bytes,uint256)](../../share/ThenaGammaTwapAdapter.sol#L1382-L1388) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1382-L1388


 - [ ] ID-43
[SafeCast.toInt104(int256)](../../share/ThenaGammaTwapAdapter.sol#L901-L904) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L901-L904


 - [ ] ID-44
[SafeCast.toUint112(uint256)](../../share/ThenaGammaTwapAdapter.sol#L324-L327) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L324-L327


 - [ ] ID-45
[Math.log10(uint256,Math.Rounding)](../../share/ThenaGammaTwapAdapter.sol#L1808-L1813) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1808-L1813


 - [ ] ID-46
[SafeCast.toUint208(uint256)](../../share/ThenaGammaTwapAdapter.sol#L120-L123) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L120-L123


 - [ ] ID-47
[SafeCast.toInt24(int256)](../../share/ThenaGammaTwapAdapter.sol#L1081-L1084) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1081-L1084


 - [ ] ID-48
[SafeCast.toUint64(uint256)](../../share/ThenaGammaTwapAdapter.sol#L426-L429) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L426-L429


 - [ ] ID-49
[SafeCast.toUint168(uint256)](../../share/ThenaGammaTwapAdapter.sol#L205-L208) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L205-L208


 - [ ] ID-50
[SafeCast.toUint256(int256)](../../share/ThenaGammaTwapAdapter.sol#L559-L562) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L559-L562


 - [ ] ID-51
[SafeCast.toInt216(int256)](../../share/ThenaGammaTwapAdapter.sol#L649-L652) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L649-L652


 - [ ] ID-52
[FullMath.mulDivRoundingUp(uint256,uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L3419-L3434) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L3419-L3434


 - [ ] ID-53
[SafeCast.toInt248(int256)](../../share/ThenaGammaTwapAdapter.sol#L577-L580) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L577-L580


 - [ ] ID-54
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L1567-L1647) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1567-L1647


 - [ ] ID-55
[Address.functionDelegateCall(address,bytes,string)](../../share/ThenaGammaTwapAdapter.sol#L1448-L1455) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1448-L1455


 - [ ] ID-56
[SafeCast.toInt160(int256)](../../share/ThenaGammaTwapAdapter.sol#L775-L778) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L775-L778


 - [ ] ID-57
[SafeCast.toUint144(uint256)](../../share/ThenaGammaTwapAdapter.sol#L256-L259) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L256-L259


 - [ ] ID-58
[Strings.toHexString(uint256)](../../share/ThenaGammaTwapAdapter.sol#L1894-L1898) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1894-L1898


 - [ ] ID-59
[SafeCast.toInt120(int256)](../../share/ThenaGammaTwapAdapter.sol#L865-L868) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L865-L868


 - [ ] ID-60
[SafeCast.toInt184(int256)](../../share/ThenaGammaTwapAdapter.sol#L721-L724) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L721-L724


 - [ ] ID-61
[Math.sqrt(uint256,Math.Rounding)](../../share/ThenaGammaTwapAdapter.sol#L1706-L1711) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1706-L1711


 - [ ] ID-62
[Math.max(uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L1531-L1533) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1531-L1533


 - [ ] ID-63
[SafeCast.toUint128(uint256)](../../share/ThenaGammaTwapAdapter.sol#L290-L293) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L290-L293


 - [ ] ID-64
[SafeCast.toInt80(int256)](../../share/ThenaGammaTwapAdapter.sol#L955-L958) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L955-L958


 - [ ] ID-65
[SafeCast.toInt240(int256)](../../share/ThenaGammaTwapAdapter.sol#L595-L598) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L595-L598


 - [ ] ID-66
[Math.log2(uint256)](../../share/ThenaGammaTwapAdapter.sol#L1717-L1753) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1717-L1753


 - [ ] ID-67
[Math.average(uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L1546-L1549) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1546-L1549


 - [ ] ID-68
[SafeCast.toInt144(int256)](../../share/ThenaGammaTwapAdapter.sol#L811-L814) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L811-L814


 - [ ] ID-69
[SafeCast.toInt200(int256)](../../share/ThenaGammaTwapAdapter.sol#L685-L688) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L685-L688


 - [ ] ID-70
[SafeCast.toInt40(int256)](../../share/ThenaGammaTwapAdapter.sol#L1045-L1048) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1045-L1048


 - [ ] ID-71
[Math.log2(uint256,Math.Rounding)](../../share/ThenaGammaTwapAdapter.sol#L1759-L1764) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1759-L1764


 - [ ] ID-72
[SafeCast.toUint40(uint256)](../../share/ThenaGammaTwapAdapter.sol#L477-L480) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L477-L480


 - [ ] ID-73
[SafeCast.toInt224(int256)](../../share/ThenaGammaTwapAdapter.sol#L631-L634) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L631-L634


 - [ ] ID-74
[SafeCast.toInt208(int256)](../../share/ThenaGammaTwapAdapter.sol#L667-L670) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L667-L670


 - [ ] ID-75
[SafeCast.toUint72(uint256)](../../share/ThenaGammaTwapAdapter.sol#L409-L412) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L409-L412


 - [ ] ID-76
[SafeCast.toInt88(int256)](../../share/ThenaGammaTwapAdapter.sol#L937-L940) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L937-L940


 - [ ] ID-77
[Address.functionDelegateCall(address,bytes)](../../share/ThenaGammaTwapAdapter.sol#L1438-L1440) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1438-L1440


 - [ ] ID-78
[SafeERC20.safeIncreaseAllowance(IERC20,address,uint256)](../../share/ThenaGammaTwapAdapter.sol#L2034-L2041) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L2034-L2041


 - [ ] ID-79
[Math.log256(uint256)](../../share/ThenaGammaTwapAdapter.sol#L1821-L1845) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1821-L1845


 - [ ] ID-80
[SafeERC20.safePermit(IERC20Permit,address,address,uint256,uint256,uint8,bytes32,bytes32)](../../share/ThenaGammaTwapAdapter.sol#L2056-L2070) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L2056-L2070


 - [ ] ID-81
[SafeCast.toUint8(uint256)](../../share/ThenaGammaTwapAdapter.sol#L545-L548) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L545-L548


 - [ ] ID-82
[SafeERC20.safeApprove(IERC20,address,uint256)](../../share/ThenaGammaTwapAdapter.sol#L2019-L2032) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L2019-L2032


 - [ ] ID-83
[Strings.toString(uint256)](../../share/ThenaGammaTwapAdapter.sol#L1869-L1889) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1869-L1889


 - [ ] ID-84
[SafeCast.toUint24(uint256)](../../share/ThenaGammaTwapAdapter.sol#L511-L514) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L511-L514


 - [ ] ID-85
[Math.log256(uint256,Math.Rounding)](../../share/ThenaGammaTwapAdapter.sol#L1851-L1856) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1851-L1856


 - [ ] ID-86
[SafeCast.toInt128(int256)](../../share/ThenaGammaTwapAdapter.sol#L847-L850) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L847-L850


 - [ ] ID-87
[SafeERC20.safeTransferFrom(IERC20,address,address,uint256)](../../share/ThenaGammaTwapAdapter.sol#L2003-L2010) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L2003-L2010


 - [ ] ID-88
[Math.sqrt(uint256)](../../share/ThenaGammaTwapAdapter.sol#L1670-L1701) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1670-L1701


 - [ ] ID-89
[SafeCast.toInt32(int256)](../../share/ThenaGammaTwapAdapter.sol#L1063-L1066) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1063-L1066


 - [ ] ID-90
[SafeCast.toInt112(int256)](../../share/ThenaGammaTwapAdapter.sol#L883-L886) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L883-L886


 - [ ] ID-91
[TickMath.getTickAtSqrtRatio(uint160)](../../share/ThenaGammaTwapAdapter.sol#L3169-L3314) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L3169-L3314


 - [ ] ID-92
[SafeCast.toUint232(uint256)](../../share/ThenaGammaTwapAdapter.sol#L69-L72) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L69-L72


 - [ ] ID-93
[SafeCast.toInt64(int256)](../../share/ThenaGammaTwapAdapter.sol#L991-L994) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L991-L994


 - [ ] ID-94
[Address.functionStaticCall(address,bytes)](../../share/ThenaGammaTwapAdapter.sol#L1413-L1415) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1413-L1415


 - [ ] ID-95
[SafeCast.toUint104(uint256)](../../share/ThenaGammaTwapAdapter.sol#L341-L344) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L341-L344


 - [ ] ID-96
[SafeCast.toUint152(uint256)](../../share/ThenaGammaTwapAdapter.sol#L239-L242) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L239-L242


 - [ ] ID-97
[SafeCast.toInt232(int256)](../../share/ThenaGammaTwapAdapter.sol#L613-L616) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L613-L616


 - [ ] ID-98
[SafeCast.toUint224(uint256)](../../share/ThenaGammaTwapAdapter.sol#L86-L89) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L86-L89


 - [ ] ID-99
[Math.mulDiv(uint256,uint256,uint256,Math.Rounding)](../../share/ThenaGammaTwapAdapter.sol#L1652-L1663) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1652-L1663


 - [ ] ID-100
[SafeCast.toInt152(int256)](../../share/ThenaGammaTwapAdapter.sol#L793-L796) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L793-L796


 - [ ] ID-101
[SafeCast.toInt176(int256)](../../share/ThenaGammaTwapAdapter.sol#L739-L742) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L739-L742


 - [ ] ID-102
[SafeCast.toInt8(int256)](../../share/ThenaGammaTwapAdapter.sol#L1117-L1120) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1117-L1120


 - [ ] ID-103
[Math.log10(uint256)](../../share/ThenaGammaTwapAdapter.sol#L1770-L1802) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1770-L1802


 - [ ] ID-104
[SafeCast.toInt48(int256)](../../share/ThenaGammaTwapAdapter.sol#L1027-L1030) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1027-L1030


 - [ ] ID-105
[SafeCast.toUint192(uint256)](../../share/ThenaGammaTwapAdapter.sol#L154-L157) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L154-L157


 - [ ] ID-106
[SafeCast.toUint200(uint256)](../../share/ThenaGammaTwapAdapter.sol#L137-L140) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L137-L140


 - [ ] ID-107
[FullMath.unsafeDivRoundingUp(uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L3441-L3445) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L3441-L3445


 - [ ] ID-108
[SafeCast.toUint96(uint256)](../../share/ThenaGammaTwapAdapter.sol#L358-L361) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L358-L361


 - [ ] ID-109
[SafeCast.toUint184(uint256)](../../share/ThenaGammaTwapAdapter.sol#L171-L174) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L171-L174


 - [ ] ID-110
[SafeCast.toUint160(uint256)](../../share/ThenaGammaTwapAdapter.sol#L222-L225) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L222-L225


 - [ ] ID-111
[SafeCast.toUint16(uint256)](../../share/ThenaGammaTwapAdapter.sol#L528-L531) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L528-L531


 - [ ] ID-112
[SafeCast.toInt16(int256)](../../share/ThenaGammaTwapAdapter.sol#L1099-L1102) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1099-L1102


 - [ ] ID-113
[SafeCast.toInt168(int256)](../../share/ThenaGammaTwapAdapter.sol#L757-L760) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L757-L760


 - [ ] ID-114
[SafeCast.toUint176(uint256)](../../share/ThenaGammaTwapAdapter.sol#L188-L191) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L188-L191


 - [ ] ID-115
[SafeCast.toUint48(uint256)](../../share/ThenaGammaTwapAdapter.sol#L460-L463) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L460-L463


 - [ ] ID-116
[SafeERC20.safeDecreaseAllowance(IERC20,address,uint256)](../../share/ThenaGammaTwapAdapter.sol#L2043-L2054) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L2043-L2054


 - [ ] ID-117
[SafeCast.toUint56(uint256)](../../share/ThenaGammaTwapAdapter.sol#L443-L446) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L443-L446


 - [ ] ID-118
[SafeCast.toUint88(uint256)](../../share/ThenaGammaTwapAdapter.sol#L375-L378) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L375-L378


 - [ ] ID-119
[Math.min(uint256,uint256)](../../share/ThenaGammaTwapAdapter.sol#L1538-L1540) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1538-L1540


 - [ ] ID-120
[SafeCast.toInt72(int256)](../../share/ThenaGammaTwapAdapter.sol#L973-L976) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L973-L976


 - [ ] ID-121
[Address.functionStaticCall(address,bytes,string)](../../share/ThenaGammaTwapAdapter.sol#L1423-L1430) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L1423-L1430


 - [ ] ID-122
[SafeCast.toUint32(uint256)](../../share/ThenaGammaTwapAdapter.sol#L494-L497) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L494-L497


 - [ ] ID-123
[SafeCast.toUint120(uint256)](../../share/ThenaGammaTwapAdapter.sol#L307-L310) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L307-L310


 - [ ] ID-124
[SafeCast.toUint136(uint256)](../../share/ThenaGammaTwapAdapter.sol#L273-L276) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L273-L276


 - [ ] ID-125
[SafeCast.toInt136(int256)](../../share/ThenaGammaTwapAdapter.sol#L829-L832) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L829-L832


 - [ ] ID-126
[SafeCast.toInt192(int256)](../../share/ThenaGammaTwapAdapter.sol#L703-L706) is never used and should be removed

../../share/ThenaGammaTwapAdapter.sol#L703-L706


## solc-version
Impact: Informational
Confidence: High
 - [ ] ID-127
Pragma version[^0.8.19](../../share/ThenaGammaTwapAdapter.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.6.12/0.7.6/0.8.7

../../share/ThenaGammaTwapAdapter.sol#L2


 - [ ] ID-128
solc-0.8.19 is not recommended for deployment

## low-level-calls
Impact: Informational
Confidence: High
 - [ ] ID-129
Low level call in [Address.sendValue(address,uint256)](../../share/ThenaGammaTwapAdapter.sol#L1328-L1333):
	- [(success) = recipient.call{value: amount}()](../../share/ThenaGammaTwapAdapter.sol#L1331)

../../share/ThenaGammaTwapAdapter.sol#L1328-L1333


 - [ ] ID-130
Low level call in [Address.functionStaticCall(address,bytes,string)](../../share/ThenaGammaTwapAdapter.sol#L1423-L1430):
	- [(success,returndata) = target.staticcall(data)](../../share/ThenaGammaTwapAdapter.sol#L1428)

../../share/ThenaGammaTwapAdapter.sol#L1423-L1430


 - [ ] ID-131
Low level call in [Address.functionCallWithValue(address,bytes,uint256,string)](../../share/ThenaGammaTwapAdapter.sol#L1396-L1405):
	- [(success,returndata) = target.call{value: value}(data)](../../share/ThenaGammaTwapAdapter.sol#L1403)

../../share/ThenaGammaTwapAdapter.sol#L1396-L1405


 - [ ] ID-132
Low level call in [Address.functionDelegateCall(address,bytes,string)](../../share/ThenaGammaTwapAdapter.sol#L1448-L1455):
	- [(success,returndata) = target.delegatecall(data)](../../share/ThenaGammaTwapAdapter.sol#L1453)

../../share/ThenaGammaTwapAdapter.sol#L1448-L1455


## naming-convention
Impact: Informational
Confidence: High
 - [ ] ID-133
Variable [ThenaGammaAdapter.UNIPROXY](../../share/ThenaGammaTwapAdapter.sol#L2944) is not in mixedCase

../../share/ThenaGammaTwapAdapter.sol#L2944


 - [ ] ID-134
Variable [ThenaGammaAdapter.REWARD_TOKEN](../../share/ThenaGammaTwapAdapter.sol#L2948) is not in mixedCase

../../share/ThenaGammaTwapAdapter.sol#L2948


 - [ ] ID-135
Variable [ThenaGammaToken0TWAPAdapter.POOL](../../share/ThenaGammaTwapAdapter.sol#L3540) is not in mixedCase

../../share/ThenaGammaTwapAdapter.sol#L3540


 - [ ] ID-136
Variable [BaseAdapter.BALANCER](../../share/ThenaGammaTwapAdapter.sol#L2203) is not in mixedCase

../../share/ThenaGammaTwapAdapter.sol#L2203


 - [ ] ID-137
Variable [ThenaGammaAdapter.TOKEN0](../../share/ThenaGammaTwapAdapter.sol#L2946) is not in mixedCase

../../share/ThenaGammaTwapAdapter.sol#L2946


 - [ ] ID-138
Contract [_IBalancer](../../share/ThenaGammaTwapAdapter.sol#L2196-L2198) is not in CapWords

../../share/ThenaGammaTwapAdapter.sol#L2196-L2198


 - [ ] ID-139
Variable [BaseAdapter.SWAP_EXECUTOR](../../share/ThenaGammaTwapAdapter.sol#L2204) is not in mixedCase

../../share/ThenaGammaTwapAdapter.sol#L2204


 - [ ] ID-140
Variable [ThenaGammaToken0TWAPAdapter.FEED_STALE_PRICE_INTERVAL](../../share/ThenaGammaTwapAdapter.sol#L3539) is not in mixedCase

../../share/ThenaGammaTwapAdapter.sol#L3539


 - [ ] ID-141
Variable [ThenaGammaAdapter.TOKEN1](../../share/ThenaGammaTwapAdapter.sol#L2947) is not in mixedCase

../../share/ThenaGammaTwapAdapter.sol#L2947


 - [ ] ID-142
Function [_IBalancer.SWAP_EXECUTOR()](../../share/ThenaGammaTwapAdapter.sol#L2197) is not in mixedCase

../../share/ThenaGammaTwapAdapter.sol#L2197


 - [ ] ID-143
Function [IERC20Permit.DOMAIN_SEPARATOR()](../../share/ThenaGammaTwapAdapter.sol#L1980) is not in mixedCase

../../share/ThenaGammaTwapAdapter.sol#L1980


 - [ ] ID-144
Variable [ThenaGammaAdapter.PRECISION_MULTIPLIER_1](../../share/ThenaGammaTwapAdapter.sol#L2953) is not in mixedCase

../../share/ThenaGammaTwapAdapter.sol#L2953


 - [ ] ID-145
Variable [ThenaGammaAdapter.HYPERVISOR](../../share/ThenaGammaTwapAdapter.sol#L2943) is not in mixedCase

../../share/ThenaGammaTwapAdapter.sol#L2943


 - [ ] ID-146
Variable [ThenaGammaToken0TWAPAdapter.TOKEN1_PRICE_FEED](../../share/ThenaGammaTwapAdapter.sol#L3538) is not in mixedCase

../../share/ThenaGammaTwapAdapter.sol#L3538


 - [ ] ID-147
Variable [ThenaGammaAdapter.PRECISION_MULTIPLIER_0](../../share/ThenaGammaTwapAdapter.sol#L2952) is not in mixedCase

../../share/ThenaGammaTwapAdapter.sol#L2952


 - [ ] ID-148
Function [IGaugeV2.TOKEN()](../../share/ThenaGammaTwapAdapter.sol#L2308) is not in mixedCase

../../share/ThenaGammaTwapAdapter.sol#L2308


 - [ ] ID-149
Variable [ThenaGammaAdapter.GAUGE](../../share/ThenaGammaTwapAdapter.sol#L2945) is not in mixedCase

../../share/ThenaGammaTwapAdapter.sol#L2945


## similar-names
Impact: Informational
Confidence: Medium
 - [ ] ID-150
Variable [TwapUtils.convertToken0ToToken1(uint256,address,uint32).token0Amount](../../share/ThenaGammaTwapAdapter.sol#L3465) is too similar to [TwapUtils.convertToken1ToToken0(uint256,address,uint32).token1Amount](../../share/ThenaGammaTwapAdapter.sol#L3469)

../../share/ThenaGammaTwapAdapter.sol#L3465


 - [ ] ID-151
Variable [IUniswapV3PoolActions.collect(address,int24,int24,uint128,uint128).amount0Requested](../../share/ThenaGammaTwapAdapter.sol#L2540) is too similar to [IUniswapV3PoolActions.collect(address,int24,int24,uint128,uint128).amount1Requested](../../share/ThenaGammaTwapAdapter.sol#L2541)

../../share/ThenaGammaTwapAdapter.sol#L2540


 - [ ] ID-152
Variable [IHypervisor.compound(uint256[4]).baseToken0Owed](../../share/ThenaGammaTwapAdapter.sol#L2780) is too similar to [IHypervisor.compound(uint256[4]).baseToken1Owed](../../share/ThenaGammaTwapAdapter.sol#L2781)

../../share/ThenaGammaTwapAdapter.sol#L2780


 - [ ] ID-153
Variable [IUniswapV3PoolOwnerActions.collectProtocol(address,uint128,uint128).amount0Requested](../../share/ThenaGammaTwapAdapter.sol#L2614) is too similar to [IUniswapV3PoolOwnerActions.collectProtocol(address,uint128,uint128).amount1Requested](../../share/ThenaGammaTwapAdapter.sol#L2615)

../../share/ThenaGammaTwapAdapter.sol#L2614


 - [ ] ID-154
Variable [IHypervisor.compound(uint256[4]).baseToken0Owed](../../share/ThenaGammaTwapAdapter.sol#L2780) is too similar to [IHypervisor.compound().baseToken1Owed](../../share/ThenaGammaTwapAdapter.sol#L2773)

../../share/ThenaGammaTwapAdapter.sol#L2780


 - [ ] ID-155
Variable [IHypervisor.compound().limitToken0Owed](../../share/ThenaGammaTwapAdapter.sol#L2774) is too similar to [IHypervisor.compound(uint256[4]).limitToken1Owed](../../share/ThenaGammaTwapAdapter.sol#L2783)

../../share/ThenaGammaTwapAdapter.sol#L2774


 - [ ] ID-156
Variable [IUniswapV3PoolActions.collect(address,int24,int24,uint128,uint128).amount0Requested](../../share/ThenaGammaTwapAdapter.sol#L2540) is too similar to [IUniswapV3PoolOwnerActions.collectProtocol(address,uint128,uint128).amount1Requested](../../share/ThenaGammaTwapAdapter.sol#L2615)

../../share/ThenaGammaTwapAdapter.sol#L2540


 - [ ] ID-157
Variable [TwapUtils.convertToken0ToToken1(uint256,address,uint32).token0Amount](../../share/ThenaGammaTwapAdapter.sol#L3465) is too similar to [TwapUtils.convertToken0ToToken1(uint256,address,uint32).token1Amount](../../share/ThenaGammaTwapAdapter.sol#L3465)

../../share/ThenaGammaTwapAdapter.sol#L3465


 - [ ] ID-158
Variable [IHypervisor.compound().baseToken0Owed](../../share/ThenaGammaTwapAdapter.sol#L2772) is too similar to [IHypervisor.compound(uint256[4]).baseToken1Owed](../../share/ThenaGammaTwapAdapter.sol#L2781)

../../share/ThenaGammaTwapAdapter.sol#L2772


 - [ ] ID-159
Variable [IUniswapV3PoolState.positions(bytes32).tokensOwed0](../../share/ThenaGammaTwapAdapter.sol#L2436) is too similar to [IUniswapV3PoolState.positions(bytes32).tokensOwed1](../../share/ThenaGammaTwapAdapter.sol#L2437)

../../share/ThenaGammaTwapAdapter.sol#L2436


 - [ ] ID-160
Variable [IUniswapV3PoolState.positions(bytes32).feeGrowthInside0LastX128](../../share/ThenaGammaTwapAdapter.sol#L2434) is too similar to [IUniswapV3PoolState.positions(bytes32).feeGrowthInside1LastX128](../../share/ThenaGammaTwapAdapter.sol#L2435)

../../share/ThenaGammaTwapAdapter.sol#L2434


 - [ ] ID-161
Variable [ThenaGammaAdapter.PRECISION_MULTIPLIER_0](../../share/ThenaGammaTwapAdapter.sol#L2952) is too similar to [ThenaGammaAdapter.PRECISION_MULTIPLIER_1](../../share/ThenaGammaTwapAdapter.sol#L2953)

../../share/ThenaGammaTwapAdapter.sol#L2952


 - [ ] ID-162
Variable [TwapUtils.convertToken1ToToken0(uint256,address,uint32).token0Amount](../../share/ThenaGammaTwapAdapter.sol#L3469) is too similar to [TwapUtils.convertToken0ToToken1(uint256,address,uint32).token1Amount](../../share/ThenaGammaTwapAdapter.sol#L3465)

../../share/ThenaGammaTwapAdapter.sol#L3469


 - [ ] ID-163
Variable [IHypervisor.compound(uint256[4]).limitToken0Owed](../../share/ThenaGammaTwapAdapter.sol#L2782) is too similar to [IHypervisor.compound(uint256[4]).limitToken1Owed](../../share/ThenaGammaTwapAdapter.sol#L2783)

../../share/ThenaGammaTwapAdapter.sol#L2782


 - [ ] ID-164
Variable [IUniswapV3PoolState.ticks(int24).feeGrowthOutside0X128](../../share/ThenaGammaTwapAdapter.sol#L2411) is too similar to [IUniswapV3PoolState.ticks(int24).feeGrowthOutside1X128](../../share/ThenaGammaTwapAdapter.sol#L2412)

../../share/ThenaGammaTwapAdapter.sol#L2411


 - [ ] ID-165
Variable [IUniswapV3PoolOwnerActions.setFeeProtocol(uint8,uint8).feeProtocol0](../../share/ThenaGammaTwapAdapter.sol#L2604) is too similar to [IUniswapV3PoolOwnerActions.setFeeProtocol(uint8,uint8).feeProtocol1](../../share/ThenaGammaTwapAdapter.sol#L2604)

../../share/ThenaGammaTwapAdapter.sol#L2604


 - [ ] ID-166
Variable [IHypervisor.compound().baseToken0Owed](../../share/ThenaGammaTwapAdapter.sol#L2772) is too similar to [IHypervisor.compound().baseToken1Owed](../../share/ThenaGammaTwapAdapter.sol#L2773)

../../share/ThenaGammaTwapAdapter.sol#L2772


 - [ ] ID-167
Variable [TwapUtils.convertToken1ToToken0(uint256,address,uint32).token0Amount](../../share/ThenaGammaTwapAdapter.sol#L3469) is too similar to [TwapUtils.convertToken1ToToken0(uint256,address,uint32).token1Amount](../../share/ThenaGammaTwapAdapter.sol#L3469)

../../share/ThenaGammaTwapAdapter.sol#L3469


 - [ ] ID-168
Variable [IUniswapV3PoolOwnerActions.collectProtocol(address,uint128,uint128).amount0Requested](../../share/ThenaGammaTwapAdapter.sol#L2614) is too similar to [IUniswapV3PoolActions.collect(address,int24,int24,uint128,uint128).amount1Requested](../../share/ThenaGammaTwapAdapter.sol#L2541)

../../share/ThenaGammaTwapAdapter.sol#L2614


 - [ ] ID-169
Variable [IHypervisor.compound(uint256[4]).limitToken0Owed](../../share/ThenaGammaTwapAdapter.sol#L2782) is too similar to [IHypervisor.compound().limitToken1Owed](../../share/ThenaGammaTwapAdapter.sol#L2775)

../../share/ThenaGammaTwapAdapter.sol#L2782


 - [ ] ID-170
Variable [IHypervisor.compound().limitToken0Owed](../../share/ThenaGammaTwapAdapter.sol#L2774) is too similar to [IHypervisor.compound().limitToken1Owed](../../share/ThenaGammaTwapAdapter.sol#L2775)

../../share/ThenaGammaTwapAdapter.sol#L2774


## too-many-digits
Impact: Informational
Confidence: Medium
 - [ ] ID-171
[TickMath.getSqrtRatioAtTick(int24)](../../share/ThenaGammaTwapAdapter.sol#L3127-L3162) uses literals with too many digits:
	- [ratio = 0x100000000000000000000000000000000](../../share/ThenaGammaTwapAdapter.sol#L3134)

../../share/ThenaGammaTwapAdapter.sol#L3127-L3162


## unused-state
Impact: Informational
Confidence: High
 - [ ] ID-172
[TwapUtils.Q96](../../share/ThenaGammaTwapAdapter.sol#L3458) is never used in [TwapUtils](../../share/ThenaGammaTwapAdapter.sol#L3456-L3510)

../../share/ThenaGammaTwapAdapter.sol#L3458


## external-function
Impact: Optimization
Confidence: High
 - [ ] ID-173
token1Decimals() should be declared external:
	- [ThenaGammaAdapter.token1Decimals()](../../share/ThenaGammaTwapAdapter.sol#L3093-L3095)

../../share/ThenaGammaTwapAdapter.sol#L3093-L3095


 - [ ] ID-174
getTwap(address,uint32,uint8) should be declared external:
	- [TwapUtils.getTwap(address,uint32,uint8)](../../share/ThenaGammaTwapAdapter.sol#L3461-L3463)

../../share/ThenaGammaTwapAdapter.sol#L3461-L3463


 - [ ] ID-175
value() should be declared external:
	- [ThenaGammaAdapter.value()](../../share/ThenaGammaTwapAdapter.sol#L3030-L3034)

../../share/ThenaGammaTwapAdapter.sol#L3030-L3034


 - [ ] ID-176
executeSwaps(IBalancer.SwapInfo[]) should be declared external:
	- [SwapExecutor.executeSwaps(IBalancer.SwapInfo[])](../../share/ThenaGammaTwapAdapter.sol#L2186-L2192)

../../share/ThenaGammaTwapAdapter.sol#L2186-L2192


 - [ ] ID-177
convertToken1ToToken0(uint256,address,uint32) should be declared external:
	- [TwapUtils.convertToken1ToToken0(uint256,address,uint32)](../../share/ThenaGammaTwapAdapter.sol#L3469-L3471)

../../share/ThenaGammaTwapAdapter.sol#L3469-L3471


 - [ ] ID-178
convertToken0ToToken1(uint256,address,uint32) should be declared external:
	- [TwapUtils.convertToken0ToToken1(uint256,address,uint32)](../../share/ThenaGammaTwapAdapter.sol#L3465-L3467)

../../share/ThenaGammaTwapAdapter.sol#L3465-L3467


