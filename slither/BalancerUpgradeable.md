Summary
 - [controlled-delegatecall](#controlled-delegatecall) (1 results) (High)
 - [unprotected-upgrade](#unprotected-upgrade) (1 results) (High)
 - [divide-before-multiply](#divide-before-multiply) (9 results) (Medium)
 - [reentrancy-no-eth](#reentrancy-no-eth) (1 results) (Medium)
 - [uninitialized-local](#uninitialized-local) (4 results) (Medium)
 - [unused-return](#unused-return) (6 results) (Medium)
 - [shadowing-local](#shadowing-local) (1 results) (Low)
 - [missing-zero-check](#missing-zero-check) (2 results) (Low)
 - [calls-loop](#calls-loop) (3 results) (Low)
 - [variable-scope](#variable-scope) (2 results) (Low)
 - [reentrancy-benign](#reentrancy-benign) (2 results) (Low)
 - [reentrancy-events](#reentrancy-events) (4 results) (Low)
 - [timestamp](#timestamp) (3 results) (Low)
 - [assembly](#assembly) (11 results) (Informational)
 - [dead-code](#dead-code) (132 results) (Informational)
 - [solc-version](#solc-version) (2 results) (Informational)
 - [low-level-calls](#low-level-calls) (8 results) (Informational)
 - [naming-convention](#naming-convention) (34 results) (Informational)
 - [similar-names](#similar-names) (5 results) (Informational)
 - [unused-state](#unused-state) (1 results) (Informational)
 - [external-function](#external-function) (13 results) (Optimization)
## controlled-delegatecall
Impact: High
Confidence: Medium
 - [ ] ID-0
[ERC1967UpgradeUpgradeable._functionDelegateCall(address,bytes)](../../share/BalancerUpgradeable.sol#L3707-L3713) uses delegatecall to a input-controlled function id
	- [(success,returndata) = target.delegatecall(data)](../../share/BalancerUpgradeable.sol#L3711)

../../share/BalancerUpgradeable.sol#L3707-L3713


## unprotected-upgrade
Impact: High
Confidence: High
 - [ ] ID-1
[BalancerUpgradeable](../../share/BalancerUpgradeable.sol#L4328-L4732) is an upgradeable contract that does not protect its initiliaze functions: [BalancerUpgradeable.initialize(string,string,address)](../../share/BalancerUpgradeable.sol#L4380-L4388). Anyone can delete the contract with: [UUPSUpgradeable.upgradeTo(address)](../../share/BalancerUpgradeable.sol#L3785-L3788)[UUPSUpgradeable.upgradeToAndCall(address,bytes)](../../share/BalancerUpgradeable.sol#L3798-L3801)
../../share/BalancerUpgradeable.sol#L4328-L4732


## divide-before-multiply
Impact: Medium
Confidence: Medium
 - [ ] ID-2
[BalancerUpgradeable.redeem(uint256,IAdapter,address)](../../share/BalancerUpgradeable.sol#L4444-L4485) performs a multiplication on the result of a division:
	-[redeemValue = shares * nav / ts](../../share/BalancerUpgradeable.sol#L4460)
	-[lpsToRedeem = adapterCache.lpAmount * redeemValue / adapterCache.value](../../share/BalancerUpgradeable.sol#L4472)

../../share/BalancerUpgradeable.sol#L4444-L4485


 - [ ] ID-3
[MathUpgradeable.mulDiv(uint256,uint256,uint256)](../../share/BalancerUpgradeable.sol#L1431-L1511) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/BalancerUpgradeable.sol#L1478)
	-[inverse *= 2 - denominator * inverse](../../share/BalancerUpgradeable.sol#L1500)

../../share/BalancerUpgradeable.sol#L1431-L1511


 - [ ] ID-4
[MathUpgradeable.mulDiv(uint256,uint256,uint256)](../../share/BalancerUpgradeable.sol#L1431-L1511) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/BalancerUpgradeable.sol#L1478)
	-[inverse *= 2 - denominator * inverse](../../share/BalancerUpgradeable.sol#L1499)

../../share/BalancerUpgradeable.sol#L1431-L1511


 - [ ] ID-5
[MathUpgradeable.mulDiv(uint256,uint256,uint256)](../../share/BalancerUpgradeable.sol#L1431-L1511) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/BalancerUpgradeable.sol#L1478)
	-[inverse *= 2 - denominator * inverse](../../share/BalancerUpgradeable.sol#L1497)

../../share/BalancerUpgradeable.sol#L1431-L1511


 - [ ] ID-6
[MathUpgradeable.mulDiv(uint256,uint256,uint256)](../../share/BalancerUpgradeable.sol#L1431-L1511) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/BalancerUpgradeable.sol#L1478)
	-[inverse *= 2 - denominator * inverse](../../share/BalancerUpgradeable.sol#L1501)

../../share/BalancerUpgradeable.sol#L1431-L1511


 - [ ] ID-7
[MathUpgradeable.mulDiv(uint256,uint256,uint256)](../../share/BalancerUpgradeable.sol#L1431-L1511) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/BalancerUpgradeable.sol#L1478)
	-[inverse = (3 * denominator) ^ 2](../../share/BalancerUpgradeable.sol#L1493)

../../share/BalancerUpgradeable.sol#L1431-L1511


 - [ ] ID-8
[MathUpgradeable.mulDiv(uint256,uint256,uint256)](../../share/BalancerUpgradeable.sol#L1431-L1511) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/BalancerUpgradeable.sol#L1478)
	-[inverse *= 2 - denominator * inverse](../../share/BalancerUpgradeable.sol#L1502)

../../share/BalancerUpgradeable.sol#L1431-L1511


 - [ ] ID-9
[MathUpgradeable.mulDiv(uint256,uint256,uint256)](../../share/BalancerUpgradeable.sol#L1431-L1511) performs a multiplication on the result of a division:
	-[denominator = denominator / twos](../../share/BalancerUpgradeable.sol#L1478)
	-[inverse *= 2 - denominator * inverse](../../share/BalancerUpgradeable.sol#L1498)

../../share/BalancerUpgradeable.sol#L1431-L1511


 - [ ] ID-10
[MathUpgradeable.mulDiv(uint256,uint256,uint256)](../../share/BalancerUpgradeable.sol#L1431-L1511) performs a multiplication on the result of a division:
	-[prod0 = prod0 / twos](../../share/BalancerUpgradeable.sol#L1481)
	-[result = prod0 * inverse](../../share/BalancerUpgradeable.sol#L1508)

../../share/BalancerUpgradeable.sol#L1431-L1511


## reentrancy-no-eth
Impact: Medium
Confidence: Medium
 - [ ] ID-11
Reentrancy in [BalancerUpgradeable.rebalance(IAdapter,IAdapter,uint256,IBalancer.SwapInfo[],IBalancer.TransferInfo[],uint256)](../../share/BalancerUpgradeable.sol#L4625-L4674):
	External calls:
	- [fromAdapter.redeem(lpAmount,address(this))](../../share/BalancerUpgradeable.sol#L4646)
	- [SWAP_EXECUTOR.executeSwaps(swaps)](../../share/BalancerUpgradeable.sol#L4652)
	- [(vb,va) = toAdapter.invest(address(this))](../../share/BalancerUpgradeable.sol#L4659)
	State variables written after the call(s):
	- [$lastRebalanceTime = uint32(block.timestamp)](../../share/BalancerUpgradeable.sol#L4672)

../../share/BalancerUpgradeable.sol#L4625-L4674


## uninitialized-local
Impact: Medium
Confidence: Medium
 - [ ] ID-12
[BalancerUpgradeable.invest(address,address).valuePrior](../../share/BalancerUpgradeable.sol#L4400) is a local variable never initialized

../../share/BalancerUpgradeable.sol#L4400


 - [ ] ID-13
[BalancerUpgradeable.invest(address,address).valueAdded](../../share/BalancerUpgradeable.sol#L4401) is a local variable never initialized

../../share/BalancerUpgradeable.sol#L4401


 - [ ] ID-14
[ERC1967UpgradeUpgradeable._upgradeToAndCallUUPS(address,bytes,bool).slot](../../share/BalancerUpgradeable.sol#L3607) is a local variable never initialized

../../share/BalancerUpgradeable.sol#L3607


 - [ ] ID-15
[BalancerUpgradeable.invest(address,address).valueAfter_scope_1](../../share/BalancerUpgradeable.sol#L4420) is a local variable never initialized

../../share/BalancerUpgradeable.sol#L4420


## unused-return
Impact: Medium
Confidence: Medium
 - [ ] ID-16
[BalancerUpgradeable.redeem(uint256,IAdapter,address)](../../share/BalancerUpgradeable.sol#L4444-L4485) ignores return value by [$chargedAdapters.remove(address(targetAdapter))](../../share/BalancerUpgradeable.sol#L4480)

../../share/BalancerUpgradeable.sol#L4444-L4485


 - [ ] ID-17
[BalancerUpgradeable.rebalance(IAdapter,IAdapter,uint256,IBalancer.SwapInfo[],IBalancer.TransferInfo[],uint256)](../../share/BalancerUpgradeable.sol#L4625-L4674) ignores return value by [fromAdapter.redeem(lpAmount,address(this))](../../share/BalancerUpgradeable.sol#L4646)

../../share/BalancerUpgradeable.sol#L4625-L4674


 - [ ] ID-18
[BalancerUpgradeable.invest(address,address)](../../share/BalancerUpgradeable.sol#L4394-L4442) ignores return value by [$chargedAdapters.add(targetAdapter)](../../share/BalancerUpgradeable.sol#L4418)

../../share/BalancerUpgradeable.sol#L4394-L4442


 - [ ] ID-19
[SwapExecutor.executeSwaps(IBalancer.SwapInfo[])](../../share/BalancerUpgradeable.sol#L4318-L4324) ignores return value by [Address.functionCall(swap.callee,swap.data)](../../share/BalancerUpgradeable.sol#L4322)

../../share/BalancerUpgradeable.sol#L4318-L4324


 - [ ] ID-20
[SwapExecutor.executeSwaps(IBalancer.SwapInfo[])](../../share/BalancerUpgradeable.sol#L4318-L4324) ignores return value by [IERC20(swap.token).approve(swap.callee,swap.amount)](../../share/BalancerUpgradeable.sol#L4321)

../../share/BalancerUpgradeable.sol#L4318-L4324


 - [ ] ID-21
[ERC1967UpgradeUpgradeable._upgradeToAndCallUUPS(address,bytes,bool)](../../share/BalancerUpgradeable.sol#L3596-L3614) ignores return value by [IERC1822ProxiableUpgradeable(newImplementation).proxiableUUID()](../../share/BalancerUpgradeable.sol#L3607-L3611)

../../share/BalancerUpgradeable.sol#L3596-L3614


## shadowing-local
Impact: Low
Confidence: High
 - [ ] ID-22
[BalancerUpgradeable.rebalance(IAdapter,IAdapter,uint256,IBalancer.SwapInfo[],IBalancer.TransferInfo[],uint256).transfer](../../share/BalancerUpgradeable.sol#L4655) shadows:
	- [ERC20Upgradeable.transfer(address,uint256)](../../share/BalancerUpgradeable.sol#L629-L633) (function)
	- [IERC20Upgradeable.transfer(address,uint256)](../../share/BalancerUpgradeable.sol#L43) (function)

../../share/BalancerUpgradeable.sol#L4655


## missing-zero-check
Impact: Low
Confidence: Medium
 - [ ] ID-23
[BalancerUpgradeable.initialize(string,string,address).feeReceiver_](../../share/BalancerUpgradeable.sol#L4380) lacks a zero-check on :
		- [$feeReceiver = feeReceiver_](../../share/BalancerUpgradeable.sol#L4384)

../../share/BalancerUpgradeable.sol#L4380


 - [ ] ID-24
[BalancerUpgradeable.setFeeReceiver(address).feeReceiver_](../../share/BalancerUpgradeable.sol#L4571) lacks a zero-check on :
		- [$feeReceiver = feeReceiver_](../../share/BalancerUpgradeable.sol#L4573)

../../share/BalancerUpgradeable.sol#L4571


## calls-loop
Impact: Low
Confidence: Medium
 - [ ] ID-25
[SwapExecutor.executeSwaps(IBalancer.SwapInfo[])](../../share/BalancerUpgradeable.sol#L4318-L4324) has external calls inside a loop: [IERC20(swap.token).approve(swap.callee,swap.amount)](../../share/BalancerUpgradeable.sol#L4321)

../../share/BalancerUpgradeable.sol#L4318-L4324


 - [ ] ID-26
[BalancerUpgradeable.invest(address,address)](../../share/BalancerUpgradeable.sol#L4394-L4442) has external calls inside a loop: [(v) = adapter.value()](../../share/BalancerUpgradeable.sol#L4412)

../../share/BalancerUpgradeable.sol#L4394-L4442


 - [ ] ID-27
[BalancerUpgradeable.invest(address,address)](../../share/BalancerUpgradeable.sol#L4394-L4442) has external calls inside a loop: [(valueBefore,valueAfter) = adapter.invest(receiver)](../../share/BalancerUpgradeable.sol#L4408)

../../share/BalancerUpgradeable.sol#L4394-L4442


## variable-scope
Impact: Low
Confidence: High
 - [ ] ID-28
Variable '[ERC1967UpgradeUpgradeable._upgradeToAndCallUUPS(address,bytes,bool).slot](../../share/BalancerUpgradeable.sol#L3607)' in [ERC1967UpgradeUpgradeable._upgradeToAndCallUUPS(address,bytes,bool)](../../share/BalancerUpgradeable.sol#L3596-L3614) potentially used before declaration: [require(bool,string)(slot == _IMPLEMENTATION_SLOT,ERC1967Upgrade: unsupported proxiableUUID)](../../share/BalancerUpgradeable.sol#L3608)

../../share/BalancerUpgradeable.sol#L3607


 - [ ] ID-29
Variable '[BalancerUpgradeable.invest(address,address).valueAfter](../../share/BalancerUpgradeable.sol#L4408)' in [BalancerUpgradeable.invest(address,address)](../../share/BalancerUpgradeable.sol#L4394-L4442) potentially used before declaration: [(valueAfter) = adapter_scope_0.invest(receiver)](../../share/BalancerUpgradeable.sol#L4420)

../../share/BalancerUpgradeable.sol#L4408


## reentrancy-benign
Impact: Low
Confidence: Medium
 - [ ] ID-30
Reentrancy in [BalancerUpgradeable.invest(address,address)](../../share/BalancerUpgradeable.sol#L4394-L4442):
	External calls:
	- [(valueAfter) = adapter_scope_0.invest(receiver)](../../share/BalancerUpgradeable.sol#L4420)
	State variables written after the call(s):
	- [_mint(receiver,sharesWithChargedFee)](../../share/BalancerUpgradeable.sol#L4440)
		- [_balances[account] += amount](../../share/BalancerUpgradeable.sol#L783)
	- [_mint(receiver,sharesWithChargedFee)](../../share/BalancerUpgradeable.sol#L4440)
		- [_totalSupply += amount](../../share/BalancerUpgradeable.sol#L780)

../../share/BalancerUpgradeable.sol#L4394-L4442


 - [ ] ID-31
Reentrancy in [BalancerUpgradeable.compound(address,uint256,IBalancer.SwapInfo[])](../../share/BalancerUpgradeable.sol#L4676-L4689):
	External calls:
	- [(valueBefore,valueAfter) = IAdapter(adapter).compound(swaps)](../../share/BalancerUpgradeable.sol#L4684)
	State variables written after the call(s):
	- [_lockValue(SafeCastUpgradeable.toUint112(addedValue),SafeCastUpgradeable.toUint112(fee))](../../share/BalancerUpgradeable.sol#L4688)
		- [$lastValueLock = uint32(block.timestamp)](../../share/BalancerUpgradeable.sol#L4726)
	- [_lockValue(SafeCastUpgradeable.toUint112(addedValue),SafeCastUpgradeable.toUint112(fee))](../../share/BalancerUpgradeable.sol#L4688)
		- [$valueDecayTarget -= lockedFee](../../share/BalancerUpgradeable.sol#L4719)
		- [$valueDecayTarget += feeToLock](../../share/BalancerUpgradeable.sol#L4724)
	- [_lockValue(SafeCastUpgradeable.toUint112(addedValue),SafeCastUpgradeable.toUint112(fee))](../../share/BalancerUpgradeable.sol#L4688)
		- [$valueReleaseTarget = lockedProfit + profitToLock](../../share/BalancerUpgradeable.sol#L4714)
	- [_lockValue(SafeCastUpgradeable.toUint112(addedValue),SafeCastUpgradeable.toUint112(fee))](../../share/BalancerUpgradeable.sol#L4688)
		- [_balances[account] += amount](../../share/BalancerUpgradeable.sol#L783)
	- [_lockValue(SafeCastUpgradeable.toUint112(addedValue),SafeCastUpgradeable.toUint112(fee))](../../share/BalancerUpgradeable.sol#L4688)
		- [_totalSupply += amount](../../share/BalancerUpgradeable.sol#L780)

../../share/BalancerUpgradeable.sol#L4676-L4689


## reentrancy-events
Impact: Low
Confidence: Medium
 - [ ] ID-32
Reentrancy in [BalancerUpgradeable.compound(address,uint256,IBalancer.SwapInfo[])](../../share/BalancerUpgradeable.sol#L4676-L4689):
	External calls:
	- [(valueBefore,valueAfter) = IAdapter(adapter).compound(swaps)](../../share/BalancerUpgradeable.sol#L4684)
	Event emitted after the call(s):
	- [ProfitLocked(tv,profitToLock,feeToLock,block.timestamp + VALUE_DEGRADATION_DURATION)](../../share/BalancerUpgradeable.sol#L4727)
		- [_lockValue(SafeCastUpgradeable.toUint112(addedValue),SafeCastUpgradeable.toUint112(fee))](../../share/BalancerUpgradeable.sol#L4688)
	- [Transfer(address(0),account,amount)](../../share/BalancerUpgradeable.sol#L785)
		- [_lockValue(SafeCastUpgradeable.toUint112(addedValue),SafeCastUpgradeable.toUint112(fee))](../../share/BalancerUpgradeable.sol#L4688)

../../share/BalancerUpgradeable.sol#L4676-L4689


 - [ ] ID-33
Reentrancy in [BalancerUpgradeable.rebalance(IAdapter,IAdapter,uint256,IBalancer.SwapInfo[],IBalancer.TransferInfo[],uint256)](../../share/BalancerUpgradeable.sol#L4625-L4674):
	External calls:
	- [fromAdapter.redeem(lpAmount,address(this))](../../share/BalancerUpgradeable.sol#L4646)
	- [SWAP_EXECUTOR.executeSwaps(swaps)](../../share/BalancerUpgradeable.sol#L4652)
	- [(vb,va) = toAdapter.invest(address(this))](../../share/BalancerUpgradeable.sol#L4659)
	Event emitted after the call(s):
	- [Rebalance(address(fromAdapter),address(toAdapter),lpAmount)](../../share/BalancerUpgradeable.sol#L4673)

../../share/BalancerUpgradeable.sol#L4625-L4674


 - [ ] ID-34
Reentrancy in [BalancerUpgradeable.redeem(uint256,IAdapter,address)](../../share/BalancerUpgradeable.sol#L4444-L4485):
	External calls:
	- [(tokens,amounts) = targetAdapter.redeem(lpsToRedeem,receiver)](../../share/BalancerUpgradeable.sol#L4483)
	Event emitted after the call(s):
	- [Redeem(address(targetAdapter),receiver,shares)](../../share/BalancerUpgradeable.sol#L4484)

../../share/BalancerUpgradeable.sol#L4444-L4485


 - [ ] ID-35
Reentrancy in [BalancerUpgradeable.invest(address,address)](../../share/BalancerUpgradeable.sol#L4394-L4442):
	External calls:
	- [(valueAfter) = adapter_scope_0.invest(receiver)](../../share/BalancerUpgradeable.sol#L4420)
	Event emitted after the call(s):
	- [Invest(targetAdapter,receiver,valuePrior,valueAdded,sharesAdded,sharesWithChargedFee)](../../share/BalancerUpgradeable.sol#L4441)
	- [Transfer(address(0),account,amount)](../../share/BalancerUpgradeable.sol#L785)
		- [_mint(receiver,sharesWithChargedFee)](../../share/BalancerUpgradeable.sol#L4440)

../../share/BalancerUpgradeable.sol#L4394-L4442


## timestamp
Impact: Low
Confidence: Medium
 - [ ] ID-36
[BalancerUpgradeable._lockedFunds()](../../share/BalancerUpgradeable.sol#L4491-L4505) uses timestamp for comparisons
	Dangerous comparisons:
	- [degradationRatio < VALUE_DEGRADATION_COEFFICIENT](../../share/BalancerUpgradeable.sol#L4494)
	- [degradationRatio < VALUE_DEGRADATION_COEFFICIENT](../../share/BalancerUpgradeable.sol#L4500)

../../share/BalancerUpgradeable.sol#L4491-L4505


 - [ ] ID-37
[BalancerUpgradeable.rebalance(IAdapter,IAdapter,uint256,IBalancer.SwapInfo[],IBalancer.TransferInfo[],uint256)](../../share/BalancerUpgradeable.sol#L4625-L4674) uses timestamp for comparisons
	Dangerous comparisons:
	- [$lastRebalanceTime + REBALANCE_COOLDOWN > block.timestamp](../../share/BalancerUpgradeable.sol#L4636)

../../share/BalancerUpgradeable.sol#L4625-L4674


 - [ ] ID-38
[BalancerUpgradeable.takePerformanceFee(uint112)](../../share/BalancerUpgradeable.sol#L4691-L4707) uses timestamp for comparisons
	Dangerous comparisons:
	- [$lastTakeProfitTime + TAKE_PROFIT_COOLDOWN > block.timestamp](../../share/BalancerUpgradeable.sol#L4692)

../../share/BalancerUpgradeable.sol#L4691-L4707


## assembly
Impact: Informational
Confidence: High
 - [ ] ID-39
[Address._revert(bytes,string)](../../share/BalancerUpgradeable.sol#L4301-L4313) uses assembly
	- [INLINE ASM](../../share/BalancerUpgradeable.sol#L4306-L4309)

../../share/BalancerUpgradeable.sol#L4301-L4313


 - [ ] ID-40
[StringsUpgradeable.toString(uint256)](../../share/BalancerUpgradeable.sol#L1733-L1753) uses assembly
	- [INLINE ASM](../../share/BalancerUpgradeable.sol#L1739-L1741)
	- [INLINE ASM](../../share/BalancerUpgradeable.sol#L1745-L1747)

../../share/BalancerUpgradeable.sol#L1733-L1753


 - [ ] ID-41
[AddressUpgradeable._revert(bytes,string)](../../share/BalancerUpgradeable.sol#L316-L328) uses assembly
	- [INLINE ASM](../../share/BalancerUpgradeable.sol#L321-L324)

../../share/BalancerUpgradeable.sol#L316-L328


 - [ ] ID-42
[EnumerableSetUpgradeable.values(EnumerableSetUpgradeable.AddressSet)](../../share/BalancerUpgradeable.sol#L1203-L1213) uses assembly
	- [INLINE ASM](../../share/BalancerUpgradeable.sol#L1208-L1210)

../../share/BalancerUpgradeable.sol#L1203-L1213


 - [ ] ID-43
[StorageSlotUpgradeable.getUint256Slot(bytes32)](../../share/BalancerUpgradeable.sol#L3513-L3518) uses assembly
	- [INLINE ASM](../../share/BalancerUpgradeable.sol#L3515-L3517)

../../share/BalancerUpgradeable.sol#L3513-L3518


 - [ ] ID-44
[StorageSlotUpgradeable.getBytes32Slot(bytes32)](../../share/BalancerUpgradeable.sol#L3503-L3508) uses assembly
	- [INLINE ASM](../../share/BalancerUpgradeable.sol#L3505-L3507)

../../share/BalancerUpgradeable.sol#L3503-L3508


 - [ ] ID-45
[StorageSlotUpgradeable.getAddressSlot(bytes32)](../../share/BalancerUpgradeable.sol#L3483-L3488) uses assembly
	- [INLINE ASM](../../share/BalancerUpgradeable.sol#L3485-L3487)

../../share/BalancerUpgradeable.sol#L3483-L3488


 - [ ] ID-46
[StorageSlotUpgradeable.getBooleanSlot(bytes32)](../../share/BalancerUpgradeable.sol#L3493-L3498) uses assembly
	- [INLINE ASM](../../share/BalancerUpgradeable.sol#L3495-L3497)

../../share/BalancerUpgradeable.sol#L3493-L3498


 - [ ] ID-47
[EnumerableSetUpgradeable.values(EnumerableSetUpgradeable.UintSet)](../../share/BalancerUpgradeable.sol#L1277-L1287) uses assembly
	- [INLINE ASM](../../share/BalancerUpgradeable.sol#L1282-L1284)

../../share/BalancerUpgradeable.sol#L1277-L1287


 - [ ] ID-48
[EnumerableSetUpgradeable.values(EnumerableSetUpgradeable.Bytes32Set)](../../share/BalancerUpgradeable.sol#L1129-L1139) uses assembly
	- [INLINE ASM](../../share/BalancerUpgradeable.sol#L1134-L1136)

../../share/BalancerUpgradeable.sol#L1129-L1139


 - [ ] ID-49
[MathUpgradeable.mulDiv(uint256,uint256,uint256)](../../share/BalancerUpgradeable.sol#L1431-L1511) uses assembly
	- [INLINE ASM](../../share/BalancerUpgradeable.sol#L1442-L1446)
	- [INLINE ASM](../../share/BalancerUpgradeable.sol#L1462-L1469)
	- [INLINE ASM](../../share/BalancerUpgradeable.sol#L1476-L1485)

../../share/BalancerUpgradeable.sol#L1431-L1511


## dead-code
Impact: Informational
Confidence: Medium
 - [ ] ID-50
[SafeCastUpgradeable.toUint104(uint256)](../../share/BalancerUpgradeable.sol#L2434-L2437) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2434-L2437


 - [ ] ID-51
[StringsUpgradeable.toString(uint256)](../../share/BalancerUpgradeable.sol#L1733-L1753) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1733-L1753


 - [ ] ID-52
[ContextUpgradeable._msgData()](../../share/BalancerUpgradeable.sol#L510-L512) is never used and should be removed

../../share/BalancerUpgradeable.sol#L510-L512


 - [ ] ID-53
[MathUpgradeable.log2(uint256,MathUpgradeable.Rounding)](../../share/BalancerUpgradeable.sol#L1623-L1628) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1623-L1628


 - [ ] ID-54
[SafeCastUpgradeable.toUint248(uint256)](../../share/BalancerUpgradeable.sol#L2128-L2131) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2128-L2131


 - [ ] ID-55
[Initializable._isInitializing()](../../share/BalancerUpgradeable.sol#L485-L487) is never used and should be removed

../../share/BalancerUpgradeable.sol#L485-L487


 - [ ] ID-56
[Address.verifyCallResult(bool,bytes,string)](../../share/BalancerUpgradeable.sol#L4289-L4299) is never used and should be removed

../../share/BalancerUpgradeable.sol#L4289-L4299


 - [ ] ID-57
[AddressUpgradeable.functionCallWithValue(address,bytes,uint256)](../../share/BalancerUpgradeable.sol#L224-L230) is never used and should be removed

../../share/BalancerUpgradeable.sol#L224-L230


 - [ ] ID-58
[MathUpgradeable.ceilDiv(uint256,uint256)](../../share/BalancerUpgradeable.sol#L1421-L1424) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1421-L1424


 - [ ] ID-59
[EnumerableSetUpgradeable.values(EnumerableSetUpgradeable.Bytes32Set)](../../share/BalancerUpgradeable.sol#L1129-L1139) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1129-L1139


 - [ ] ID-60
[MathUpgradeable.min(uint256,uint256)](../../share/BalancerUpgradeable.sol#L1402-L1404) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1402-L1404


 - [ ] ID-61
[SafeERC20Upgradeable.safeApprove(IERC20Upgradeable,address,uint256)](../../share/BalancerUpgradeable.sol#L3327-L3340) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3327-L3340


 - [ ] ID-62
[SafeCastUpgradeable.toUint216(uint256)](../../share/BalancerUpgradeable.sol#L2196-L2199) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2196-L2199


 - [ ] ID-63
[MathUpgradeable.sqrt(uint256)](../../share/BalancerUpgradeable.sol#L1534-L1565) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1534-L1565


 - [ ] ID-64
[Address.sendValue(address,uint256)](../../share/BalancerUpgradeable.sol#L4130-L4135) is never used and should be removed

../../share/BalancerUpgradeable.sol#L4130-L4135


 - [ ] ID-65
[ERC1967UpgradeUpgradeable.__ERC1967Upgrade_init_unchained()](../../share/BalancerUpgradeable.sol#L3533-L3534) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3533-L3534


 - [ ] ID-66
[SafeCastUpgradeable.toInt216(int256)](../../share/BalancerUpgradeable.sol#L2742-L2745) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2742-L2745


 - [ ] ID-67
[EnumerableSetUpgradeable.remove(EnumerableSetUpgradeable.UintSet,uint256)](../../share/BalancerUpgradeable.sol#L1237-L1239) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1237-L1239


 - [ ] ID-68
[SafeCastUpgradeable.toInt112(int256)](../../share/BalancerUpgradeable.sol#L2976-L2979) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2976-L2979


 - [ ] ID-69
[Address.functionCallWithValue(address,bytes,uint256)](../../share/BalancerUpgradeable.sol#L4184-L4190) is never used and should be removed

../../share/BalancerUpgradeable.sol#L4184-L4190


 - [ ] ID-70
[SafeCastUpgradeable.toUint88(uint256)](../../share/BalancerUpgradeable.sol#L2468-L2471) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2468-L2471


 - [ ] ID-71
[SafeCastUpgradeable.toInt72(int256)](../../share/BalancerUpgradeable.sol#L3066-L3069) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3066-L3069


 - [ ] ID-72
[SafeCastUpgradeable.toUint200(uint256)](../../share/BalancerUpgradeable.sol#L2230-L2233) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2230-L2233


 - [ ] ID-73
[SafeERC20Upgradeable.safeIncreaseAllowance(IERC20Upgradeable,address,uint256)](../../share/BalancerUpgradeable.sol#L3342-L3349) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3342-L3349


 - [ ] ID-74
[SafeCastUpgradeable.toUint64(uint256)](../../share/BalancerUpgradeable.sol#L2519-L2522) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2519-L2522


 - [ ] ID-75
[SafeCastUpgradeable.toInt16(int256)](../../share/BalancerUpgradeable.sol#L3192-L3195) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3192-L3195


 - [ ] ID-76
[SafeCastUpgradeable.toUint192(uint256)](../../share/BalancerUpgradeable.sol#L2247-L2250) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2247-L2250


 - [ ] ID-77
[Address.functionDelegateCall(address,bytes,string)](../../share/BalancerUpgradeable.sol#L4250-L4257) is never used and should be removed

../../share/BalancerUpgradeable.sol#L4250-L4257


 - [ ] ID-78
[SafeCastUpgradeable.toInt40(int256)](../../share/BalancerUpgradeable.sol#L3138-L3141) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3138-L3141


 - [ ] ID-79
[SafeCastUpgradeable.toUint160(uint256)](../../share/BalancerUpgradeable.sol#L2315-L2318) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2315-L2318


 - [ ] ID-80
[MathUpgradeable.log10(uint256,MathUpgradeable.Rounding)](../../share/BalancerUpgradeable.sol#L1672-L1677) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1672-L1677


 - [ ] ID-81
[AddressUpgradeable.functionCall(address,bytes)](../../share/BalancerUpgradeable.sol#L195-L197) is never used and should be removed

../../share/BalancerUpgradeable.sol#L195-L197


 - [ ] ID-82
[ERC1967UpgradeUpgradeable._getBeacon()](../../share/BalancerUpgradeable.sol#L3667-L3669) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3667-L3669


 - [ ] ID-83
[SafeCastUpgradeable.toUint40(uint256)](../../share/BalancerUpgradeable.sol#L2570-L2573) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2570-L2573


 - [ ] ID-84
[ContextUpgradeable.__Context_init_unchained()](../../share/BalancerUpgradeable.sol#L504-L505) is never used and should be removed

../../share/BalancerUpgradeable.sol#L504-L505


 - [ ] ID-85
[ERC165Upgradeable.__ERC165_init_unchained()](../../share/BalancerUpgradeable.sol#L1830-L1831) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1830-L1831


 - [ ] ID-86
[SafeCastUpgradeable.toUint8(uint256)](../../share/BalancerUpgradeable.sol#L2638-L2641) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2638-L2641


 - [ ] ID-87
[SafeCastUpgradeable.toInt80(int256)](../../share/BalancerUpgradeable.sol#L3048-L3051) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3048-L3051


 - [ ] ID-88
[SafeCastUpgradeable.toInt248(int256)](../../share/BalancerUpgradeable.sol#L2670-L2673) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2670-L2673


 - [ ] ID-89
[MathUpgradeable.mulDiv(uint256,uint256,uint256)](../../share/BalancerUpgradeable.sol#L1431-L1511) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1431-L1511


 - [ ] ID-90
[SafeCastUpgradeable.toUint16(uint256)](../../share/BalancerUpgradeable.sol#L2621-L2624) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2621-L2624


 - [ ] ID-91
[SafeCastUpgradeable.toUint256(int256)](../../share/BalancerUpgradeable.sol#L2652-L2655) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2652-L2655


 - [ ] ID-92
[SafeCastUpgradeable.toUint208(uint256)](../../share/BalancerUpgradeable.sol#L2213-L2216) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2213-L2216


 - [ ] ID-93
[SafeCastUpgradeable.toUint144(uint256)](../../share/BalancerUpgradeable.sol#L2349-L2352) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2349-L2352


 - [ ] ID-94
[SafeCastUpgradeable.toInt176(int256)](../../share/BalancerUpgradeable.sol#L2832-L2835) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2832-L2835


 - [ ] ID-95
[SafeERC20Upgradeable.safeTransferFrom(IERC20Upgradeable,address,address,uint256)](../../share/BalancerUpgradeable.sol#L3311-L3318) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3311-L3318


 - [ ] ID-96
[SafeCastUpgradeable.toInt128(int256)](../../share/BalancerUpgradeable.sol#L2940-L2943) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2940-L2943


 - [ ] ID-97
[StorageSlotUpgradeable.getUint256Slot(bytes32)](../../share/BalancerUpgradeable.sol#L3513-L3518) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3513-L3518


 - [ ] ID-98
[Address.functionDelegateCall(address,bytes)](../../share/BalancerUpgradeable.sol#L4240-L4242) is never used and should be removed

../../share/BalancerUpgradeable.sol#L4240-L4242


 - [ ] ID-99
[SafeCastUpgradeable.toInt96(int256)](../../share/BalancerUpgradeable.sol#L3012-L3015) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3012-L3015


 - [ ] ID-100
[SafeCastUpgradeable.toInt152(int256)](../../share/BalancerUpgradeable.sol#L2886-L2889) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2886-L2889


 - [ ] ID-101
[AddressUpgradeable.sendValue(address,uint256)](../../share/BalancerUpgradeable.sol#L170-L175) is never used and should be removed

../../share/BalancerUpgradeable.sol#L170-L175


 - [ ] ID-102
[SafeCastUpgradeable.toInt208(int256)](../../share/BalancerUpgradeable.sol#L2760-L2763) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2760-L2763


 - [ ] ID-103
[SafeCastUpgradeable.toInt64(int256)](../../share/BalancerUpgradeable.sol#L3084-L3087) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3084-L3087


 - [ ] ID-104
[SafeCastUpgradeable.toUint48(uint256)](../../share/BalancerUpgradeable.sol#L2553-L2556) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2553-L2556


 - [ ] ID-105
[SafeCastUpgradeable.toInt48(int256)](../../share/BalancerUpgradeable.sol#L3120-L3123) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3120-L3123


 - [ ] ID-106
[EnumerableSetUpgradeable.remove(EnumerableSetUpgradeable.Bytes32Set,bytes32)](../../share/BalancerUpgradeable.sol#L1089-L1091) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1089-L1091


 - [ ] ID-107
[SafeCastUpgradeable.toInt136(int256)](../../share/BalancerUpgradeable.sol#L2922-L2925) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2922-L2925


 - [ ] ID-108
[AddressUpgradeable.functionStaticCall(address,bytes)](../../share/BalancerUpgradeable.sol#L255-L257) is never used and should be removed

../../share/BalancerUpgradeable.sol#L255-L257


 - [ ] ID-109
[EnumerableSetUpgradeable.values(EnumerableSetUpgradeable.UintSet)](../../share/BalancerUpgradeable.sol#L1277-L1287) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1277-L1287


 - [ ] ID-110
[ERC1967UpgradeUpgradeable._upgradeBeaconToAndCall(address,bytes,bool)](../../share/BalancerUpgradeable.sol#L3689-L3699) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3689-L3699


 - [ ] ID-111
[MathUpgradeable.sqrt(uint256,MathUpgradeable.Rounding)](../../share/BalancerUpgradeable.sol#L1570-L1575) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1570-L1575


 - [ ] ID-112
[SafeCastUpgradeable.toInt168(int256)](../../share/BalancerUpgradeable.sol#L2850-L2853) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2850-L2853


 - [ ] ID-113
[SafeCastUpgradeable.toInt200(int256)](../../share/BalancerUpgradeable.sol#L2778-L2781) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2778-L2781


 - [ ] ID-114
[EnumerableSetUpgradeable.contains(EnumerableSetUpgradeable.Bytes32Set,bytes32)](../../share/BalancerUpgradeable.sol#L1096-L1098) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1096-L1098


 - [ ] ID-115
[MathUpgradeable.log2(uint256)](../../share/BalancerUpgradeable.sol#L1581-L1617) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1581-L1617


 - [ ] ID-116
[SafeCastUpgradeable.toUint152(uint256)](../../share/BalancerUpgradeable.sol#L2332-L2335) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2332-L2335


 - [ ] ID-117
[AccessControlUpgradeable._setRoleAdmin(bytes32,bytes32)](../../share/BalancerUpgradeable.sol#L2055-L2059) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2055-L2059


 - [ ] ID-118
[MathUpgradeable.average(uint256,uint256)](../../share/BalancerUpgradeable.sol#L1410-L1413) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1410-L1413


 - [ ] ID-119
[SafeCastUpgradeable.toInt32(int256)](../../share/BalancerUpgradeable.sol#L3156-L3159) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3156-L3159


 - [ ] ID-120
[SafeCastUpgradeable.toInt160(int256)](../../share/BalancerUpgradeable.sol#L2868-L2871) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2868-L2871


 - [ ] ID-121
[EnumerableSetUpgradeable.add(EnumerableSetUpgradeable.UintSet,uint256)](../../share/BalancerUpgradeable.sol#L1227-L1229) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1227-L1229


 - [ ] ID-122
[SafeCastUpgradeable.toUint120(uint256)](../../share/BalancerUpgradeable.sol#L2400-L2403) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2400-L2403


 - [ ] ID-123
[StringsUpgradeable.toHexString(uint256)](../../share/BalancerUpgradeable.sol#L1758-L1762) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1758-L1762


 - [ ] ID-124
[SafeERC20Upgradeable.safeDecreaseAllowance(IERC20Upgradeable,address,uint256)](../../share/BalancerUpgradeable.sol#L3351-L3362) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3351-L3362


 - [ ] ID-125
[SafeCastUpgradeable.toUint168(uint256)](../../share/BalancerUpgradeable.sol#L2298-L2301) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2298-L2301


 - [ ] ID-126
[SafeCastUpgradeable.toUint24(uint256)](../../share/BalancerUpgradeable.sol#L2604-L2607) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2604-L2607


 - [ ] ID-127
[Address.functionStaticCall(address,bytes)](../../share/BalancerUpgradeable.sol#L4215-L4217) is never used and should be removed

../../share/BalancerUpgradeable.sol#L4215-L4217


 - [ ] ID-128
[MathUpgradeable.log10(uint256)](../../share/BalancerUpgradeable.sol#L1634-L1666) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1634-L1666


 - [ ] ID-129
[ERC165Upgradeable.__ERC165_init()](../../share/BalancerUpgradeable.sol#L1827-L1828) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1827-L1828


 - [ ] ID-130
[ERC1967UpgradeUpgradeable._setBeacon(address)](../../share/BalancerUpgradeable.sol#L3674-L3681) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3674-L3681


 - [ ] ID-131
[SafeCastUpgradeable.toInt256(uint256)](../../share/BalancerUpgradeable.sol#L3224-L3228) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3224-L3228


 - [ ] ID-132
[SafeCastUpgradeable.toUint176(uint256)](../../share/BalancerUpgradeable.sol#L2281-L2284) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2281-L2284


 - [ ] ID-133
[SafeCastUpgradeable.toInt8(int256)](../../share/BalancerUpgradeable.sol#L3210-L3213) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3210-L3213


 - [ ] ID-134
[UUPSUpgradeable.__UUPSUpgradeable_init()](../../share/BalancerUpgradeable.sol#L3736-L3737) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3736-L3737


 - [ ] ID-135
[EnumerableSetUpgradeable.length(EnumerableSetUpgradeable.UintSet)](../../share/BalancerUpgradeable.sol#L1251-L1253) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1251-L1253


 - [ ] ID-136
[SafeERC20Upgradeable.safePermit(IERC20PermitUpgradeable,address,address,uint256,uint256,uint8,bytes32,bytes32)](../../share/BalancerUpgradeable.sol#L3364-L3378) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3364-L3378


 - [ ] ID-137
[ERC1967UpgradeUpgradeable.__ERC1967Upgrade_init()](../../share/BalancerUpgradeable.sol#L3530-L3531) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3530-L3531


 - [ ] ID-138
[MathUpgradeable.mulDiv(uint256,uint256,uint256,MathUpgradeable.Rounding)](../../share/BalancerUpgradeable.sol#L1516-L1527) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1516-L1527


 - [ ] ID-139
[SafeCastUpgradeable.toInt240(int256)](../../share/BalancerUpgradeable.sol#L2688-L2691) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2688-L2691


 - [ ] ID-140
[EnumerableSetUpgradeable.add(EnumerableSetUpgradeable.Bytes32Set,bytes32)](../../share/BalancerUpgradeable.sol#L1079-L1081) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1079-L1081


 - [ ] ID-141
[ERC1967UpgradeUpgradeable._setAdmin(address)](../../share/BalancerUpgradeable.sol#L3638-L3641) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3638-L3641


 - [ ] ID-142
[SafeCastUpgradeable.toInt144(int256)](../../share/BalancerUpgradeable.sol#L2904-L2907) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2904-L2907


 - [ ] ID-143
[UUPSUpgradeable.__UUPSUpgradeable_init_unchained()](../../share/BalancerUpgradeable.sol#L3739-L3740) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3739-L3740


 - [ ] ID-144
[SafeCastUpgradeable.toUint240(uint256)](../../share/BalancerUpgradeable.sol#L2145-L2148) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2145-L2148


 - [ ] ID-145
[EnumerableSetUpgradeable.at(EnumerableSetUpgradeable.UintSet,uint256)](../../share/BalancerUpgradeable.sol#L1265-L1267) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1265-L1267


 - [ ] ID-146
[StorageSlotUpgradeable.getBytes32Slot(bytes32)](../../share/BalancerUpgradeable.sol#L3503-L3508) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3503-L3508


 - [ ] ID-147
[ERC1967UpgradeUpgradeable._changeAdmin(address)](../../share/BalancerUpgradeable.sol#L3648-L3651) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3648-L3651


 - [ ] ID-148
[SafeCastUpgradeable.toUint56(uint256)](../../share/BalancerUpgradeable.sol#L2536-L2539) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2536-L2539


 - [ ] ID-149
[SafeCastUpgradeable.toUint72(uint256)](../../share/BalancerUpgradeable.sol#L2502-L2505) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2502-L2505


 - [ ] ID-150
[AccessControlUpgradeable.__AccessControl_init_unchained()](../../share/BalancerUpgradeable.sol#L1889-L1890) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1889-L1890


 - [ ] ID-151
[Initializable._getInitializedVersion()](../../share/BalancerUpgradeable.sol#L478-L480) is never used and should be removed

../../share/BalancerUpgradeable.sol#L478-L480


 - [ ] ID-152
[SafeCastUpgradeable.toInt224(int256)](../../share/BalancerUpgradeable.sol#L2724-L2727) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2724-L2727


 - [ ] ID-153
[EnumerableSetUpgradeable.length(EnumerableSetUpgradeable.Bytes32Set)](../../share/BalancerUpgradeable.sol#L1103-L1105) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1103-L1105


 - [ ] ID-154
[AccessControlUpgradeable._setupRole(bytes32,address)](../../share/BalancerUpgradeable.sol#L2046-L2048) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2046-L2048


 - [ ] ID-155
[SafeCastUpgradeable.toInt232(int256)](../../share/BalancerUpgradeable.sol#L2706-L2709) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2706-L2709


 - [ ] ID-156
[SafeCastUpgradeable.toUint32(uint256)](../../share/BalancerUpgradeable.sol#L2587-L2590) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2587-L2590


 - [ ] ID-157
[EnumerableSetUpgradeable.at(EnumerableSetUpgradeable.Bytes32Set,uint256)](../../share/BalancerUpgradeable.sol#L1117-L1119) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1117-L1119


 - [ ] ID-158
[SafeCastUpgradeable.toInt120(int256)](../../share/BalancerUpgradeable.sol#L2958-L2961) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2958-L2961


 - [ ] ID-159
[ERC1967UpgradeUpgradeable._getAdmin()](../../share/BalancerUpgradeable.sol#L3631-L3633) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3631-L3633


 - [ ] ID-160
[SafeCastUpgradeable.toUint128(uint256)](../../share/BalancerUpgradeable.sol#L2383-L2386) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2383-L2386


 - [ ] ID-161
[AddressUpgradeable.functionStaticCall(address,bytes,string)](../../share/BalancerUpgradeable.sol#L265-L272) is never used and should be removed

../../share/BalancerUpgradeable.sol#L265-L272


 - [ ] ID-162
[Initializable._disableInitializers()](../../share/BalancerUpgradeable.sol#L467-L473) is never used and should be removed

../../share/BalancerUpgradeable.sol#L467-L473


 - [ ] ID-163
[SafeCastUpgradeable.toUint80(uint256)](../../share/BalancerUpgradeable.sol#L2485-L2488) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2485-L2488


 - [ ] ID-164
[SafeCastUpgradeable.toInt104(int256)](../../share/BalancerUpgradeable.sol#L2994-L2997) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2994-L2997


 - [ ] ID-165
[Address.functionCall(address,bytes,string)](../../share/BalancerUpgradeable.sol#L4165-L4171) is never used and should be removed

../../share/BalancerUpgradeable.sol#L4165-L4171


 - [ ] ID-166
[MathUpgradeable.log256(uint256,MathUpgradeable.Rounding)](../../share/BalancerUpgradeable.sol#L1715-L1720) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1715-L1720


 - [ ] ID-167
[SafeCastUpgradeable.toUint96(uint256)](../../share/BalancerUpgradeable.sol#L2451-L2454) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2451-L2454


 - [ ] ID-168
[SafeCastUpgradeable.toUint136(uint256)](../../share/BalancerUpgradeable.sol#L2366-L2369) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2366-L2369


 - [ ] ID-169
[SafeCastUpgradeable.toUint232(uint256)](../../share/BalancerUpgradeable.sol#L2162-L2165) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2162-L2165


 - [ ] ID-170
[Address.functionStaticCall(address,bytes,string)](../../share/BalancerUpgradeable.sol#L4225-L4232) is never used and should be removed

../../share/BalancerUpgradeable.sol#L4225-L4232


 - [ ] ID-171
[SafeCastUpgradeable.toUint184(uint256)](../../share/BalancerUpgradeable.sol#L2264-L2267) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2264-L2267


 - [ ] ID-172
[SafeCastUpgradeable.toInt184(int256)](../../share/BalancerUpgradeable.sol#L2814-L2817) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2814-L2817


 - [ ] ID-173
[MathUpgradeable.max(uint256,uint256)](../../share/BalancerUpgradeable.sol#L1395-L1397) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1395-L1397


 - [ ] ID-174
[SafeCastUpgradeable.toUint224(uint256)](../../share/BalancerUpgradeable.sol#L2179-L2182) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2179-L2182


 - [ ] ID-175
[SafeCastUpgradeable.toInt24(int256)](../../share/BalancerUpgradeable.sol#L3174-L3177) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3174-L3177


 - [ ] ID-176
[SafeCastUpgradeable.toInt88(int256)](../../share/BalancerUpgradeable.sol#L3030-L3033) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3030-L3033


 - [ ] ID-177
[EnumerableSetUpgradeable.contains(EnumerableSetUpgradeable.UintSet,uint256)](../../share/BalancerUpgradeable.sol#L1244-L1246) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1244-L1246


 - [ ] ID-178
[ContextUpgradeable.__Context_init()](../../share/BalancerUpgradeable.sol#L501-L502) is never used and should be removed

../../share/BalancerUpgradeable.sol#L501-L502


 - [ ] ID-179
[MathUpgradeable.log256(uint256)](../../share/BalancerUpgradeable.sol#L1685-L1709) is never used and should be removed

../../share/BalancerUpgradeable.sol#L1685-L1709


 - [ ] ID-180
[SafeCastUpgradeable.toInt192(int256)](../../share/BalancerUpgradeable.sol#L2796-L2799) is never used and should be removed

../../share/BalancerUpgradeable.sol#L2796-L2799


 - [ ] ID-181
[SafeCastUpgradeable.toInt56(int256)](../../share/BalancerUpgradeable.sol#L3102-L3105) is never used and should be removed

../../share/BalancerUpgradeable.sol#L3102-L3105


## solc-version
Impact: Informational
Confidence: High
 - [ ] ID-182
Pragma version[^0.8.19](../../share/BalancerUpgradeable.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.6.12/0.7.6/0.8.7

../../share/BalancerUpgradeable.sol#L2


 - [ ] ID-183
solc-0.8.19 is not recommended for deployment

## low-level-calls
Impact: Informational
Confidence: High
 - [ ] ID-184
Low level call in [Address.functionStaticCall(address,bytes,string)](../../share/BalancerUpgradeable.sol#L4225-L4232):
	- [(success,returndata) = target.staticcall(data)](../../share/BalancerUpgradeable.sol#L4230)

../../share/BalancerUpgradeable.sol#L4225-L4232


 - [ ] ID-185
Low level call in [AddressUpgradeable.functionStaticCall(address,bytes,string)](../../share/BalancerUpgradeable.sol#L265-L272):
	- [(success,returndata) = target.staticcall(data)](../../share/BalancerUpgradeable.sol#L270)

../../share/BalancerUpgradeable.sol#L265-L272


 - [ ] ID-186
Low level call in [Address.functionDelegateCall(address,bytes,string)](../../share/BalancerUpgradeable.sol#L4250-L4257):
	- [(success,returndata) = target.delegatecall(data)](../../share/BalancerUpgradeable.sol#L4255)

../../share/BalancerUpgradeable.sol#L4250-L4257


 - [ ] ID-187
Low level call in [Address.functionCallWithValue(address,bytes,uint256,string)](../../share/BalancerUpgradeable.sol#L4198-L4207):
	- [(success,returndata) = target.call{value: value}(data)](../../share/BalancerUpgradeable.sol#L4205)

../../share/BalancerUpgradeable.sol#L4198-L4207


 - [ ] ID-188
Low level call in [AddressUpgradeable.functionCallWithValue(address,bytes,uint256,string)](../../share/BalancerUpgradeable.sol#L238-L247):
	- [(success,returndata) = target.call{value: value}(data)](../../share/BalancerUpgradeable.sol#L245)

../../share/BalancerUpgradeable.sol#L238-L247


 - [ ] ID-189
Low level call in [AddressUpgradeable.sendValue(address,uint256)](../../share/BalancerUpgradeable.sol#L170-L175):
	- [(success) = recipient.call{value: amount}()](../../share/BalancerUpgradeable.sol#L173)

../../share/BalancerUpgradeable.sol#L170-L175


 - [ ] ID-190
Low level call in [ERC1967UpgradeUpgradeable._functionDelegateCall(address,bytes)](../../share/BalancerUpgradeable.sol#L3707-L3713):
	- [(success,returndata) = target.delegatecall(data)](../../share/BalancerUpgradeable.sol#L3711)

../../share/BalancerUpgradeable.sol#L3707-L3713


 - [ ] ID-191
Low level call in [Address.sendValue(address,uint256)](../../share/BalancerUpgradeable.sol#L4130-L4135):
	- [(success) = recipient.call{value: amount}()](../../share/BalancerUpgradeable.sol#L4133)

../../share/BalancerUpgradeable.sol#L4130-L4135


## naming-convention
Impact: Informational
Confidence: High
 - [ ] ID-192
Variable [BalancerUpgradeable.$lastTakeProfitTime](../../share/BalancerUpgradeable.sol#L4369) is not in mixedCase

../../share/BalancerUpgradeable.sol#L4369


 - [ ] ID-193
Variable [BalancerUpgradeable.$valueDecayTarget](../../share/BalancerUpgradeable.sol#L4365) is not in mixedCase

../../share/BalancerUpgradeable.sol#L4365


 - [ ] ID-194
Function [IERC20PermitUpgradeable.DOMAIN_SEPARATOR()](../../share/BalancerUpgradeable.sol#L3288) is not in mixedCase

../../share/BalancerUpgradeable.sol#L3288


 - [ ] ID-195
Function [AccessControlUpgradeable.__AccessControl_init_unchained()](../../share/BalancerUpgradeable.sol#L1889-L1890) is not in mixedCase

../../share/BalancerUpgradeable.sol#L1889-L1890


 - [ ] ID-196
Function [ERC1967UpgradeUpgradeable.__ERC1967Upgrade_init_unchained()](../../share/BalancerUpgradeable.sol#L3533-L3534) is not in mixedCase

../../share/BalancerUpgradeable.sol#L3533-L3534


 - [ ] ID-197
Variable [BalancerUpgradeable.$isActiveAdapter](../../share/BalancerUpgradeable.sol#L4356) is not in mixedCase

../../share/BalancerUpgradeable.sol#L4356


 - [ ] ID-198
Variable [ContextUpgradeable.__gap](../../share/BalancerUpgradeable.sol#L519) is not in mixedCase

../../share/BalancerUpgradeable.sol#L519


 - [ ] ID-199
Variable [BalancerUpgradeable.$lastValueLock](../../share/BalancerUpgradeable.sol#L4364) is not in mixedCase

../../share/BalancerUpgradeable.sol#L4364


 - [ ] ID-200
Function [ReentrancyGuardUpgradeable.__ReentrancyGuard_init_unchained()](../../share/BalancerUpgradeable.sol#L3862-L3864) is not in mixedCase

../../share/BalancerUpgradeable.sol#L3862-L3864


 - [ ] ID-201
Variable [AccessControlUpgradeable.__gap](../../share/BalancerUpgradeable.sol#L2094) is not in mixedCase

../../share/BalancerUpgradeable.sol#L2094


 - [ ] ID-202
Variable [BalancerUpgradeable.SWAP_EXECUTOR](../../share/BalancerUpgradeable.sol#L4352) is not in mixedCase

../../share/BalancerUpgradeable.sol#L4352


 - [ ] ID-203
Variable [UUPSUpgradeable.__gap](../../share/BalancerUpgradeable.sol#L3820) is not in mixedCase

../../share/BalancerUpgradeable.sol#L3820


 - [ ] ID-204
Function [ERC20Upgradeable.__ERC20_init_unchained(string,string)](../../share/BalancerUpgradeable.sol#L570-L573) is not in mixedCase

../../share/BalancerUpgradeable.sol#L570-L573


 - [ ] ID-205
Variable [ERC1967UpgradeUpgradeable.__gap](../../share/BalancerUpgradeable.sol#L3720) is not in mixedCase

../../share/BalancerUpgradeable.sol#L3720


 - [ ] ID-206
Function [ERC20Upgradeable.__ERC20_init(string,string)](../../share/BalancerUpgradeable.sol#L566-L568) is not in mixedCase

../../share/BalancerUpgradeable.sol#L566-L568


 - [ ] ID-207
Function [ReentrancyGuardUpgradeable.__ReentrancyGuard_init()](../../share/BalancerUpgradeable.sol#L3858-L3860) is not in mixedCase

../../share/BalancerUpgradeable.sol#L3858-L3860


 - [ ] ID-208
Variable [BalancerUpgradeable.$feeReceiver](../../share/BalancerUpgradeable.sol#L4370) is not in mixedCase

../../share/BalancerUpgradeable.sol#L4370


 - [ ] ID-209
Function [ERC165Upgradeable.__ERC165_init_unchained()](../../share/BalancerUpgradeable.sol#L1830-L1831) is not in mixedCase

../../share/BalancerUpgradeable.sol#L1830-L1831


 - [ ] ID-210
Function [ContextUpgradeable.__Context_init_unchained()](../../share/BalancerUpgradeable.sol#L504-L505) is not in mixedCase

../../share/BalancerUpgradeable.sol#L504-L505


 - [ ] ID-211
Variable [BalancerUpgradeable.$chargedAdapters](../../share/BalancerUpgradeable.sol#L4355) is not in mixedCase

../../share/BalancerUpgradeable.sol#L4355


 - [ ] ID-212
Variable [BalancerUpgradeable.DEPOSIT_FEE](../../share/BalancerUpgradeable.sol#L4353) is not in mixedCase

../../share/BalancerUpgradeable.sol#L4353


 - [ ] ID-213
Function [UUPSUpgradeable.__UUPSUpgradeable_init_unchained()](../../share/BalancerUpgradeable.sol#L3739-L3740) is not in mixedCase

../../share/BalancerUpgradeable.sol#L3739-L3740


 - [ ] ID-214
Variable [ERC20Upgradeable.__gap](../../share/BalancerUpgradeable.sol#L911) is not in mixedCase

../../share/BalancerUpgradeable.sol#L911


 - [ ] ID-215
Variable [BalancerUpgradeable.$adapters](../../share/BalancerUpgradeable.sol#L4354) is not in mixedCase

../../share/BalancerUpgradeable.sol#L4354


 - [ ] ID-216
Variable [ReentrancyGuardUpgradeable.__gap](../../share/BalancerUpgradeable.sol#L3898) is not in mixedCase

../../share/BalancerUpgradeable.sol#L3898


 - [ ] ID-217
Variable [BalancerUpgradeable.$valueReleaseTarget](../../share/BalancerUpgradeable.sol#L4366) is not in mixedCase

../../share/BalancerUpgradeable.sol#L4366


 - [ ] ID-218
Variable [BalancerUpgradeable.$lastRebalanceTime](../../share/BalancerUpgradeable.sol#L4368) is not in mixedCase

../../share/BalancerUpgradeable.sol#L4368


 - [ ] ID-219
Function [AccessControlUpgradeable.__AccessControl_init()](../../share/BalancerUpgradeable.sol#L1886-L1887) is not in mixedCase

../../share/BalancerUpgradeable.sol#L1886-L1887


 - [ ] ID-220
Variable [ERC165Upgradeable.__gap](../../share/BalancerUpgradeable.sol#L1844) is not in mixedCase

../../share/BalancerUpgradeable.sol#L1844


 - [ ] ID-221
Variable [UUPSUpgradeable.__self](../../share/BalancerUpgradeable.sol#L3742) is not in mixedCase

../../share/BalancerUpgradeable.sol#L3742


 - [ ] ID-222
Function [ERC1967UpgradeUpgradeable.__ERC1967Upgrade_init()](../../share/BalancerUpgradeable.sol#L3530-L3531) is not in mixedCase

../../share/BalancerUpgradeable.sol#L3530-L3531


 - [ ] ID-223
Function [UUPSUpgradeable.__UUPSUpgradeable_init()](../../share/BalancerUpgradeable.sol#L3736-L3737) is not in mixedCase

../../share/BalancerUpgradeable.sol#L3736-L3737


 - [ ] ID-224
Function [ContextUpgradeable.__Context_init()](../../share/BalancerUpgradeable.sol#L501-L502) is not in mixedCase

../../share/BalancerUpgradeable.sol#L501-L502


 - [ ] ID-225
Function [ERC165Upgradeable.__ERC165_init()](../../share/BalancerUpgradeable.sol#L1827-L1828) is not in mixedCase

../../share/BalancerUpgradeable.sol#L1827-L1828


## similar-names
Impact: Informational
Confidence: Medium
 - [ ] ID-226
Variable [BalancerUpgradeable.$feeReceiver](../../share/BalancerUpgradeable.sol#L4370) is too similar to [BalancerUpgradeable.setFeeReceiver(address).feeReceiver_](../../share/BalancerUpgradeable.sol#L4571)

../../share/BalancerUpgradeable.sol#L4370


 - [ ] ID-227
Variable [BalancerUpgradeable.DEPOSIT_FEE](../../share/BalancerUpgradeable.sol#L4353) is too similar to [BalancerUpgradeable.constructor(address,uint256)._depositFee](../../share/BalancerUpgradeable.sol#L4372)

../../share/BalancerUpgradeable.sol#L4353


 - [ ] ID-228
Variable [BalancerUpgradeable.$feeReceiver](../../share/BalancerUpgradeable.sol#L4370) is too similar to [BalancerUpgradeable.initialize(string,string,address).feeReceiver_](../../share/BalancerUpgradeable.sol#L4380)

../../share/BalancerUpgradeable.sol#L4370


 - [ ] ID-229
Variable [BalancerUpgradeable.SWAP_EXECUTOR](../../share/BalancerUpgradeable.sol#L4352) is too similar to [BalancerUpgradeable.constructor(address,uint256)._swapExecutor](../../share/BalancerUpgradeable.sol#L4372)

../../share/BalancerUpgradeable.sol#L4352


 - [ ] ID-230
Variable [BalancerUpgradeable.$feeReceiver](../../share/BalancerUpgradeable.sol#L4370) is too similar to [IBalancer.setFeeReceiver(address).feeReceiver_](../../share/BalancerUpgradeable.sol#L3969)

../../share/BalancerUpgradeable.sol#L4370


## unused-state
Impact: Informational
Confidence: High
 - [ ] ID-231
[ReentrancyGuardUpgradeable.__gap](../../share/BalancerUpgradeable.sol#L3898) is never used in [BalancerUpgradeable](../../share/BalancerUpgradeable.sol#L4328-L4732)

../../share/BalancerUpgradeable.sol#L3898


## external-function
Impact: Optimization
Confidence: High
 - [ ] ID-232
transferFrom(address,address,uint256) should be declared external:
	- [ERC20Upgradeable.transferFrom(address,address,uint256)](../../share/BalancerUpgradeable.sol#L674-L683)

../../share/BalancerUpgradeable.sol#L674-L683


 - [ ] ID-233
name() should be declared external:
	- [ERC20Upgradeable.name()](../../share/BalancerUpgradeable.sol#L578-L580)

../../share/BalancerUpgradeable.sol#L578-L580


 - [ ] ID-234
initialize(string,string,address) should be declared external:
	- [BalancerUpgradeable.initialize(string,string,address)](../../share/BalancerUpgradeable.sol#L4380-L4388)

../../share/BalancerUpgradeable.sol#L4380-L4388


 - [ ] ID-235
symbol() should be declared external:
	- [ERC20Upgradeable.symbol()](../../share/BalancerUpgradeable.sol#L586-L588)

../../share/BalancerUpgradeable.sol#L586-L588


 - [ ] ID-236
increaseAllowance(address,uint256) should be declared external:
	- [ERC20Upgradeable.increaseAllowance(address,uint256)](../../share/BalancerUpgradeable.sol#L697-L701)

../../share/BalancerUpgradeable.sol#L697-L701


 - [ ] ID-237
executeSwaps(IBalancer.SwapInfo[]) should be declared external:
	- [SwapExecutor.executeSwaps(IBalancer.SwapInfo[])](../../share/BalancerUpgradeable.sol#L4318-L4324)

../../share/BalancerUpgradeable.sol#L4318-L4324


 - [ ] ID-238
approve(address,uint256) should be declared external:
	- [ERC20Upgradeable.approve(address,uint256)](../../share/BalancerUpgradeable.sol#L652-L656)

../../share/BalancerUpgradeable.sol#L652-L656


 - [ ] ID-239
decreaseAllowance(address,uint256) should be declared external:
	- [ERC20Upgradeable.decreaseAllowance(address,uint256)](../../share/BalancerUpgradeable.sol#L717-L726)

../../share/BalancerUpgradeable.sol#L717-L726


 - [ ] ID-240
revokeRole(bytes32,address) should be declared external:
	- [AccessControlUpgradeable.revokeRole(bytes32,address)](../../share/BalancerUpgradeable.sol#L2000-L2002)

../../share/BalancerUpgradeable.sol#L2000-L2002


 - [ ] ID-241
renounceRole(bytes32,address) should be declared external:
	- [AccessControlUpgradeable.renounceRole(bytes32,address)](../../share/BalancerUpgradeable.sol#L2020-L2024)

../../share/BalancerUpgradeable.sol#L2020-L2024


 - [ ] ID-242
decimals() should be declared external:
	- [ERC20Upgradeable.decimals()](../../share/BalancerUpgradeable.sol#L603-L605)

../../share/BalancerUpgradeable.sol#L603-L605


 - [ ] ID-243
grantRole(bytes32,address) should be declared external:
	- [AccessControlUpgradeable.grantRole(bytes32,address)](../../share/BalancerUpgradeable.sol#L1985-L1987)

../../share/BalancerUpgradeable.sol#L1985-L1987


 - [ ] ID-244
transfer(address,uint256) should be declared external:
	- [ERC20Upgradeable.transfer(address,uint256)](../../share/BalancerUpgradeable.sol#L629-L633)

../../share/BalancerUpgradeable.sol#L629-L633


