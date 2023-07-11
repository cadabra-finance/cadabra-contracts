Summary
 - [divide-before-multiply](#divide-before-multiply) (9 results) (Medium)
 - [uninitialized-local](#uninitialized-local) (2 results) (Medium)
 - [unused-return](#unused-return) (6 results) (Medium)
 - [calls-loop](#calls-loop) (1 results) (Low)
 - [timestamp](#timestamp) (1 results) (Low)
 - [assembly](#assembly) (3 results) (Informational)
 - [dead-code](#dead-code) (92 results) (Informational)
 - [solc-version](#solc-version) (2 results) (Informational)
 - [low-level-calls](#low-level-calls) (4 results) (Informational)
 - [naming-convention](#naming-convention) (17 results) (Informational)
 - [similar-names](#similar-names) (19 results) (Informational)
 - [external-function](#external-function) (4 results) (Optimization)
## divide-before-multiply
Impact: Medium
Confidence: Medium
 - [ ] ID-0
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1588-L1668) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaPriceFeedAdapter.sol#L1635)
	-[inverse *= 2 - denominator * inverse](../../share/ThenaGammaPriceFeedAdapter.sol#L1658)

../../share/ThenaGammaPriceFeedAdapter.sol#L1588-L1668


 - [ ] ID-1
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1588-L1668) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaPriceFeedAdapter.sol#L1635)
	-[inverse *= 2 - denominator * inverse](../../share/ThenaGammaPriceFeedAdapter.sol#L1654)

../../share/ThenaGammaPriceFeedAdapter.sol#L1588-L1668


 - [ ] ID-2
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1588-L1668) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaPriceFeedAdapter.sol#L1635)
	-[inverse *= 2 - denominator * inverse](../../share/ThenaGammaPriceFeedAdapter.sol#L1655)

../../share/ThenaGammaPriceFeedAdapter.sol#L1588-L1668


 - [ ] ID-3
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1588-L1668) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaPriceFeedAdapter.sol#L1635)
	-[inverse *= 2 - denominator * inverse](../../share/ThenaGammaPriceFeedAdapter.sol#L1657)

../../share/ThenaGammaPriceFeedAdapter.sol#L1588-L1668


 - [ ] ID-4
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1588-L1668) performs a multiplication on the result of a division:
	-[prod0 = prod0 / twos](../../share/ThenaGammaPriceFeedAdapter.sol#L1638)
	-[result = prod0 * inverse](../../share/ThenaGammaPriceFeedAdapter.sol#L1665)

../../share/ThenaGammaPriceFeedAdapter.sol#L1588-L1668


 - [ ] ID-5
[LiquidityUtils.ratio2(uint256,uint256,uint256,uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L2941-L2956) performs a multiplication on the result of a division:
	-[d1 = d0 * reserve1 / reserve0](../../share/ThenaGammaPriceFeedAdapter.sol#L2950)
	-[d0 = d1 * reserve0 / reserve1](../../share/ThenaGammaPriceFeedAdapter.sol#L2954)

../../share/ThenaGammaPriceFeedAdapter.sol#L2941-L2956


 - [ ] ID-6
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1588-L1668) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaPriceFeedAdapter.sol#L1635)
	-[inverse *= 2 - denominator * inverse](../../share/ThenaGammaPriceFeedAdapter.sol#L1656)

../../share/ThenaGammaPriceFeedAdapter.sol#L1588-L1668


 - [ ] ID-7
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1588-L1668) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaPriceFeedAdapter.sol#L1635)
	-[inverse *= 2 - denominator * inverse](../../share/ThenaGammaPriceFeedAdapter.sol#L1659)

../../share/ThenaGammaPriceFeedAdapter.sol#L1588-L1668


 - [ ] ID-8
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1588-L1668) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/ThenaGammaPriceFeedAdapter.sol#L1635)
	-[inverse = (3 * denominator) ^ 2](../../share/ThenaGammaPriceFeedAdapter.sol#L1650)

../../share/ThenaGammaPriceFeedAdapter.sol#L1588-L1668


## uninitialized-local
Impact: Medium
Confidence: Medium
 - [ ] ID-9
[ThenaGammaAdapter._invest().minIn](../../share/ThenaGammaPriceFeedAdapter.sol#L3022) is a local variable never initialized

../../share/ThenaGammaPriceFeedAdapter.sol#L3022


 - [ ] ID-10
[ThenaGammaAdapter._redeem(uint256,address).minAmounts](../../share/ThenaGammaPriceFeedAdapter.sol#L3037) is a local variable never initialized

../../share/ThenaGammaPriceFeedAdapter.sol#L3037


## unused-return
Impact: Medium
Confidence: Medium
 - [ ] ID-11
[ThenaGammaAdapter.constructor(address,address)](../../share/ThenaGammaPriceFeedAdapter.sol#L2976-L3002) ignores return value by [TOKEN1.approve(address(HYPERVISOR),type()(uint256).max)](../../share/ThenaGammaPriceFeedAdapter.sol#L2988)

../../share/ThenaGammaPriceFeedAdapter.sol#L2976-L3002


 - [ ] ID-12
[ThenaGammaAdapter.constructor(address,address)](../../share/ThenaGammaPriceFeedAdapter.sol#L2976-L3002) ignores return value by [TOKEN0.approve(address(HYPERVISOR),type()(uint256).max)](../../share/ThenaGammaPriceFeedAdapter.sol#L2987)

../../share/ThenaGammaPriceFeedAdapter.sol#L2976-L3002


 - [ ] ID-13
[SwapExecutor.executeSwaps(IBalancer.SwapInfo[])](../../share/ThenaGammaPriceFeedAdapter.sol#L2207-L2213) ignores return value by [IERC20(swap.token).approve(swap.callee,swap.amount)](../../share/ThenaGammaPriceFeedAdapter.sol#L2210)

../../share/ThenaGammaPriceFeedAdapter.sol#L2207-L2213


 - [ ] ID-14
[SwapExecutor.executeSwaps(IBalancer.SwapInfo[])](../../share/ThenaGammaPriceFeedAdapter.sol#L2207-L2213) ignores return value by [Address.functionCall(swap.callee,swap.data)](../../share/ThenaGammaPriceFeedAdapter.sol#L2211)

../../share/ThenaGammaPriceFeedAdapter.sol#L2207-L2213


 - [ ] ID-15
[ThenaGammaAdapter._invest()](../../share/ThenaGammaPriceFeedAdapter.sol#L3004-L3029) ignores return value by [UNIPROXY.deposit(deposit0,deposit1,address(this),address(HYPERVISOR),minIn)](../../share/ThenaGammaPriceFeedAdapter.sol#L3024)

../../share/ThenaGammaPriceFeedAdapter.sol#L3004-L3029


 - [ ] ID-16
[ThenaGammaAdapter.constructor(address,address)](../../share/ThenaGammaPriceFeedAdapter.sol#L2976-L3002) ignores return value by [HYPERVISOR.approve(_gauge,type()(uint256).max)](../../share/ThenaGammaPriceFeedAdapter.sol#L2989)

../../share/ThenaGammaPriceFeedAdapter.sol#L2976-L3002


## calls-loop
Impact: Low
Confidence: Medium
 - [ ] ID-17
[SwapExecutor.executeSwaps(IBalancer.SwapInfo[])](../../share/ThenaGammaPriceFeedAdapter.sol#L2207-L2213) has external calls inside a loop: [IERC20(swap.token).approve(swap.callee,swap.amount)](../../share/ThenaGammaPriceFeedAdapter.sol#L2210)

../../share/ThenaGammaPriceFeedAdapter.sol#L2207-L2213


## timestamp
Impact: Low
Confidence: Medium
 - [ ] ID-18
[ChainLinkLib.getPrice(AggregatorV3Interface,uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1172-L1186) uses timestamp for comparisons
	Dangerous comparisons:
	- [(block.timestamp - updatedAt) > stalePriceInterval](../../share/ThenaGammaPriceFeedAdapter.sol#L1177)

../../share/ThenaGammaPriceFeedAdapter.sol#L1172-L1186


## assembly
Impact: Informational
Confidence: High
 - [ ] ID-19
[Address._revert(bytes,string)](../../share/ThenaGammaPriceFeedAdapter.sol#L1520-L1532) uses assembly
	- [INLINE ASM](../../share/ThenaGammaPriceFeedAdapter.sol#L1525-L1528)

../../share/ThenaGammaPriceFeedAdapter.sol#L1520-L1532


 - [ ] ID-20
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1588-L1668) uses assembly
	- [INLINE ASM](../../share/ThenaGammaPriceFeedAdapter.sol#L1599-L1603)
	- [INLINE ASM](../../share/ThenaGammaPriceFeedAdapter.sol#L1619-L1626)
	- [INLINE ASM](../../share/ThenaGammaPriceFeedAdapter.sol#L1633-L1642)

../../share/ThenaGammaPriceFeedAdapter.sol#L1588-L1668


 - [ ] ID-21
[Strings.toString(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1890-L1910) uses assembly
	- [INLINE ASM](../../share/ThenaGammaPriceFeedAdapter.sol#L1896-L1898)
	- [INLINE ASM](../../share/ThenaGammaPriceFeedAdapter.sol#L1902-L1904)

../../share/ThenaGammaPriceFeedAdapter.sol#L1890-L1910


## dead-code
Impact: Informational
Confidence: Medium
 - [ ] ID-22
[Address.verifyCallResult(bool,bytes,string)](../../share/ThenaGammaPriceFeedAdapter.sol#L1508-L1518) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1508-L1518


 - [ ] ID-23
[SafeCast.toUint216(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L103-L106) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L103-L106


 - [ ] ID-24
[SafeCast.toUint248(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L35-L38) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L35-L38


 - [ ] ID-25
[SafeCast.toUint80(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L392-L395) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L392-L395


 - [ ] ID-26
[SafeCast.toUint240(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L52-L55) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L52-L55


 - [ ] ID-27
[Address.sendValue(address,uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1349-L1354) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1349-L1354


 - [ ] ID-28
[Math.ceilDiv(uint256,uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1578-L1581) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1578-L1581


 - [ ] ID-29
[SafeCast.toInt96(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L919-L922) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L919-L922


 - [ ] ID-30
[Address.functionCallWithValue(address,bytes,uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1403-L1409) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1403-L1409


 - [ ] ID-31
[SafeCast.toInt104(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L901-L904) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L901-L904


 - [ ] ID-32
[SafeCast.toUint112(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L324-L327) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L324-L327


 - [ ] ID-33
[Math.log10(uint256,Math.Rounding)](../../share/ThenaGammaPriceFeedAdapter.sol#L1829-L1834) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1829-L1834


 - [ ] ID-34
[SafeCast.toUint208(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L120-L123) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L120-L123


 - [ ] ID-35
[SafeCast.toInt24(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1081-L1084) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1081-L1084


 - [ ] ID-36
[SafeCast.toUint64(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L426-L429) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L426-L429


 - [ ] ID-37
[SafeCast.toUint168(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L205-L208) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L205-L208


 - [ ] ID-38
[SafeCast.toUint256(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L559-L562) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L559-L562


 - [ ] ID-39
[SafeCast.toInt216(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L649-L652) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L649-L652


 - [ ] ID-40
[SafeCast.toInt248(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L577-L580) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L577-L580


 - [ ] ID-41
[Math.mulDiv(uint256,uint256,uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1588-L1668) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1588-L1668


 - [ ] ID-42
[SafeCast.toInt256(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1131-L1135) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1131-L1135


 - [ ] ID-43
[Address.functionDelegateCall(address,bytes,string)](../../share/ThenaGammaPriceFeedAdapter.sol#L1469-L1476) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1469-L1476


 - [ ] ID-44
[SafeCast.toInt160(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L775-L778) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L775-L778


 - [ ] ID-45
[SafeCast.toUint144(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L256-L259) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L256-L259


 - [ ] ID-46
[Strings.toHexString(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1915-L1919) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1915-L1919


 - [ ] ID-47
[SafeCast.toInt120(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L865-L868) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L865-L868


 - [ ] ID-48
[SafeCast.toInt184(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L721-L724) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L721-L724


 - [ ] ID-49
[Math.sqrt(uint256,Math.Rounding)](../../share/ThenaGammaPriceFeedAdapter.sol#L1727-L1732) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1727-L1732


 - [ ] ID-50
[Math.max(uint256,uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1552-L1554) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1552-L1554


 - [ ] ID-51
[SafeCast.toUint128(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L290-L293) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L290-L293


 - [ ] ID-52
[SafeCast.toInt80(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L955-L958) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L955-L958


 - [ ] ID-53
[SafeCast.toInt240(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L595-L598) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L595-L598


 - [ ] ID-54
[Math.log2(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1738-L1774) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1738-L1774


 - [ ] ID-55
[Math.average(uint256,uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1567-L1570) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1567-L1570


 - [ ] ID-56
[SafeCast.toInt144(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L811-L814) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L811-L814


 - [ ] ID-57
[SafeCast.toInt200(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L685-L688) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L685-L688


 - [ ] ID-58
[SafeCast.toInt40(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1045-L1048) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1045-L1048


 - [ ] ID-59
[Math.log2(uint256,Math.Rounding)](../../share/ThenaGammaPriceFeedAdapter.sol#L1780-L1785) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1780-L1785


 - [ ] ID-60
[SafeCast.toUint40(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L477-L480) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L477-L480


 - [ ] ID-61
[SafeCast.toInt224(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L631-L634) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L631-L634


 - [ ] ID-62
[SafeCast.toInt208(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L667-L670) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L667-L670


 - [ ] ID-63
[SafeCast.toUint72(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L409-L412) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L409-L412


 - [ ] ID-64
[SafeCast.toInt88(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L937-L940) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L937-L940


 - [ ] ID-65
[Address.functionDelegateCall(address,bytes)](../../share/ThenaGammaPriceFeedAdapter.sol#L1459-L1461) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1459-L1461


 - [ ] ID-66
[SafeERC20.safeIncreaseAllowance(IERC20,address,uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L2055-L2062) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L2055-L2062


 - [ ] ID-67
[Math.log256(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1842-L1866) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1842-L1866


 - [ ] ID-68
[SafeERC20.safePermit(IERC20Permit,address,address,uint256,uint256,uint8,bytes32,bytes32)](../../share/ThenaGammaPriceFeedAdapter.sol#L2077-L2091) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L2077-L2091


 - [ ] ID-69
[SafeCast.toUint8(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L545-L548) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L545-L548


 - [ ] ID-70
[SafeERC20.safeApprove(IERC20,address,uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L2040-L2053) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L2040-L2053


 - [ ] ID-71
[Strings.toString(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1890-L1910) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1890-L1910


 - [ ] ID-72
[SafeCast.toUint24(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L511-L514) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L511-L514


 - [ ] ID-73
[Math.log256(uint256,Math.Rounding)](../../share/ThenaGammaPriceFeedAdapter.sol#L1872-L1877) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1872-L1877


 - [ ] ID-74
[SafeCast.toInt128(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L847-L850) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L847-L850


 - [ ] ID-75
[SafeERC20.safeTransferFrom(IERC20,address,address,uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L2024-L2031) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L2024-L2031


 - [ ] ID-76
[Math.sqrt(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1691-L1722) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1691-L1722


 - [ ] ID-77
[SafeCast.toInt32(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1063-L1066) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1063-L1066


 - [ ] ID-78
[SafeCast.toInt112(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L883-L886) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L883-L886


 - [ ] ID-79
[SafeCast.toUint232(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L69-L72) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L69-L72


 - [ ] ID-80
[SafeCast.toInt64(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L991-L994) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L991-L994


 - [ ] ID-81
[Address.functionStaticCall(address,bytes)](../../share/ThenaGammaPriceFeedAdapter.sol#L1434-L1436) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1434-L1436


 - [ ] ID-82
[SafeCast.toInt56(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1009-L1012) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1009-L1012


 - [ ] ID-83
[SafeCast.toUint104(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L341-L344) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L341-L344


 - [ ] ID-84
[SafeCast.toUint152(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L239-L242) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L239-L242


 - [ ] ID-85
[SafeCast.toInt232(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L613-L616) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L613-L616


 - [ ] ID-86
[SafeCast.toUint224(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L86-L89) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L86-L89


 - [ ] ID-87
[Math.mulDiv(uint256,uint256,uint256,Math.Rounding)](../../share/ThenaGammaPriceFeedAdapter.sol#L1673-L1684) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1673-L1684


 - [ ] ID-88
[SafeCast.toInt152(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L793-L796) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L793-L796


 - [ ] ID-89
[SafeCast.toInt176(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L739-L742) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L739-L742


 - [ ] ID-90
[SafeCast.toInt8(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1117-L1120) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1117-L1120


 - [ ] ID-91
[Math.log10(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1791-L1823) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1791-L1823


 - [ ] ID-92
[SafeCast.toInt48(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1027-L1030) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1027-L1030


 - [ ] ID-93
[SafeCast.toUint192(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L154-L157) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L154-L157


 - [ ] ID-94
[SafeCast.toUint200(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L137-L140) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L137-L140


 - [ ] ID-95
[SafeCast.toUint96(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L358-L361) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L358-L361


 - [ ] ID-96
[SafeCast.toUint184(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L171-L174) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L171-L174


 - [ ] ID-97
[SafeCast.toUint160(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L222-L225) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L222-L225


 - [ ] ID-98
[SafeCast.toUint16(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L528-L531) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L528-L531


 - [ ] ID-99
[SafeCast.toInt16(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1099-L1102) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1099-L1102


 - [ ] ID-100
[SafeCast.toInt168(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L757-L760) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L757-L760


 - [ ] ID-101
[SafeCast.toUint176(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L188-L191) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L188-L191


 - [ ] ID-102
[SafeCast.toUint48(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L460-L463) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L460-L463


 - [ ] ID-103
[SafeERC20.safeDecreaseAllowance(IERC20,address,uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L2064-L2075) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L2064-L2075


 - [ ] ID-104
[SafeCast.toUint56(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L443-L446) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L443-L446


 - [ ] ID-105
[SafeCast.toUint88(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L375-L378) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L375-L378


 - [ ] ID-106
[Math.min(uint256,uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1559-L1561) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1559-L1561


 - [ ] ID-107
[SafeCast.toInt72(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L973-L976) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L973-L976


 - [ ] ID-108
[Address.functionStaticCall(address,bytes,string)](../../share/ThenaGammaPriceFeedAdapter.sol#L1444-L1451) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L1444-L1451


 - [ ] ID-109
[SafeCast.toUint32(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L494-L497) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L494-L497


 - [ ] ID-110
[SafeCast.toUint120(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L307-L310) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L307-L310


 - [ ] ID-111
[SafeCast.toUint136(uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L273-L276) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L273-L276


 - [ ] ID-112
[SafeCast.toInt136(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L829-L832) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L829-L832


 - [ ] ID-113
[SafeCast.toInt192(int256)](../../share/ThenaGammaPriceFeedAdapter.sol#L703-L706) is never used and should be removed

../../share/ThenaGammaPriceFeedAdapter.sol#L703-L706


## solc-version
Impact: Informational
Confidence: High
 - [ ] ID-114
solc-0.8.19 is not recommended for deployment

 - [ ] ID-115
Pragma version[^0.8.19](../../share/ThenaGammaPriceFeedAdapter.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.6.12/0.7.6/0.8.7

../../share/ThenaGammaPriceFeedAdapter.sol#L2


## low-level-calls
Impact: Informational
Confidence: High
 - [ ] ID-116
Low level call in [Address.sendValue(address,uint256)](../../share/ThenaGammaPriceFeedAdapter.sol#L1349-L1354):
	- [(success) = recipient.call{value: amount}()](../../share/ThenaGammaPriceFeedAdapter.sol#L1352)

../../share/ThenaGammaPriceFeedAdapter.sol#L1349-L1354


 - [ ] ID-117
Low level call in [Address.functionCallWithValue(address,bytes,uint256,string)](../../share/ThenaGammaPriceFeedAdapter.sol#L1417-L1426):
	- [(success,returndata) = target.call{value: value}(data)](../../share/ThenaGammaPriceFeedAdapter.sol#L1424)

../../share/ThenaGammaPriceFeedAdapter.sol#L1417-L1426


 - [ ] ID-118
Low level call in [Address.functionStaticCall(address,bytes,string)](../../share/ThenaGammaPriceFeedAdapter.sol#L1444-L1451):
	- [(success,returndata) = target.staticcall(data)](../../share/ThenaGammaPriceFeedAdapter.sol#L1449)

../../share/ThenaGammaPriceFeedAdapter.sol#L1444-L1451


 - [ ] ID-119
Low level call in [Address.functionDelegateCall(address,bytes,string)](../../share/ThenaGammaPriceFeedAdapter.sol#L1469-L1476):
	- [(success,returndata) = target.delegatecall(data)](../../share/ThenaGammaPriceFeedAdapter.sol#L1474)

../../share/ThenaGammaPriceFeedAdapter.sol#L1469-L1476


## naming-convention
Impact: Informational
Confidence: High
 - [ ] ID-120
Variable [ThenaGammaAdapter.UNIPROXY](../../share/ThenaGammaPriceFeedAdapter.sol#L2965) is not in mixedCase

../../share/ThenaGammaPriceFeedAdapter.sol#L2965


 - [ ] ID-121
Variable [ThenaGammaAdapter.REWARD_TOKEN](../../share/ThenaGammaPriceFeedAdapter.sol#L2969) is not in mixedCase

../../share/ThenaGammaPriceFeedAdapter.sol#L2969


 - [ ] ID-122
Variable [ThenaGammaPriceFeedAdapter.FEED_STALE_PRICE_INTERVAL](../../share/ThenaGammaPriceFeedAdapter.sol#L3130) is not in mixedCase

../../share/ThenaGammaPriceFeedAdapter.sol#L3130


 - [ ] ID-123
Variable [ThenaGammaPriceFeedAdapter.TOKEN1_PRICE_FEED](../../share/ThenaGammaPriceFeedAdapter.sol#L3129) is not in mixedCase

../../share/ThenaGammaPriceFeedAdapter.sol#L3129


 - [ ] ID-124
Variable [BaseAdapter.BALANCER](../../share/ThenaGammaPriceFeedAdapter.sol#L2224) is not in mixedCase

../../share/ThenaGammaPriceFeedAdapter.sol#L2224


 - [ ] ID-125
Variable [ThenaGammaAdapter.TOKEN0](../../share/ThenaGammaPriceFeedAdapter.sol#L2967) is not in mixedCase

../../share/ThenaGammaPriceFeedAdapter.sol#L2967


 - [ ] ID-126
Contract [_IBalancer](../../share/ThenaGammaPriceFeedAdapter.sol#L2217-L2219) is not in CapWords

../../share/ThenaGammaPriceFeedAdapter.sol#L2217-L2219


 - [ ] ID-127
Variable [BaseAdapter.SWAP_EXECUTOR](../../share/ThenaGammaPriceFeedAdapter.sol#L2225) is not in mixedCase

../../share/ThenaGammaPriceFeedAdapter.sol#L2225


 - [ ] ID-128
Variable [ThenaGammaPriceFeedAdapter.TOKEN0_PRICE_FEED](../../share/ThenaGammaPriceFeedAdapter.sol#L3128) is not in mixedCase

../../share/ThenaGammaPriceFeedAdapter.sol#L3128


 - [ ] ID-129
Variable [ThenaGammaAdapter.TOKEN1](../../share/ThenaGammaPriceFeedAdapter.sol#L2968) is not in mixedCase

../../share/ThenaGammaPriceFeedAdapter.sol#L2968


 - [ ] ID-130
Function [_IBalancer.SWAP_EXECUTOR()](../../share/ThenaGammaPriceFeedAdapter.sol#L2218) is not in mixedCase

../../share/ThenaGammaPriceFeedAdapter.sol#L2218


 - [ ] ID-131
Function [IERC20Permit.DOMAIN_SEPARATOR()](../../share/ThenaGammaPriceFeedAdapter.sol#L2001) is not in mixedCase

../../share/ThenaGammaPriceFeedAdapter.sol#L2001


 - [ ] ID-132
Variable [ThenaGammaAdapter.PRECISION_MULTIPLIER_1](../../share/ThenaGammaPriceFeedAdapter.sol#L2974) is not in mixedCase

../../share/ThenaGammaPriceFeedAdapter.sol#L2974


 - [ ] ID-133
Variable [ThenaGammaAdapter.HYPERVISOR](../../share/ThenaGammaPriceFeedAdapter.sol#L2964) is not in mixedCase

../../share/ThenaGammaPriceFeedAdapter.sol#L2964


 - [ ] ID-134
Variable [ThenaGammaAdapter.PRECISION_MULTIPLIER_0](../../share/ThenaGammaPriceFeedAdapter.sol#L2973) is not in mixedCase

../../share/ThenaGammaPriceFeedAdapter.sol#L2973


 - [ ] ID-135
Function [IGaugeV2.TOKEN()](../../share/ThenaGammaPriceFeedAdapter.sol#L2329) is not in mixedCase

../../share/ThenaGammaPriceFeedAdapter.sol#L2329


 - [ ] ID-136
Variable [ThenaGammaAdapter.GAUGE](../../share/ThenaGammaPriceFeedAdapter.sol#L2966) is not in mixedCase

../../share/ThenaGammaPriceFeedAdapter.sol#L2966


## similar-names
Impact: Informational
Confidence: Medium
 - [ ] ID-137
Variable [IUniswapV3PoolActions.collect(address,int24,int24,uint128,uint128).amount0Requested](../../share/ThenaGammaPriceFeedAdapter.sol#L2561) is too similar to [IUniswapV3PoolActions.collect(address,int24,int24,uint128,uint128).amount1Requested](../../share/ThenaGammaPriceFeedAdapter.sol#L2562)

../../share/ThenaGammaPriceFeedAdapter.sol#L2561


 - [ ] ID-138
Variable [ThenaGammaPriceFeedAdapter.constructor(address,address,address,address,uint256)._token0PriceFeed](../../share/ThenaGammaPriceFeedAdapter.sol#L3135) is too similar to [ThenaGammaPriceFeedAdapter.constructor(address,address,address,address,uint256)._token1PriceFeed](../../share/ThenaGammaPriceFeedAdapter.sol#L3136)

../../share/ThenaGammaPriceFeedAdapter.sol#L3135


 - [ ] ID-139
Variable [ThenaGammaPriceFeedAdapter.TOKEN0_PRICE_FEED](../../share/ThenaGammaPriceFeedAdapter.sol#L3128) is too similar to [ThenaGammaPriceFeedAdapter.TOKEN1_PRICE_FEED](../../share/ThenaGammaPriceFeedAdapter.sol#L3129)

../../share/ThenaGammaPriceFeedAdapter.sol#L3128


 - [ ] ID-140
Variable [IHypervisor.compound(uint256[4]).baseToken0Owed](../../share/ThenaGammaPriceFeedAdapter.sol#L2801) is too similar to [IHypervisor.compound(uint256[4]).baseToken1Owed](../../share/ThenaGammaPriceFeedAdapter.sol#L2802)

../../share/ThenaGammaPriceFeedAdapter.sol#L2801


 - [ ] ID-141
Variable [IUniswapV3PoolOwnerActions.collectProtocol(address,uint128,uint128).amount0Requested](../../share/ThenaGammaPriceFeedAdapter.sol#L2635) is too similar to [IUniswapV3PoolOwnerActions.collectProtocol(address,uint128,uint128).amount1Requested](../../share/ThenaGammaPriceFeedAdapter.sol#L2636)

../../share/ThenaGammaPriceFeedAdapter.sol#L2635


 - [ ] ID-142
Variable [IHypervisor.compound(uint256[4]).baseToken0Owed](../../share/ThenaGammaPriceFeedAdapter.sol#L2801) is too similar to [IHypervisor.compound().baseToken1Owed](../../share/ThenaGammaPriceFeedAdapter.sol#L2794)

../../share/ThenaGammaPriceFeedAdapter.sol#L2801


 - [ ] ID-143
Variable [IHypervisor.compound().limitToken0Owed](../../share/ThenaGammaPriceFeedAdapter.sol#L2795) is too similar to [IHypervisor.compound(uint256[4]).limitToken1Owed](../../share/ThenaGammaPriceFeedAdapter.sol#L2804)

../../share/ThenaGammaPriceFeedAdapter.sol#L2795


 - [ ] ID-144
Variable [IUniswapV3PoolActions.collect(address,int24,int24,uint128,uint128).amount0Requested](../../share/ThenaGammaPriceFeedAdapter.sol#L2561) is too similar to [IUniswapV3PoolOwnerActions.collectProtocol(address,uint128,uint128).amount1Requested](../../share/ThenaGammaPriceFeedAdapter.sol#L2636)

../../share/ThenaGammaPriceFeedAdapter.sol#L2561


 - [ ] ID-145
Variable [IHypervisor.compound().baseToken0Owed](../../share/ThenaGammaPriceFeedAdapter.sol#L2793) is too similar to [IHypervisor.compound(uint256[4]).baseToken1Owed](../../share/ThenaGammaPriceFeedAdapter.sol#L2802)

../../share/ThenaGammaPriceFeedAdapter.sol#L2793


 - [ ] ID-146
Variable [IUniswapV3PoolState.positions(bytes32).tokensOwed0](../../share/ThenaGammaPriceFeedAdapter.sol#L2457) is too similar to [IUniswapV3PoolState.positions(bytes32).tokensOwed1](../../share/ThenaGammaPriceFeedAdapter.sol#L2458)

../../share/ThenaGammaPriceFeedAdapter.sol#L2457


 - [ ] ID-147
Variable [IUniswapV3PoolState.positions(bytes32).feeGrowthInside0LastX128](../../share/ThenaGammaPriceFeedAdapter.sol#L2455) is too similar to [IUniswapV3PoolState.positions(bytes32).feeGrowthInside1LastX128](../../share/ThenaGammaPriceFeedAdapter.sol#L2456)

../../share/ThenaGammaPriceFeedAdapter.sol#L2455


 - [ ] ID-148
Variable [ThenaGammaAdapter.PRECISION_MULTIPLIER_0](../../share/ThenaGammaPriceFeedAdapter.sol#L2973) is too similar to [ThenaGammaAdapter.PRECISION_MULTIPLIER_1](../../share/ThenaGammaPriceFeedAdapter.sol#L2974)

../../share/ThenaGammaPriceFeedAdapter.sol#L2973


 - [ ] ID-149
Variable [IHypervisor.compound(uint256[4]).limitToken0Owed](../../share/ThenaGammaPriceFeedAdapter.sol#L2803) is too similar to [IHypervisor.compound(uint256[4]).limitToken1Owed](../../share/ThenaGammaPriceFeedAdapter.sol#L2804)

../../share/ThenaGammaPriceFeedAdapter.sol#L2803


 - [ ] ID-150
Variable [IUniswapV3PoolState.ticks(int24).feeGrowthOutside0X128](../../share/ThenaGammaPriceFeedAdapter.sol#L2432) is too similar to [IUniswapV3PoolState.ticks(int24).feeGrowthOutside1X128](../../share/ThenaGammaPriceFeedAdapter.sol#L2433)

../../share/ThenaGammaPriceFeedAdapter.sol#L2432


 - [ ] ID-151
Variable [IUniswapV3PoolOwnerActions.setFeeProtocol(uint8,uint8).feeProtocol0](../../share/ThenaGammaPriceFeedAdapter.sol#L2625) is too similar to [IUniswapV3PoolOwnerActions.setFeeProtocol(uint8,uint8).feeProtocol1](../../share/ThenaGammaPriceFeedAdapter.sol#L2625)

../../share/ThenaGammaPriceFeedAdapter.sol#L2625


 - [ ] ID-152
Variable [IHypervisor.compound().baseToken0Owed](../../share/ThenaGammaPriceFeedAdapter.sol#L2793) is too similar to [IHypervisor.compound().baseToken1Owed](../../share/ThenaGammaPriceFeedAdapter.sol#L2794)

../../share/ThenaGammaPriceFeedAdapter.sol#L2793


 - [ ] ID-153
Variable [IUniswapV3PoolOwnerActions.collectProtocol(address,uint128,uint128).amount0Requested](../../share/ThenaGammaPriceFeedAdapter.sol#L2635) is too similar to [IUniswapV3PoolActions.collect(address,int24,int24,uint128,uint128).amount1Requested](../../share/ThenaGammaPriceFeedAdapter.sol#L2562)

../../share/ThenaGammaPriceFeedAdapter.sol#L2635


 - [ ] ID-154
Variable [IHypervisor.compound(uint256[4]).limitToken0Owed](../../share/ThenaGammaPriceFeedAdapter.sol#L2803) is too similar to [IHypervisor.compound().limitToken1Owed](../../share/ThenaGammaPriceFeedAdapter.sol#L2796)

../../share/ThenaGammaPriceFeedAdapter.sol#L2803


 - [ ] ID-155
Variable [IHypervisor.compound().limitToken0Owed](../../share/ThenaGammaPriceFeedAdapter.sol#L2795) is too similar to [IHypervisor.compound().limitToken1Owed](../../share/ThenaGammaPriceFeedAdapter.sol#L2796)

../../share/ThenaGammaPriceFeedAdapter.sol#L2795


## external-function
Impact: Optimization
Confidence: High
 - [ ] ID-156
token1Decimals() should be declared external:
	- [ThenaGammaAdapter.token1Decimals()](../../share/ThenaGammaPriceFeedAdapter.sol#L3114-L3116)

../../share/ThenaGammaPriceFeedAdapter.sol#L3114-L3116


 - [ ] ID-157
value() should be declared external:
	- [ThenaGammaAdapter.value()](../../share/ThenaGammaPriceFeedAdapter.sol#L3051-L3055)

../../share/ThenaGammaPriceFeedAdapter.sol#L3051-L3055


 - [ ] ID-158
executeSwaps(IBalancer.SwapInfo[]) should be declared external:
	- [SwapExecutor.executeSwaps(IBalancer.SwapInfo[])](../../share/ThenaGammaPriceFeedAdapter.sol#L2207-L2213)

../../share/ThenaGammaPriceFeedAdapter.sol#L2207-L2213


 - [ ] ID-159
token0Decimals() should be declared external:
	- [ThenaGammaAdapter.token0Decimals()](../../share/ThenaGammaPriceFeedAdapter.sol#L3110-L3112)

../../share/ThenaGammaPriceFeedAdapter.sol#L3110-L3112


