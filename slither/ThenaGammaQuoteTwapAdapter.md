Summary
 - [divide-before-multiply](#divide-before-multiply) (17 results) (Medium)
 - [uninitialized-local](#uninitialized-local) (2 results) (Medium)
 - [unused-return](#unused-return) (6 results) (Medium)
 - [calls-loop](#calls-loop) (1 results) (Low)
 - [assembly](#assembly) (7 results) (Informational)
 - [dead-code](#dead-code) (93 results) (Informational)
 - [solc-version](#solc-version) (2 results) (Informational)
 - [low-level-calls](#low-level-calls) (4 results) (Informational)
 - [naming-convention](#naming-convention) (15 results) (Informational)
 - [similar-names](#similar-names) (21 results) (Informational)
 - [too-many-digits](#too-many-digits) (1 results) (Informational)
 - [unused-state](#unused-state) (1 results) (Informational)
 - [external-function](#external-function) (7 results) (Optimization)
## divide-before-multiply
Impact: Medium
Confidence: Medium
 - [ ] ID-0
[FullMath.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L229-L314) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaQuoteTwapAdapter.sol#L274)
	-[inv *= 2 - denominator * inv](../../share/ThenaGammaQuoteTwapAdapter.sol#L300)

../../share/ThenaGammaQuoteTwapAdapter.sol#L229-L314


 - [ ] ID-1
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1947-L2027) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaQuoteTwapAdapter.sol#L1994)
	-[inverse *= 2 - denominator * inverse](../../share/ThenaGammaQuoteTwapAdapter.sol#L2016)

../../share/ThenaGammaQuoteTwapAdapter.sol#L1947-L2027


 - [ ] ID-2
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1947-L2027) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaQuoteTwapAdapter.sol#L1994)
	-[inverse *= 2 - denominator * inverse](../../share/ThenaGammaQuoteTwapAdapter.sol#L2014)

../../share/ThenaGammaQuoteTwapAdapter.sol#L1947-L2027


 - [ ] ID-3
[FullMath.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L229-L314) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaQuoteTwapAdapter.sol#L274)
	-[inv = (3 * denominator) ^ 2](../../share/ThenaGammaQuoteTwapAdapter.sol#L294)

../../share/ThenaGammaQuoteTwapAdapter.sol#L229-L314


 - [ ] ID-4
[FullMath.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L229-L314) performs a multiplication on the result of a division:
	-[prod0 = prod0 / twos](../../share/ThenaGammaQuoteTwapAdapter.sol#L279)
	-[result = prod0 * inv](../../share/ThenaGammaQuoteTwapAdapter.sol#L311)

../../share/ThenaGammaQuoteTwapAdapter.sol#L229-L314


 - [ ] ID-5
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1947-L2027) performs a multiplication on the result of a division:
	-[prod0 = prod0 / twos](../../share/ThenaGammaQuoteTwapAdapter.sol#L1997)
	-[result = prod0 * inverse](../../share/ThenaGammaQuoteTwapAdapter.sol#L2024)

../../share/ThenaGammaQuoteTwapAdapter.sol#L1947-L2027


 - [ ] ID-6
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1947-L2027) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaQuoteTwapAdapter.sol#L1994)
	-[inverse = (3 * denominator) ^ 2](../../share/ThenaGammaQuoteTwapAdapter.sol#L2009)

../../share/ThenaGammaQuoteTwapAdapter.sol#L1947-L2027


 - [ ] ID-7
[FullMath.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L229-L314) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaQuoteTwapAdapter.sol#L274)
	-[inv *= 2 - denominator * inv](../../share/ThenaGammaQuoteTwapAdapter.sol#L302)

../../share/ThenaGammaQuoteTwapAdapter.sol#L229-L314


 - [ ] ID-8
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1947-L2027) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaQuoteTwapAdapter.sol#L1994)
	-[inverse *= 2 - denominator * inverse](../../share/ThenaGammaQuoteTwapAdapter.sol#L2015)

../../share/ThenaGammaQuoteTwapAdapter.sol#L1947-L2027


 - [ ] ID-9
[FullMath.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L229-L314) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaQuoteTwapAdapter.sol#L274)
	-[inv *= 2 - denominator * inv](../../share/ThenaGammaQuoteTwapAdapter.sol#L298)

../../share/ThenaGammaQuoteTwapAdapter.sol#L229-L314


 - [ ] ID-10
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1947-L2027) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaQuoteTwapAdapter.sol#L1994)
	-[inverse *= 2 - denominator * inverse](../../share/ThenaGammaQuoteTwapAdapter.sol#L2013)

../../share/ThenaGammaQuoteTwapAdapter.sol#L1947-L2027


 - [ ] ID-11
[FullMath.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L229-L314) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaQuoteTwapAdapter.sol#L274)
	-[inv *= 2 - denominator * inv](../../share/ThenaGammaQuoteTwapAdapter.sol#L301)

../../share/ThenaGammaQuoteTwapAdapter.sol#L229-L314


 - [ ] ID-12
[FullMath.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L229-L314) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaQuoteTwapAdapter.sol#L274)
	-[inv *= 2 - denominator * inv](../../share/ThenaGammaQuoteTwapAdapter.sol#L303)

../../share/ThenaGammaQuoteTwapAdapter.sol#L229-L314


 - [ ] ID-13
[FullMath.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L229-L314) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaQuoteTwapAdapter.sol#L274)
	-[inv *= 2 - denominator * inv](../../share/ThenaGammaQuoteTwapAdapter.sol#L299)

../../share/ThenaGammaQuoteTwapAdapter.sol#L229-L314


 - [ ] ID-14
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1947-L2027) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaQuoteTwapAdapter.sol#L1994)
	-[inverse *= 2 - denominator * inverse](../../share/ThenaGammaQuoteTwapAdapter.sol#L2018)

../../share/ThenaGammaQuoteTwapAdapter.sol#L1947-L2027


 - [ ] ID-15
[LiquidityUtils.ratio2(uint256,uint256,uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L3300-L3315) performs a multiplication on the result of a division:
	-[d1 = d0 * reserve1 / reserve0](../../share/ThenaGammaQuoteTwapAdapter.sol#L3309)
	-[d0 = d1 * reserve0 / reserve1](../../share/ThenaGammaQuoteTwapAdapter.sol#L3313)

../../share/ThenaGammaQuoteTwapAdapter.sol#L3300-L3315


 - [ ] ID-16
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1947-L2027) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaQuoteTwapAdapter.sol#L1994)
	-[inverse *= 2 - denominator * inverse](../../share/ThenaGammaQuoteTwapAdapter.sol#L2017)

../../share/ThenaGammaQuoteTwapAdapter.sol#L1947-L2027


## uninitialized-local
Impact: Medium
Confidence: Medium
 - [ ] ID-17
[ThenaGammaAdapter._invest().minIn](../../share/ThenaGammaQuoteTwapAdapter.sol#L3381) is a local variable never initialized

../../share/ThenaGammaQuoteTwapAdapter.sol#L3381


 - [ ] ID-18
[ThenaGammaAdapter._redeem(uint256,address).minAmounts](../../share/ThenaGammaQuoteTwapAdapter.sol#L3396) is a local variable never initialized

../../share/ThenaGammaQuoteTwapAdapter.sol#L3396


## unused-return
Impact: Medium
Confidence: Medium
 - [ ] ID-19
[ThenaGammaAdapter.constructor(address,address)](../../share/ThenaGammaQuoteTwapAdapter.sol#L3335-L3361) ignores return value by [HYPERVISOR.approve(_gauge,type()(uint256).max)](../../share/ThenaGammaQuoteTwapAdapter.sol#L3348)

../../share/ThenaGammaQuoteTwapAdapter.sol#L3335-L3361


 - [ ] ID-20
[ThenaGammaAdapter.constructor(address,address)](../../share/ThenaGammaQuoteTwapAdapter.sol#L3335-L3361) ignores return value by [TOKEN0.approve(address(HYPERVISOR),type()(uint256).max)](../../share/ThenaGammaQuoteTwapAdapter.sol#L3346)

../../share/ThenaGammaQuoteTwapAdapter.sol#L3335-L3361


 - [ ] ID-21
[ThenaGammaAdapter.constructor(address,address)](../../share/ThenaGammaQuoteTwapAdapter.sol#L3335-L3361) ignores return value by [TOKEN1.approve(address(HYPERVISOR),type()(uint256).max)](../../share/ThenaGammaQuoteTwapAdapter.sol#L3347)

../../share/ThenaGammaQuoteTwapAdapter.sol#L3335-L3361


 - [ ] ID-22
[SwapExecutor.executeSwaps(IBalancer.SwapInfo[])](../../share/ThenaGammaQuoteTwapAdapter.sol#L2566-L2572) ignores return value by [IERC20(swap.token).approve(swap.callee,swap.amount)](../../share/ThenaGammaQuoteTwapAdapter.sol#L2569)

../../share/ThenaGammaQuoteTwapAdapter.sol#L2566-L2572


 - [ ] ID-23
[SwapExecutor.executeSwaps(IBalancer.SwapInfo[])](../../share/ThenaGammaQuoteTwapAdapter.sol#L2566-L2572) ignores return value by [Address.functionCall(swap.callee,swap.data)](../../share/ThenaGammaQuoteTwapAdapter.sol#L2570)

../../share/ThenaGammaQuoteTwapAdapter.sol#L2566-L2572


 - [ ] ID-24
[ThenaGammaAdapter._invest()](../../share/ThenaGammaQuoteTwapAdapter.sol#L3363-L3388) ignores return value by [UNIPROXY.deposit(deposit0,deposit1,address(this),address(HYPERVISOR),minIn)](../../share/ThenaGammaQuoteTwapAdapter.sol#L3383)

../../share/ThenaGammaQuoteTwapAdapter.sol#L3363-L3388


## calls-loop
Impact: Low
Confidence: Medium
 - [ ] ID-25
[SwapExecutor.executeSwaps(IBalancer.SwapInfo[])](../../share/ThenaGammaQuoteTwapAdapter.sol#L2566-L2572) has external calls inside a loop: [IERC20(swap.token).approve(swap.callee,swap.amount)](../../share/ThenaGammaQuoteTwapAdapter.sol#L2569)

../../share/ThenaGammaQuoteTwapAdapter.sol#L2566-L2572


## assembly
Impact: Informational
Confidence: High
 - [ ] ID-26
[FullMath.mulDivRoundingUp(uint256,uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L321-L336) uses assembly
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L325-L327)

../../share/ThenaGammaQuoteTwapAdapter.sol#L321-L336


 - [ ] ID-27
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1947-L2027) uses assembly
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L1958-L1962)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L1978-L1985)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L1992-L2001)

../../share/ThenaGammaQuoteTwapAdapter.sol#L1947-L2027


 - [ ] ID-28
[Strings.toString(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L2249-L2269) uses assembly
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L2255-L2257)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L2261-L2263)

../../share/ThenaGammaQuoteTwapAdapter.sol#L2249-L2269


 - [ ] ID-29
[TickMath.getTickAtSqrtRatio(uint160)](../../share/ThenaGammaQuoteTwapAdapter.sol#L71-L216) uses assembly
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L80-L84)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L85-L89)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L90-L94)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L95-L99)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L100-L104)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L105-L109)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L110-L114)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L115-L118)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L125-L130)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L131-L136)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L137-L142)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L143-L148)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L149-L154)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L155-L160)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L161-L166)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L167-L172)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L173-L178)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L179-L184)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L185-L190)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L191-L196)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L197-L202)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L203-L207)

../../share/ThenaGammaQuoteTwapAdapter.sol#L71-L216


 - [ ] ID-30
[Address._revert(bytes,string)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1879-L1891) uses assembly
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L1884-L1887)

../../share/ThenaGammaQuoteTwapAdapter.sol#L1879-L1891


 - [ ] ID-31
[FullMath.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L229-L314) uses assembly
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L238-L241)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L249-L251)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L262-L266)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L273-L275)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L278-L280)
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L284-L286)

../../share/ThenaGammaQuoteTwapAdapter.sol#L229-L314


 - [ ] ID-32
[FullMath.unsafeDivRoundingUp(uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L343-L347) uses assembly
	- [INLINE ASM](../../share/ThenaGammaQuoteTwapAdapter.sol#L344-L346)

../../share/ThenaGammaQuoteTwapAdapter.sol#L343-L347


## dead-code
Impact: Informational
Confidence: Medium
 - [ ] ID-33
[Address.verifyCallResult(bool,bytes,string)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1867-L1877) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1867-L1877


 - [ ] ID-34
[SafeCast.toUint216(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L449-L452) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L449-L452


 - [ ] ID-35
[SafeCast.toUint248(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L381-L384) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L381-L384


 - [ ] ID-36
[SafeCast.toUint80(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L738-L741) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L738-L741


 - [ ] ID-37
[SafeCast.toUint240(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L398-L401) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L398-L401


 - [ ] ID-38
[Address.sendValue(address,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1708-L1713) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1708-L1713


 - [ ] ID-39
[Math.ceilDiv(uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1937-L1940) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1937-L1940


 - [ ] ID-40
[SafeCast.toInt96(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1265-L1268) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1265-L1268


 - [ ] ID-41
[Address.functionCallWithValue(address,bytes,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1762-L1768) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1762-L1768


 - [ ] ID-42
[SafeCast.toInt104(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1247-L1250) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1247-L1250


 - [ ] ID-43
[SafeCast.toUint112(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L670-L673) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L670-L673


 - [ ] ID-44
[Math.log10(uint256,Math.Rounding)](../../share/ThenaGammaQuoteTwapAdapter.sol#L2188-L2193) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L2188-L2193


 - [ ] ID-45
[SafeCast.toUint208(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L466-L469) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L466-L469


 - [ ] ID-46
[SafeCast.toInt24(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1427-L1430) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1427-L1430


 - [ ] ID-47
[SafeCast.toUint64(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L772-L775) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L772-L775


 - [ ] ID-48
[SafeCast.toUint168(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L551-L554) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L551-L554


 - [ ] ID-49
[SafeCast.toUint256(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L905-L908) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L905-L908


 - [ ] ID-50
[SafeCast.toInt216(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L995-L998) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L995-L998


 - [ ] ID-51
[FullMath.mulDivRoundingUp(uint256,uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L321-L336) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L321-L336


 - [ ] ID-52
[SafeCast.toInt248(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L923-L926) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L923-L926


 - [ ] ID-53
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1947-L2027) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1947-L2027


 - [ ] ID-54
[Address.functionDelegateCall(address,bytes,string)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1828-L1835) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1828-L1835


 - [ ] ID-55
[SafeCast.toInt160(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1121-L1124) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1121-L1124


 - [ ] ID-56
[SafeCast.toUint144(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L602-L605) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L602-L605


 - [ ] ID-57
[Strings.toHexString(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L2274-L2278) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L2274-L2278


 - [ ] ID-58
[SafeCast.toInt120(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1211-L1214) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1211-L1214


 - [ ] ID-59
[SafeCast.toInt184(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1067-L1070) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1067-L1070


 - [ ] ID-60
[Math.sqrt(uint256,Math.Rounding)](../../share/ThenaGammaQuoteTwapAdapter.sol#L2086-L2091) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L2086-L2091


 - [ ] ID-61
[Math.max(uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1911-L1913) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1911-L1913


 - [ ] ID-62
[SafeCast.toUint128(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L636-L639) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L636-L639


 - [ ] ID-63
[SafeCast.toInt80(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1301-L1304) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1301-L1304


 - [ ] ID-64
[SafeCast.toInt240(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L941-L944) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L941-L944


 - [ ] ID-65
[Math.log2(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L2097-L2133) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L2097-L2133


 - [ ] ID-66
[Math.average(uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1926-L1929) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1926-L1929


 - [ ] ID-67
[SafeCast.toInt144(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1157-L1160) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1157-L1160


 - [ ] ID-68
[SafeCast.toInt200(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1031-L1034) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1031-L1034


 - [ ] ID-69
[SafeCast.toInt40(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1391-L1394) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1391-L1394


 - [ ] ID-70
[Math.log2(uint256,Math.Rounding)](../../share/ThenaGammaQuoteTwapAdapter.sol#L2139-L2144) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L2139-L2144


 - [ ] ID-71
[SafeCast.toUint40(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L823-L826) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L823-L826


 - [ ] ID-72
[SafeCast.toInt224(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L977-L980) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L977-L980


 - [ ] ID-73
[SafeCast.toInt208(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1013-L1016) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1013-L1016


 - [ ] ID-74
[SafeCast.toUint72(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L755-L758) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L755-L758


 - [ ] ID-75
[SafeCast.toInt88(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1283-L1286) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1283-L1286


 - [ ] ID-76
[Address.functionDelegateCall(address,bytes)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1818-L1820) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1818-L1820


 - [ ] ID-77
[SafeERC20.safeIncreaseAllowance(IERC20,address,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L2414-L2421) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L2414-L2421


 - [ ] ID-78
[Math.log256(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L2201-L2225) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L2201-L2225


 - [ ] ID-79
[SafeERC20.safePermit(IERC20Permit,address,address,uint256,uint256,uint8,bytes32,bytes32)](../../share/ThenaGammaQuoteTwapAdapter.sol#L2436-L2450) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L2436-L2450


 - [ ] ID-80
[SafeCast.toUint8(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L891-L894) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L891-L894


 - [ ] ID-81
[SafeERC20.safeApprove(IERC20,address,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L2399-L2412) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L2399-L2412


 - [ ] ID-82
[Strings.toString(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L2249-L2269) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L2249-L2269


 - [ ] ID-83
[SafeCast.toUint24(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L857-L860) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L857-L860


 - [ ] ID-84
[Math.log256(uint256,Math.Rounding)](../../share/ThenaGammaQuoteTwapAdapter.sol#L2231-L2236) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L2231-L2236


 - [ ] ID-85
[SafeCast.toInt128(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1193-L1196) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1193-L1196


 - [ ] ID-86
[SafeERC20.safeTransferFrom(IERC20,address,address,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L2383-L2390) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L2383-L2390


 - [ ] ID-87
[Math.sqrt(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L2050-L2081) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L2050-L2081


 - [ ] ID-88
[SafeCast.toInt32(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1409-L1412) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1409-L1412


 - [ ] ID-89
[SafeCast.toInt112(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1229-L1232) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1229-L1232


 - [ ] ID-90
[TickMath.getTickAtSqrtRatio(uint160)](../../share/ThenaGammaQuoteTwapAdapter.sol#L71-L216) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L71-L216


 - [ ] ID-91
[SafeCast.toUint232(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L415-L418) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L415-L418


 - [ ] ID-92
[SafeCast.toInt64(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1337-L1340) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1337-L1340


 - [ ] ID-93
[Address.functionStaticCall(address,bytes)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1793-L1795) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1793-L1795


 - [ ] ID-94
[SafeCast.toUint104(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L687-L690) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L687-L690


 - [ ] ID-95
[SafeCast.toUint152(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L585-L588) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L585-L588


 - [ ] ID-96
[SafeCast.toInt232(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L959-L962) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L959-L962


 - [ ] ID-97
[SafeCast.toUint224(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L432-L435) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L432-L435


 - [ ] ID-98
[Math.mulDiv(uint256,uint256,uint256,Math.Rounding)](../../share/ThenaGammaQuoteTwapAdapter.sol#L2032-L2043) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L2032-L2043


 - [ ] ID-99
[SafeCast.toInt152(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1139-L1142) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1139-L1142


 - [ ] ID-100
[SafeCast.toInt176(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1085-L1088) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1085-L1088


 - [ ] ID-101
[SafeCast.toInt8(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1463-L1466) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1463-L1466


 - [ ] ID-102
[Math.log10(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L2150-L2182) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L2150-L2182


 - [ ] ID-103
[SafeCast.toInt48(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1373-L1376) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1373-L1376


 - [ ] ID-104
[SafeCast.toUint192(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L500-L503) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L500-L503


 - [ ] ID-105
[SafeCast.toUint200(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L483-L486) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L483-L486


 - [ ] ID-106
[FullMath.unsafeDivRoundingUp(uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L343-L347) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L343-L347


 - [ ] ID-107
[SafeCast.toUint96(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L704-L707) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L704-L707


 - [ ] ID-108
[SafeCast.toUint184(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L517-L520) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L517-L520


 - [ ] ID-109
[SafeCast.toUint160(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L568-L571) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L568-L571


 - [ ] ID-110
[SafeCast.toUint16(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L874-L877) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L874-L877


 - [ ] ID-111
[SafeCast.toInt16(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1445-L1448) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1445-L1448


 - [ ] ID-112
[SafeCast.toInt168(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1103-L1106) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1103-L1106


 - [ ] ID-113
[SafeCast.toUint176(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L534-L537) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L534-L537


 - [ ] ID-114
[SafeCast.toUint48(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L806-L809) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L806-L809


 - [ ] ID-115
[SafeERC20.safeDecreaseAllowance(IERC20,address,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L2423-L2434) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L2423-L2434


 - [ ] ID-116
[SafeCast.toUint56(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L789-L792) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L789-L792


 - [ ] ID-117
[SafeCast.toUint88(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L721-L724) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L721-L724


 - [ ] ID-118
[Math.min(uint256,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1918-L1920) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1918-L1920


 - [ ] ID-119
[SafeCast.toInt72(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1319-L1322) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1319-L1322


 - [ ] ID-120
[Address.functionStaticCall(address,bytes,string)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1803-L1810) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1803-L1810


 - [ ] ID-121
[SafeCast.toUint32(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L840-L843) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L840-L843


 - [ ] ID-122
[SafeCast.toUint120(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L653-L656) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L653-L656


 - [ ] ID-123
[SafeCast.toUint136(uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L619-L622) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L619-L622


 - [ ] ID-124
[SafeCast.toInt136(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1175-L1178) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1175-L1178


 - [ ] ID-125
[SafeCast.toInt192(int256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1049-L1052) is never used and should be removed

../../share/ThenaGammaQuoteTwapAdapter.sol#L1049-L1052


## solc-version
Impact: Informational
Confidence: High
 - [ ] ID-126
Pragma version[^0.8.19](../../share/ThenaGammaQuoteTwapAdapter.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.6.12/0.7.6/0.8.7

../../share/ThenaGammaQuoteTwapAdapter.sol#L2


 - [ ] ID-127
solc-0.8.19 is not recommended for deployment

## low-level-calls
Impact: Informational
Confidence: High
 - [ ] ID-128
Low level call in [Address.functionDelegateCall(address,bytes,string)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1828-L1835):
	- [(success,returndata) = target.delegatecall(data)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1833)

../../share/ThenaGammaQuoteTwapAdapter.sol#L1828-L1835


 - [ ] ID-129
Low level call in [Address.sendValue(address,uint256)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1708-L1713):
	- [(success) = recipient.call{value: amount}()](../../share/ThenaGammaQuoteTwapAdapter.sol#L1711)

../../share/ThenaGammaQuoteTwapAdapter.sol#L1708-L1713


 - [ ] ID-130
Low level call in [Address.functionStaticCall(address,bytes,string)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1803-L1810):
	- [(success,returndata) = target.staticcall(data)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1808)

../../share/ThenaGammaQuoteTwapAdapter.sol#L1803-L1810


 - [ ] ID-131
Low level call in [Address.functionCallWithValue(address,bytes,uint256,string)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1776-L1785):
	- [(success,returndata) = target.call{value: value}(data)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1783)

../../share/ThenaGammaQuoteTwapAdapter.sol#L1776-L1785


## naming-convention
Impact: Informational
Confidence: High
 - [ ] ID-132
Variable [ThenaGammaAdapter.UNIPROXY](../../share/ThenaGammaQuoteTwapAdapter.sol#L3324) is not in mixedCase

../../share/ThenaGammaQuoteTwapAdapter.sol#L3324


 - [ ] ID-133
Variable [ThenaGammaQuoteTwapAdapter.POOL](../../share/ThenaGammaQuoteTwapAdapter.sol#L3483) is not in mixedCase

../../share/ThenaGammaQuoteTwapAdapter.sol#L3483


 - [ ] ID-134
Variable [ThenaGammaAdapter.REWARD_TOKEN](../../share/ThenaGammaQuoteTwapAdapter.sol#L3328) is not in mixedCase

../../share/ThenaGammaQuoteTwapAdapter.sol#L3328


 - [ ] ID-135
Variable [BaseAdapter.BALANCER](../../share/ThenaGammaQuoteTwapAdapter.sol#L2583) is not in mixedCase

../../share/ThenaGammaQuoteTwapAdapter.sol#L2583


 - [ ] ID-136
Variable [ThenaGammaAdapter.TOKEN0](../../share/ThenaGammaQuoteTwapAdapter.sol#L3326) is not in mixedCase

../../share/ThenaGammaQuoteTwapAdapter.sol#L3326


 - [ ] ID-137
Contract [_IBalancer](../../share/ThenaGammaQuoteTwapAdapter.sol#L2576-L2578) is not in CapWords

../../share/ThenaGammaQuoteTwapAdapter.sol#L2576-L2578


 - [ ] ID-138
Variable [BaseAdapter.SWAP_EXECUTOR](../../share/ThenaGammaQuoteTwapAdapter.sol#L2584) is not in mixedCase

../../share/ThenaGammaQuoteTwapAdapter.sol#L2584


 - [ ] ID-139
Variable [ThenaGammaAdapter.TOKEN1](../../share/ThenaGammaQuoteTwapAdapter.sol#L3327) is not in mixedCase

../../share/ThenaGammaQuoteTwapAdapter.sol#L3327


 - [ ] ID-140
Function [_IBalancer.SWAP_EXECUTOR()](../../share/ThenaGammaQuoteTwapAdapter.sol#L2577) is not in mixedCase

../../share/ThenaGammaQuoteTwapAdapter.sol#L2577


 - [ ] ID-141
Function [IERC20Permit.DOMAIN_SEPARATOR()](../../share/ThenaGammaQuoteTwapAdapter.sol#L2360) is not in mixedCase

../../share/ThenaGammaQuoteTwapAdapter.sol#L2360


 - [ ] ID-142
Variable [ThenaGammaAdapter.PRECISION_MULTIPLIER_1](../../share/ThenaGammaQuoteTwapAdapter.sol#L3333) is not in mixedCase

../../share/ThenaGammaQuoteTwapAdapter.sol#L3333


 - [ ] ID-143
Variable [ThenaGammaAdapter.HYPERVISOR](../../share/ThenaGammaQuoteTwapAdapter.sol#L3323) is not in mixedCase

../../share/ThenaGammaQuoteTwapAdapter.sol#L3323


 - [ ] ID-144
Variable [ThenaGammaAdapter.PRECISION_MULTIPLIER_0](../../share/ThenaGammaQuoteTwapAdapter.sol#L3332) is not in mixedCase

../../share/ThenaGammaQuoteTwapAdapter.sol#L3332


 - [ ] ID-145
Function [IGaugeV2.TOKEN()](../../share/ThenaGammaQuoteTwapAdapter.sol#L2688) is not in mixedCase

../../share/ThenaGammaQuoteTwapAdapter.sol#L2688


 - [ ] ID-146
Variable [ThenaGammaAdapter.GAUGE](../../share/ThenaGammaQuoteTwapAdapter.sol#L3325) is not in mixedCase

../../share/ThenaGammaQuoteTwapAdapter.sol#L3325


## similar-names
Impact: Informational
Confidence: Medium
 - [ ] ID-147
Variable [TwapUtils.convertToken0ToToken1(uint256,address,uint32).token0Amount](../../share/ThenaGammaQuoteTwapAdapter.sol#L1501) is too similar to [TwapUtils.convertToken1ToToken0(uint256,address,uint32).token1Amount](../../share/ThenaGammaQuoteTwapAdapter.sol#L1505)

../../share/ThenaGammaQuoteTwapAdapter.sol#L1501


 - [ ] ID-148
Variable [IUniswapV3PoolActions.collect(address,int24,int24,uint128,uint128).amount0Requested](../../share/ThenaGammaQuoteTwapAdapter.sol#L2920) is too similar to [IUniswapV3PoolActions.collect(address,int24,int24,uint128,uint128).amount1Requested](../../share/ThenaGammaQuoteTwapAdapter.sol#L2921)

../../share/ThenaGammaQuoteTwapAdapter.sol#L2920


 - [ ] ID-149
Variable [IHypervisor.compound(uint256[4]).baseToken0Owed](../../share/ThenaGammaQuoteTwapAdapter.sol#L3160) is too similar to [IHypervisor.compound(uint256[4]).baseToken1Owed](../../share/ThenaGammaQuoteTwapAdapter.sol#L3161)

../../share/ThenaGammaQuoteTwapAdapter.sol#L3160


 - [ ] ID-150
Variable [IUniswapV3PoolOwnerActions.collectProtocol(address,uint128,uint128).amount0Requested](../../share/ThenaGammaQuoteTwapAdapter.sol#L2994) is too similar to [IUniswapV3PoolOwnerActions.collectProtocol(address,uint128,uint128).amount1Requested](../../share/ThenaGammaQuoteTwapAdapter.sol#L2995)

../../share/ThenaGammaQuoteTwapAdapter.sol#L2994


 - [ ] ID-151
Variable [IHypervisor.compound(uint256[4]).baseToken0Owed](../../share/ThenaGammaQuoteTwapAdapter.sol#L3160) is too similar to [IHypervisor.compound().baseToken1Owed](../../share/ThenaGammaQuoteTwapAdapter.sol#L3153)

../../share/ThenaGammaQuoteTwapAdapter.sol#L3160


 - [ ] ID-152
Variable [IHypervisor.compound().limitToken0Owed](../../share/ThenaGammaQuoteTwapAdapter.sol#L3154) is too similar to [IHypervisor.compound(uint256[4]).limitToken1Owed](../../share/ThenaGammaQuoteTwapAdapter.sol#L3163)

../../share/ThenaGammaQuoteTwapAdapter.sol#L3154


 - [ ] ID-153
Variable [IUniswapV3PoolActions.collect(address,int24,int24,uint128,uint128).amount0Requested](../../share/ThenaGammaQuoteTwapAdapter.sol#L2920) is too similar to [IUniswapV3PoolOwnerActions.collectProtocol(address,uint128,uint128).amount1Requested](../../share/ThenaGammaQuoteTwapAdapter.sol#L2995)

../../share/ThenaGammaQuoteTwapAdapter.sol#L2920


 - [ ] ID-154
Variable [TwapUtils.convertToken0ToToken1(uint256,address,uint32).token0Amount](../../share/ThenaGammaQuoteTwapAdapter.sol#L1501) is too similar to [TwapUtils.convertToken0ToToken1(uint256,address,uint32).token1Amount](../../share/ThenaGammaQuoteTwapAdapter.sol#L1501)

../../share/ThenaGammaQuoteTwapAdapter.sol#L1501


 - [ ] ID-155
Variable [IHypervisor.compound().baseToken0Owed](../../share/ThenaGammaQuoteTwapAdapter.sol#L3152) is too similar to [IHypervisor.compound(uint256[4]).baseToken1Owed](../../share/ThenaGammaQuoteTwapAdapter.sol#L3161)

../../share/ThenaGammaQuoteTwapAdapter.sol#L3152


 - [ ] ID-156
Variable [IUniswapV3PoolState.positions(bytes32).tokensOwed0](../../share/ThenaGammaQuoteTwapAdapter.sol#L2816) is too similar to [IUniswapV3PoolState.positions(bytes32).tokensOwed1](../../share/ThenaGammaQuoteTwapAdapter.sol#L2817)

../../share/ThenaGammaQuoteTwapAdapter.sol#L2816


 - [ ] ID-157
Variable [IUniswapV3PoolState.positions(bytes32).feeGrowthInside0LastX128](../../share/ThenaGammaQuoteTwapAdapter.sol#L2814) is too similar to [IUniswapV3PoolState.positions(bytes32).feeGrowthInside1LastX128](../../share/ThenaGammaQuoteTwapAdapter.sol#L2815)

../../share/ThenaGammaQuoteTwapAdapter.sol#L2814


 - [ ] ID-158
Variable [ThenaGammaAdapter.PRECISION_MULTIPLIER_0](../../share/ThenaGammaQuoteTwapAdapter.sol#L3332) is too similar to [ThenaGammaAdapter.PRECISION_MULTIPLIER_1](../../share/ThenaGammaQuoteTwapAdapter.sol#L3333)

../../share/ThenaGammaQuoteTwapAdapter.sol#L3332


 - [ ] ID-159
Variable [TwapUtils.convertToken1ToToken0(uint256,address,uint32).token0Amount](../../share/ThenaGammaQuoteTwapAdapter.sol#L1505) is too similar to [TwapUtils.convertToken0ToToken1(uint256,address,uint32).token1Amount](../../share/ThenaGammaQuoteTwapAdapter.sol#L1501)

../../share/ThenaGammaQuoteTwapAdapter.sol#L1505


 - [ ] ID-160
Variable [IHypervisor.compound(uint256[4]).limitToken0Owed](../../share/ThenaGammaQuoteTwapAdapter.sol#L3162) is too similar to [IHypervisor.compound(uint256[4]).limitToken1Owed](../../share/ThenaGammaQuoteTwapAdapter.sol#L3163)

../../share/ThenaGammaQuoteTwapAdapter.sol#L3162


 - [ ] ID-161
Variable [IUniswapV3PoolState.ticks(int24).feeGrowthOutside0X128](../../share/ThenaGammaQuoteTwapAdapter.sol#L2791) is too similar to [IUniswapV3PoolState.ticks(int24).feeGrowthOutside1X128](../../share/ThenaGammaQuoteTwapAdapter.sol#L2792)

../../share/ThenaGammaQuoteTwapAdapter.sol#L2791


 - [ ] ID-162
Variable [IUniswapV3PoolOwnerActions.setFeeProtocol(uint8,uint8).feeProtocol0](../../share/ThenaGammaQuoteTwapAdapter.sol#L2984) is too similar to [IUniswapV3PoolOwnerActions.setFeeProtocol(uint8,uint8).feeProtocol1](../../share/ThenaGammaQuoteTwapAdapter.sol#L2984)

../../share/ThenaGammaQuoteTwapAdapter.sol#L2984


 - [ ] ID-163
Variable [IHypervisor.compound().baseToken0Owed](../../share/ThenaGammaQuoteTwapAdapter.sol#L3152) is too similar to [IHypervisor.compound().baseToken1Owed](../../share/ThenaGammaQuoteTwapAdapter.sol#L3153)

../../share/ThenaGammaQuoteTwapAdapter.sol#L3152


 - [ ] ID-164
Variable [TwapUtils.convertToken1ToToken0(uint256,address,uint32).token0Amount](../../share/ThenaGammaQuoteTwapAdapter.sol#L1505) is too similar to [TwapUtils.convertToken1ToToken0(uint256,address,uint32).token1Amount](../../share/ThenaGammaQuoteTwapAdapter.sol#L1505)

../../share/ThenaGammaQuoteTwapAdapter.sol#L1505


 - [ ] ID-165
Variable [IUniswapV3PoolOwnerActions.collectProtocol(address,uint128,uint128).amount0Requested](../../share/ThenaGammaQuoteTwapAdapter.sol#L2994) is too similar to [IUniswapV3PoolActions.collect(address,int24,int24,uint128,uint128).amount1Requested](../../share/ThenaGammaQuoteTwapAdapter.sol#L2921)

../../share/ThenaGammaQuoteTwapAdapter.sol#L2994


 - [ ] ID-166
Variable [IHypervisor.compound(uint256[4]).limitToken0Owed](../../share/ThenaGammaQuoteTwapAdapter.sol#L3162) is too similar to [IHypervisor.compound().limitToken1Owed](../../share/ThenaGammaQuoteTwapAdapter.sol#L3155)

../../share/ThenaGammaQuoteTwapAdapter.sol#L3162


 - [ ] ID-167
Variable [IHypervisor.compound().limitToken0Owed](../../share/ThenaGammaQuoteTwapAdapter.sol#L3154) is too similar to [IHypervisor.compound().limitToken1Owed](../../share/ThenaGammaQuoteTwapAdapter.sol#L3155)

../../share/ThenaGammaQuoteTwapAdapter.sol#L3154


## too-many-digits
Impact: Informational
Confidence: Medium
 - [ ] ID-168
[TickMath.getSqrtRatioAtTick(int24)](../../share/ThenaGammaQuoteTwapAdapter.sol#L29-L64) uses literals with too many digits:
	- [ratio = 0x100000000000000000000000000000000](../../share/ThenaGammaQuoteTwapAdapter.sol#L36)

../../share/ThenaGammaQuoteTwapAdapter.sol#L29-L64


## unused-state
Impact: Informational
Confidence: High
 - [ ] ID-169
[TwapUtils.Q96](../../share/ThenaGammaQuoteTwapAdapter.sol#L1494) is never used in [TwapUtils](../../share/ThenaGammaQuoteTwapAdapter.sol#L1492-L1546)

../../share/ThenaGammaQuoteTwapAdapter.sol#L1494


## external-function
Impact: Optimization
Confidence: High
 - [ ] ID-170
token1Decimals() should be declared external:
	- [ThenaGammaAdapter.token1Decimals()](../../share/ThenaGammaQuoteTwapAdapter.sol#L3473-L3475)

../../share/ThenaGammaQuoteTwapAdapter.sol#L3473-L3475


 - [ ] ID-171
getTwap(address,uint32,uint8) should be declared external:
	- [TwapUtils.getTwap(address,uint32,uint8)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1497-L1499)

../../share/ThenaGammaQuoteTwapAdapter.sol#L1497-L1499


 - [ ] ID-172
value() should be declared external:
	- [ThenaGammaAdapter.value()](../../share/ThenaGammaQuoteTwapAdapter.sol#L3410-L3414)

../../share/ThenaGammaQuoteTwapAdapter.sol#L3410-L3414


 - [ ] ID-173
executeSwaps(IBalancer.SwapInfo[]) should be declared external:
	- [SwapExecutor.executeSwaps(IBalancer.SwapInfo[])](../../share/ThenaGammaQuoteTwapAdapter.sol#L2566-L2572)

../../share/ThenaGammaQuoteTwapAdapter.sol#L2566-L2572


 - [ ] ID-174
convertToken1ToToken0(uint256,address,uint32) should be declared external:
	- [TwapUtils.convertToken1ToToken0(uint256,address,uint32)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1505-L1507)

../../share/ThenaGammaQuoteTwapAdapter.sol#L1505-L1507


 - [ ] ID-175
token0Decimals() should be declared external:
	- [ThenaGammaAdapter.token0Decimals()](../../share/ThenaGammaQuoteTwapAdapter.sol#L3469-L3471)

../../share/ThenaGammaQuoteTwapAdapter.sol#L3469-L3471


 - [ ] ID-176
convertToken0ToToken1(uint256,address,uint32) should be declared external:
	- [TwapUtils.convertToken0ToToken1(uint256,address,uint32)](../../share/ThenaGammaQuoteTwapAdapter.sol#L1501-L1503)

../../share/ThenaGammaQuoteTwapAdapter.sol#L1501-L1503


