Summary
 - [divide-before-multiply](#divide-before-multiply) (8 results) (Medium)
 - [unused-return](#unused-return) (4 results) (Medium)
 - [calls-loop](#calls-loop) (1 results) (Low)
 - [timestamp](#timestamp) (1 results) (Low)
 - [assembly](#assembly) (3 results) (Informational)
 - [dead-code](#dead-code) (105 results) (Informational)
 - [solc-version](#solc-version) (2 results) (Informational)
 - [low-level-calls](#low-level-calls) (4 results) (Informational)
 - [naming-convention](#naming-convention) (15 results) (Informational)
 - [external-function](#external-function) (1 results) (Optimization)
## divide-before-multiply
Impact: Medium
Confidence: Medium
 - [ ] ID-0
[Math.mulDiv(uint256,uint256,uint256)](../../share/StargateAdapter.sol#L1537-L1617) performs a multiplication on the result of a division:
	-[prod0 = prod0 / twos](../../share/StargateAdapter.sol#L1587)
	-[result = prod0 * inverse](../../share/StargateAdapter.sol#L1614)

../../share/StargateAdapter.sol#L1537-L1617


 - [ ] ID-1
[Math.mulDiv(uint256,uint256,uint256)](../../share/StargateAdapter.sol#L1537-L1617) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/StargateAdapter.sol#L1584)
	-[inverse *= 2 - denominator * inverse](../../share/StargateAdapter.sol#L1603)

../../share/StargateAdapter.sol#L1537-L1617


 - [ ] ID-2
[Math.mulDiv(uint256,uint256,uint256)](../../share/StargateAdapter.sol#L1537-L1617) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/StargateAdapter.sol#L1584)
	-[inverse = (3 * denominator) ^ 2](../../share/StargateAdapter.sol#L1599)

../../share/StargateAdapter.sol#L1537-L1617


 - [ ] ID-3
[Math.mulDiv(uint256,uint256,uint256)](../../share/StargateAdapter.sol#L1537-L1617) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/StargateAdapter.sol#L1584)
	-[inverse *= 2 - denominator * inverse](../../share/StargateAdapter.sol#L1607)

../../share/StargateAdapter.sol#L1537-L1617


 - [ ] ID-4
[Math.mulDiv(uint256,uint256,uint256)](../../share/StargateAdapter.sol#L1537-L1617) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/StargateAdapter.sol#L1584)
	-[inverse *= 2 - denominator * inverse](../../share/StargateAdapter.sol#L1606)

../../share/StargateAdapter.sol#L1537-L1617


 - [ ] ID-5
[Math.mulDiv(uint256,uint256,uint256)](../../share/StargateAdapter.sol#L1537-L1617) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/StargateAdapter.sol#L1584)
	-[inverse *= 2 - denominator * inverse](../../share/StargateAdapter.sol#L1608)

../../share/StargateAdapter.sol#L1537-L1617


 - [ ] ID-6
[Math.mulDiv(uint256,uint256,uint256)](../../share/StargateAdapter.sol#L1537-L1617) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/StargateAdapter.sol#L1584)
	-[inverse *= 2 - denominator * inverse](../../share/StargateAdapter.sol#L1605)

../../share/StargateAdapter.sol#L1537-L1617


 - [ ] ID-7
[Math.mulDiv(uint256,uint256,uint256)](../../share/StargateAdapter.sol#L1537-L1617) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/StargateAdapter.sol#L1584)
	-[inverse *= 2 - denominator * inverse](../../share/StargateAdapter.sol#L1604)

../../share/StargateAdapter.sol#L1537-L1617


## unused-return
Impact: Medium
Confidence: Medium
 - [ ] ID-8
[StargateAdapter.constructor(address,address,address,address,uint256,uint256)](../../share/StargateAdapter.sol#L2598-L2626) ignores return value by [POOL.approve(_lpstaking,type()(uint256).max)](../../share/StargateAdapter.sol#L2619)

../../share/StargateAdapter.sol#L2598-L2626


 - [ ] ID-9
[SwapExecutor.executeSwaps(IBalancer.SwapInfo[])](../../share/StargateAdapter.sol#L2411-L2417) ignores return value by [IERC20(swap.token).approve(swap.callee,swap.amount)](../../share/StargateAdapter.sol#L2414)

../../share/StargateAdapter.sol#L2411-L2417


 - [ ] ID-10
[SwapExecutor.executeSwaps(IBalancer.SwapInfo[])](../../share/StargateAdapter.sol#L2411-L2417) ignores return value by [Address.functionCall(swap.callee,swap.data)](../../share/StargateAdapter.sol#L2415)

../../share/StargateAdapter.sol#L2411-L2417


 - [ ] ID-11
[StargateAdapter.constructor(address,address,address,address,uint256,uint256)](../../share/StargateAdapter.sol#L2598-L2626) ignores return value by [TOKEN.approve(_router,type()(uint256).max)](../../share/StargateAdapter.sol#L2618)

../../share/StargateAdapter.sol#L2598-L2626


## calls-loop
Impact: Low
Confidence: Medium
 - [ ] ID-12
[SwapExecutor.executeSwaps(IBalancer.SwapInfo[])](../../share/StargateAdapter.sol#L2411-L2417) has external calls inside a loop: [IERC20(swap.token).approve(swap.callee,swap.amount)](../../share/StargateAdapter.sol#L2414)

../../share/StargateAdapter.sol#L2411-L2417


## timestamp
Impact: Low
Confidence: Medium
 - [ ] ID-13
[ChainLinkLib.getPrice(AggregatorV3Interface,uint256)](../../share/StargateAdapter.sol#L2560-L2574) uses timestamp for comparisons
	Dangerous comparisons:
	- [(block.timestamp - updatedAt) > stalePriceInterval](../../share/StargateAdapter.sol#L2565)

../../share/StargateAdapter.sol#L2560-L2574


## assembly
Impact: Informational
Confidence: High
 - [ ] ID-14
[Address._revert(bytes,string)](../../share/StargateAdapter.sol#L335-L347) uses assembly
	- [INLINE ASM](../../share/StargateAdapter.sol#L340-L343)

../../share/StargateAdapter.sol#L335-L347


 - [ ] ID-15
[Strings.toString(uint256)](../../share/StargateAdapter.sol#L1839-L1859) uses assembly
	- [INLINE ASM](../../share/StargateAdapter.sol#L1845-L1847)
	- [INLINE ASM](../../share/StargateAdapter.sol#L1851-L1853)

../../share/StargateAdapter.sol#L1839-L1859


 - [ ] ID-16
[Math.mulDiv(uint256,uint256,uint256)](../../share/StargateAdapter.sol#L1537-L1617) uses assembly
	- [INLINE ASM](../../share/StargateAdapter.sol#L1548-L1552)
	- [INLINE ASM](../../share/StargateAdapter.sol#L1568-L1575)
	- [INLINE ASM](../../share/StargateAdapter.sol#L1582-L1591)

../../share/StargateAdapter.sol#L1537-L1617


## dead-code
Impact: Informational
Confidence: Medium
 - [ ] ID-17
[SafeMath.mul(uint256,uint256)](../../share/StargateAdapter.sol#L2178-L2180) is never used and should be removed

../../share/StargateAdapter.sol#L2178-L2180


 - [ ] ID-18
[Address.verifyCallResult(bool,bytes,string)](../../share/StargateAdapter.sol#L323-L333) is never used and should be removed

../../share/StargateAdapter.sol#L323-L333


 - [ ] ID-19
[SafeMath.sub(uint256,uint256)](../../share/StargateAdapter.sol#L2164-L2166) is never used and should be removed

../../share/StargateAdapter.sol#L2164-L2166


 - [ ] ID-20
[SafeCast.toUint216(uint256)](../../share/StargateAdapter.sol#L449-L452) is never used and should be removed

../../share/StargateAdapter.sol#L449-L452


 - [ ] ID-21
[SafeCast.toUint248(uint256)](../../share/StargateAdapter.sol#L381-L384) is never used and should be removed

../../share/StargateAdapter.sol#L381-L384


 - [ ] ID-22
[SafeCast.toUint80(uint256)](../../share/StargateAdapter.sol#L738-L741) is never used and should be removed

../../share/StargateAdapter.sol#L738-L741


 - [ ] ID-23
[SafeMath.tryDiv(uint256,uint256)](../../share/StargateAdapter.sol#L2121-L2126) is never used and should be removed

../../share/StargateAdapter.sol#L2121-L2126


 - [ ] ID-24
[SafeCast.toUint240(uint256)](../../share/StargateAdapter.sol#L398-L401) is never used and should be removed

../../share/StargateAdapter.sol#L398-L401


 - [ ] ID-25
[Address.sendValue(address,uint256)](../../share/StargateAdapter.sol#L164-L169) is never used and should be removed

../../share/StargateAdapter.sol#L164-L169


 - [ ] ID-26
[Math.ceilDiv(uint256,uint256)](../../share/StargateAdapter.sol#L1527-L1530) is never used and should be removed

../../share/StargateAdapter.sol#L1527-L1530


 - [ ] ID-27
[SafeCast.toInt96(int256)](../../share/StargateAdapter.sol#L1265-L1268) is never used and should be removed

../../share/StargateAdapter.sol#L1265-L1268


 - [ ] ID-28
[Address.functionCallWithValue(address,bytes,uint256)](../../share/StargateAdapter.sol#L218-L224) is never used and should be removed

../../share/StargateAdapter.sol#L218-L224


 - [ ] ID-29
[SafeMath.add(uint256,uint256)](../../share/StargateAdapter.sol#L2150-L2152) is never used and should be removed

../../share/StargateAdapter.sol#L2150-L2152


 - [ ] ID-30
[SafeCast.toInt104(int256)](../../share/StargateAdapter.sol#L1247-L1250) is never used and should be removed

../../share/StargateAdapter.sol#L1247-L1250


 - [ ] ID-31
[SafeCast.toUint112(uint256)](../../share/StargateAdapter.sol#L670-L673) is never used and should be removed

../../share/StargateAdapter.sol#L670-L673


 - [ ] ID-32
[Math.log10(uint256,Math.Rounding)](../../share/StargateAdapter.sol#L1778-L1783) is never used and should be removed

../../share/StargateAdapter.sol#L1778-L1783


 - [ ] ID-33
[SafeCast.toUint208(uint256)](../../share/StargateAdapter.sol#L466-L469) is never used and should be removed

../../share/StargateAdapter.sol#L466-L469


 - [ ] ID-34
[SafeCast.toInt24(int256)](../../share/StargateAdapter.sol#L1427-L1430) is never used and should be removed

../../share/StargateAdapter.sol#L1427-L1430


 - [ ] ID-35
[SafeCast.toUint64(uint256)](../../share/StargateAdapter.sol#L772-L775) is never used and should be removed

../../share/StargateAdapter.sol#L772-L775


 - [ ] ID-36
[SafeCast.toUint168(uint256)](../../share/StargateAdapter.sol#L551-L554) is never used and should be removed

../../share/StargateAdapter.sol#L551-L554


 - [ ] ID-37
[SafeCast.toUint256(int256)](../../share/StargateAdapter.sol#L905-L908) is never used and should be removed

../../share/StargateAdapter.sol#L905-L908


 - [ ] ID-38
[SafeCast.toInt216(int256)](../../share/StargateAdapter.sol#L995-L998) is never used and should be removed

../../share/StargateAdapter.sol#L995-L998


 - [ ] ID-39
[SafeCast.toInt248(int256)](../../share/StargateAdapter.sol#L923-L926) is never used and should be removed

../../share/StargateAdapter.sol#L923-L926


 - [ ] ID-40
[SafeMath.tryMod(uint256,uint256)](../../share/StargateAdapter.sol#L2133-L2138) is never used and should be removed

../../share/StargateAdapter.sol#L2133-L2138


 - [ ] ID-41
[Math.mulDiv(uint256,uint256,uint256)](../../share/StargateAdapter.sol#L1537-L1617) is never used and should be removed

../../share/StargateAdapter.sol#L1537-L1617


 - [ ] ID-42
[SafeCast.toInt256(uint256)](../../share/StargateAdapter.sol#L1477-L1481) is never used and should be removed

../../share/StargateAdapter.sol#L1477-L1481


 - [ ] ID-43
[Address.functionDelegateCall(address,bytes,string)](../../share/StargateAdapter.sol#L284-L291) is never used and should be removed

../../share/StargateAdapter.sol#L284-L291


 - [ ] ID-44
[SafeMath.sub(uint256,uint256,string)](../../share/StargateAdapter.sol#L2225-L2234) is never used and should be removed

../../share/StargateAdapter.sol#L2225-L2234


 - [ ] ID-45
[SafeCast.toInt160(int256)](../../share/StargateAdapter.sol#L1121-L1124) is never used and should be removed

../../share/StargateAdapter.sol#L1121-L1124


 - [ ] ID-46
[SafeCast.toUint144(uint256)](../../share/StargateAdapter.sol#L602-L605) is never used and should be removed

../../share/StargateAdapter.sol#L602-L605


 - [ ] ID-47
[Strings.toHexString(uint256)](../../share/StargateAdapter.sol#L1864-L1868) is never used and should be removed

../../share/StargateAdapter.sol#L1864-L1868


 - [ ] ID-48
[SafeCast.toInt120(int256)](../../share/StargateAdapter.sol#L1211-L1214) is never used and should be removed

../../share/StargateAdapter.sol#L1211-L1214


 - [ ] ID-49
[SafeCast.toInt184(int256)](../../share/StargateAdapter.sol#L1067-L1070) is never used and should be removed

../../share/StargateAdapter.sol#L1067-L1070


 - [ ] ID-50
[Math.sqrt(uint256,Math.Rounding)](../../share/StargateAdapter.sol#L1676-L1681) is never used and should be removed

../../share/StargateAdapter.sol#L1676-L1681


 - [ ] ID-51
[Math.max(uint256,uint256)](../../share/StargateAdapter.sol#L1501-L1503) is never used and should be removed

../../share/StargateAdapter.sol#L1501-L1503


 - [ ] ID-52
[SafeCast.toUint128(uint256)](../../share/StargateAdapter.sol#L636-L639) is never used and should be removed

../../share/StargateAdapter.sol#L636-L639


 - [ ] ID-53
[SafeCast.toInt80(int256)](../../share/StargateAdapter.sol#L1301-L1304) is never used and should be removed

../../share/StargateAdapter.sol#L1301-L1304


 - [ ] ID-54
[SafeCast.toInt240(int256)](../../share/StargateAdapter.sol#L941-L944) is never used and should be removed

../../share/StargateAdapter.sol#L941-L944


 - [ ] ID-55
[Math.log2(uint256)](../../share/StargateAdapter.sol#L1687-L1723) is never used and should be removed

../../share/StargateAdapter.sol#L1687-L1723


 - [ ] ID-56
[Math.average(uint256,uint256)](../../share/StargateAdapter.sol#L1516-L1519) is never used and should be removed

../../share/StargateAdapter.sol#L1516-L1519


 - [ ] ID-57
[SafeCast.toInt144(int256)](../../share/StargateAdapter.sol#L1157-L1160) is never used and should be removed

../../share/StargateAdapter.sol#L1157-L1160


 - [ ] ID-58
[SafeCast.toInt200(int256)](../../share/StargateAdapter.sol#L1031-L1034) is never used and should be removed

../../share/StargateAdapter.sol#L1031-L1034


 - [ ] ID-59
[SafeCast.toInt40(int256)](../../share/StargateAdapter.sol#L1391-L1394) is never used and should be removed

../../share/StargateAdapter.sol#L1391-L1394


 - [ ] ID-60
[Math.log2(uint256,Math.Rounding)](../../share/StargateAdapter.sol#L1729-L1734) is never used and should be removed

../../share/StargateAdapter.sol#L1729-L1734


 - [ ] ID-61
[SafeCast.toUint40(uint256)](../../share/StargateAdapter.sol#L823-L826) is never used and should be removed

../../share/StargateAdapter.sol#L823-L826


 - [ ] ID-62
[SafeCast.toInt224(int256)](../../share/StargateAdapter.sol#L977-L980) is never used and should be removed

../../share/StargateAdapter.sol#L977-L980


 - [ ] ID-63
[SafeCast.toInt208(int256)](../../share/StargateAdapter.sol#L1013-L1016) is never used and should be removed

../../share/StargateAdapter.sol#L1013-L1016


 - [ ] ID-64
[SafeCast.toUint72(uint256)](../../share/StargateAdapter.sol#L755-L758) is never used and should be removed

../../share/StargateAdapter.sol#L755-L758


 - [ ] ID-65
[SafeCast.toInt88(int256)](../../share/StargateAdapter.sol#L1283-L1286) is never used and should be removed

../../share/StargateAdapter.sol#L1283-L1286


 - [ ] ID-66
[Address.functionDelegateCall(address,bytes)](../../share/StargateAdapter.sol#L274-L276) is never used and should be removed

../../share/StargateAdapter.sol#L274-L276


 - [ ] ID-67
[SafeERC20.safeIncreaseAllowance(IERC20,address,uint256)](../../share/StargateAdapter.sol#L2004-L2011) is never used and should be removed

../../share/StargateAdapter.sol#L2004-L2011


 - [ ] ID-68
[Math.log256(uint256)](../../share/StargateAdapter.sol#L1791-L1815) is never used and should be removed

../../share/StargateAdapter.sol#L1791-L1815


 - [ ] ID-69
[SafeERC20.safePermit(IERC20Permit,address,address,uint256,uint256,uint8,bytes32,bytes32)](../../share/StargateAdapter.sol#L2026-L2040) is never used and should be removed

../../share/StargateAdapter.sol#L2026-L2040


 - [ ] ID-70
[SafeCast.toUint8(uint256)](../../share/StargateAdapter.sol#L891-L894) is never used and should be removed

../../share/StargateAdapter.sol#L891-L894


 - [ ] ID-71
[SafeERC20.safeApprove(IERC20,address,uint256)](../../share/StargateAdapter.sol#L1989-L2002) is never used and should be removed

../../share/StargateAdapter.sol#L1989-L2002


 - [ ] ID-72
[Strings.toString(uint256)](../../share/StargateAdapter.sol#L1839-L1859) is never used and should be removed

../../share/StargateAdapter.sol#L1839-L1859


 - [ ] ID-73
[SafeMath.tryAdd(uint256,uint256)](../../share/StargateAdapter.sol#L2079-L2085) is never used and should be removed

../../share/StargateAdapter.sol#L2079-L2085


 - [ ] ID-74
[SafeCast.toUint24(uint256)](../../share/StargateAdapter.sol#L857-L860) is never used and should be removed

../../share/StargateAdapter.sol#L857-L860


 - [ ] ID-75
[SafeMath.mod(uint256,uint256,string)](../../share/StargateAdapter.sol#L2274-L2283) is never used and should be removed

../../share/StargateAdapter.sol#L2274-L2283


 - [ ] ID-76
[Math.log256(uint256,Math.Rounding)](../../share/StargateAdapter.sol#L1821-L1826) is never used and should be removed

../../share/StargateAdapter.sol#L1821-L1826


 - [ ] ID-77
[SafeCast.toInt128(int256)](../../share/StargateAdapter.sol#L1193-L1196) is never used and should be removed

../../share/StargateAdapter.sol#L1193-L1196


 - [ ] ID-78
[SafeERC20.safeTransferFrom(IERC20,address,address,uint256)](../../share/StargateAdapter.sol#L1973-L1980) is never used and should be removed

../../share/StargateAdapter.sol#L1973-L1980


 - [ ] ID-79
[Math.sqrt(uint256)](../../share/StargateAdapter.sol#L1640-L1671) is never used and should be removed

../../share/StargateAdapter.sol#L1640-L1671


 - [ ] ID-80
[SafeCast.toInt32(int256)](../../share/StargateAdapter.sol#L1409-L1412) is never used and should be removed

../../share/StargateAdapter.sol#L1409-L1412


 - [ ] ID-81
[SafeCast.toInt112(int256)](../../share/StargateAdapter.sol#L1229-L1232) is never used and should be removed

../../share/StargateAdapter.sol#L1229-L1232


 - [ ] ID-82
[SafeMath.div(uint256,uint256,string)](../../share/StargateAdapter.sol#L2248-L2257) is never used and should be removed

../../share/StargateAdapter.sol#L2248-L2257


 - [ ] ID-83
[SafeCast.toUint232(uint256)](../../share/StargateAdapter.sol#L415-L418) is never used and should be removed

../../share/StargateAdapter.sol#L415-L418


 - [ ] ID-84
[SafeCast.toInt64(int256)](../../share/StargateAdapter.sol#L1337-L1340) is never used and should be removed

../../share/StargateAdapter.sol#L1337-L1340


 - [ ] ID-85
[Address.functionStaticCall(address,bytes)](../../share/StargateAdapter.sol#L249-L251) is never used and should be removed

../../share/StargateAdapter.sol#L249-L251


 - [ ] ID-86
[SafeCast.toInt56(int256)](../../share/StargateAdapter.sol#L1355-L1358) is never used and should be removed

../../share/StargateAdapter.sol#L1355-L1358


 - [ ] ID-87
[SafeCast.toUint104(uint256)](../../share/StargateAdapter.sol#L687-L690) is never used and should be removed

../../share/StargateAdapter.sol#L687-L690


 - [ ] ID-88
[SafeCast.toUint152(uint256)](../../share/StargateAdapter.sol#L585-L588) is never used and should be removed

../../share/StargateAdapter.sol#L585-L588


 - [ ] ID-89
[SafeCast.toInt232(int256)](../../share/StargateAdapter.sol#L959-L962) is never used and should be removed

../../share/StargateAdapter.sol#L959-L962


 - [ ] ID-90
[SafeCast.toUint224(uint256)](../../share/StargateAdapter.sol#L432-L435) is never used and should be removed

../../share/StargateAdapter.sol#L432-L435


 - [ ] ID-91
[Math.mulDiv(uint256,uint256,uint256,Math.Rounding)](../../share/StargateAdapter.sol#L1622-L1633) is never used and should be removed

../../share/StargateAdapter.sol#L1622-L1633


 - [ ] ID-92
[SafeCast.toInt152(int256)](../../share/StargateAdapter.sol#L1139-L1142) is never used and should be removed

../../share/StargateAdapter.sol#L1139-L1142


 - [ ] ID-93
[SafeCast.toInt176(int256)](../../share/StargateAdapter.sol#L1085-L1088) is never used and should be removed

../../share/StargateAdapter.sol#L1085-L1088


 - [ ] ID-94
[SafeCast.toInt8(int256)](../../share/StargateAdapter.sol#L1463-L1466) is never used and should be removed

../../share/StargateAdapter.sol#L1463-L1466


 - [ ] ID-95
[Math.log10(uint256)](../../share/StargateAdapter.sol#L1740-L1772) is never used and should be removed

../../share/StargateAdapter.sol#L1740-L1772


 - [ ] ID-96
[SafeCast.toInt48(int256)](../../share/StargateAdapter.sol#L1373-L1376) is never used and should be removed

../../share/StargateAdapter.sol#L1373-L1376


 - [ ] ID-97
[SafeMath.mod(uint256,uint256)](../../share/StargateAdapter.sol#L2208-L2210) is never used and should be removed

../../share/StargateAdapter.sol#L2208-L2210


 - [ ] ID-98
[SafeCast.toUint192(uint256)](../../share/StargateAdapter.sol#L500-L503) is never used and should be removed

../../share/StargateAdapter.sol#L500-L503


 - [ ] ID-99
[SafeCast.toUint200(uint256)](../../share/StargateAdapter.sol#L483-L486) is never used and should be removed

../../share/StargateAdapter.sol#L483-L486


 - [ ] ID-100
[SafeCast.toUint96(uint256)](../../share/StargateAdapter.sol#L704-L707) is never used and should be removed

../../share/StargateAdapter.sol#L704-L707


 - [ ] ID-101
[SafeMath.div(uint256,uint256)](../../share/StargateAdapter.sol#L2192-L2194) is never used and should be removed

../../share/StargateAdapter.sol#L2192-L2194


 - [ ] ID-102
[SafeCast.toUint184(uint256)](../../share/StargateAdapter.sol#L517-L520) is never used and should be removed

../../share/StargateAdapter.sol#L517-L520


 - [ ] ID-103
[SafeCast.toUint160(uint256)](../../share/StargateAdapter.sol#L568-L571) is never used and should be removed

../../share/StargateAdapter.sol#L568-L571


 - [ ] ID-104
[SafeMath.tryMul(uint256,uint256)](../../share/StargateAdapter.sol#L2104-L2114) is never used and should be removed

../../share/StargateAdapter.sol#L2104-L2114


 - [ ] ID-105
[SafeCast.toUint16(uint256)](../../share/StargateAdapter.sol#L874-L877) is never used and should be removed

../../share/StargateAdapter.sol#L874-L877


 - [ ] ID-106
[SafeCast.toInt16(int256)](../../share/StargateAdapter.sol#L1445-L1448) is never used and should be removed

../../share/StargateAdapter.sol#L1445-L1448


 - [ ] ID-107
[SafeCast.toInt168(int256)](../../share/StargateAdapter.sol#L1103-L1106) is never used and should be removed

../../share/StargateAdapter.sol#L1103-L1106


 - [ ] ID-108
[SafeCast.toUint176(uint256)](../../share/StargateAdapter.sol#L534-L537) is never used and should be removed

../../share/StargateAdapter.sol#L534-L537


 - [ ] ID-109
[SafeCast.toUint48(uint256)](../../share/StargateAdapter.sol#L806-L809) is never used and should be removed

../../share/StargateAdapter.sol#L806-L809


 - [ ] ID-110
[SafeMath.trySub(uint256,uint256)](../../share/StargateAdapter.sol#L2092-L2097) is never used and should be removed

../../share/StargateAdapter.sol#L2092-L2097


 - [ ] ID-111
[SafeERC20.safeDecreaseAllowance(IERC20,address,uint256)](../../share/StargateAdapter.sol#L2013-L2024) is never used and should be removed

../../share/StargateAdapter.sol#L2013-L2024


 - [ ] ID-112
[SafeCast.toUint56(uint256)](../../share/StargateAdapter.sol#L789-L792) is never used and should be removed

../../share/StargateAdapter.sol#L789-L792


 - [ ] ID-113
[SafeCast.toUint88(uint256)](../../share/StargateAdapter.sol#L721-L724) is never used and should be removed

../../share/StargateAdapter.sol#L721-L724


 - [ ] ID-114
[Math.min(uint256,uint256)](../../share/StargateAdapter.sol#L1508-L1510) is never used and should be removed

../../share/StargateAdapter.sol#L1508-L1510


 - [ ] ID-115
[SafeCast.toInt72(int256)](../../share/StargateAdapter.sol#L1319-L1322) is never used and should be removed

../../share/StargateAdapter.sol#L1319-L1322


 - [ ] ID-116
[Address.functionStaticCall(address,bytes,string)](../../share/StargateAdapter.sol#L259-L266) is never used and should be removed

../../share/StargateAdapter.sol#L259-L266


 - [ ] ID-117
[SafeCast.toUint32(uint256)](../../share/StargateAdapter.sol#L840-L843) is never used and should be removed

../../share/StargateAdapter.sol#L840-L843


 - [ ] ID-118
[SafeCast.toUint120(uint256)](../../share/StargateAdapter.sol#L653-L656) is never used and should be removed

../../share/StargateAdapter.sol#L653-L656


 - [ ] ID-119
[SafeCast.toUint136(uint256)](../../share/StargateAdapter.sol#L619-L622) is never used and should be removed

../../share/StargateAdapter.sol#L619-L622


 - [ ] ID-120
[SafeCast.toInt136(int256)](../../share/StargateAdapter.sol#L1175-L1178) is never used and should be removed

../../share/StargateAdapter.sol#L1175-L1178


 - [ ] ID-121
[SafeCast.toInt192(int256)](../../share/StargateAdapter.sol#L1049-L1052) is never used and should be removed

../../share/StargateAdapter.sol#L1049-L1052


## solc-version
Impact: Informational
Confidence: High
 - [ ] ID-122
Pragma version[^0.8.19](../../share/StargateAdapter.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.6.12/0.7.6/0.8.7

../../share/StargateAdapter.sol#L2


 - [ ] ID-123
solc-0.8.19 is not recommended for deployment

## low-level-calls
Impact: Informational
Confidence: High
 - [ ] ID-124
Low level call in [Address.functionStaticCall(address,bytes,string)](../../share/StargateAdapter.sol#L259-L266):
	- [(success,returndata) = target.staticcall(data)](../../share/StargateAdapter.sol#L264)

../../share/StargateAdapter.sol#L259-L266


 - [ ] ID-125
Low level call in [Address.functionCallWithValue(address,bytes,uint256,string)](../../share/StargateAdapter.sol#L232-L241):
	- [(success,returndata) = target.call{value: value}(data)](../../share/StargateAdapter.sol#L239)

../../share/StargateAdapter.sol#L232-L241


 - [ ] ID-126
Low level call in [Address.functionDelegateCall(address,bytes,string)](../../share/StargateAdapter.sol#L284-L291):
	- [(success,returndata) = target.delegatecall(data)](../../share/StargateAdapter.sol#L289)

../../share/StargateAdapter.sol#L284-L291


 - [ ] ID-127
Low level call in [Address.sendValue(address,uint256)](../../share/StargateAdapter.sol#L164-L169):
	- [(success) = recipient.call{value: amount}()](../../share/StargateAdapter.sol#L167)

../../share/StargateAdapter.sol#L164-L169


## naming-convention
Impact: Informational
Confidence: High
 - [ ] ID-128
Variable [BaseAdapter.BALANCER](../../share/StargateAdapter.sol#L2428) is not in mixedCase

../../share/StargateAdapter.sol#L2428


 - [ ] ID-129
Variable [StargateAdapter.PRECISION_MULTIPLIER](../../share/StargateAdapter.sol#L2596) is not in mixedCase

../../share/StargateAdapter.sol#L2596


 - [ ] ID-130
Contract [_IBalancer](../../share/StargateAdapter.sol#L2421-L2423) is not in CapWords

../../share/StargateAdapter.sol#L2421-L2423


 - [ ] ID-131
Variable [StargateAdapter.TOKEN](../../share/StargateAdapter.sol#L2586) is not in mixedCase

../../share/StargateAdapter.sol#L2586


 - [ ] ID-132
Variable [StargateAdapter.ROUTER](../../share/StargateAdapter.sol#L2584) is not in mixedCase

../../share/StargateAdapter.sol#L2584


 - [ ] ID-133
Variable [BaseAdapter.SWAP_EXECUTOR](../../share/StargateAdapter.sol#L2429) is not in mixedCase

../../share/StargateAdapter.sol#L2429


 - [ ] ID-134
Variable [StargateAdapter.POOL](../../share/StargateAdapter.sol#L2585) is not in mixedCase

../../share/StargateAdapter.sol#L2585


 - [ ] ID-135
Variable [StargateAdapter.TOKEN_PRICE_FEED](../../share/StargateAdapter.sol#L2589) is not in mixedCase

../../share/StargateAdapter.sol#L2589


 - [ ] ID-136
Variable [StargateAdapter.POOL_ID](../../share/StargateAdapter.sol#L2592) is not in mixedCase

../../share/StargateAdapter.sol#L2592


 - [ ] ID-137
Function [_IBalancer.SWAP_EXECUTOR()](../../share/StargateAdapter.sol#L2422) is not in mixedCase

../../share/StargateAdapter.sol#L2422


 - [ ] ID-138
Function [IERC20Permit.DOMAIN_SEPARATOR()](../../share/StargateAdapter.sol#L1950) is not in mixedCase

../../share/StargateAdapter.sol#L1950


 - [ ] ID-139
Variable [StargateAdapter.LPSTAKING](../../share/StargateAdapter.sol#L2583) is not in mixedCase

../../share/StargateAdapter.sol#L2583


 - [ ] ID-140
Variable [StargateAdapter.CHAIN_POOL_ID](../../share/StargateAdapter.sol#L2593) is not in mixedCase

../../share/StargateAdapter.sol#L2593


 - [ ] ID-141
Variable [StargateAdapter.FEED_STALE_PRICE_INTERVAL](../../share/StargateAdapter.sol#L2591) is not in mixedCase

../../share/StargateAdapter.sol#L2591


 - [ ] ID-142
Variable [StargateAdapter.REWARD_TOKEN](../../share/StargateAdapter.sol#L2587) is not in mixedCase

../../share/StargateAdapter.sol#L2587


## external-function
Impact: Optimization
Confidence: High
 - [ ] ID-143
executeSwaps(IBalancer.SwapInfo[]) should be declared external:
	- [SwapExecutor.executeSwaps(IBalancer.SwapInfo[])](../../share/StargateAdapter.sol#L2411-L2417)

../../share/StargateAdapter.sol#L2411-L2417


