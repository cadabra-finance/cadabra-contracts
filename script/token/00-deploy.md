### 1. Abra

1. Deploy Abra:
```bash
npx hardhat run script/token/01-deploy-abra.ts --network bsc
```
2. Verify Abra:
``` bash
npx hardhat verify --network bsc <abraAddress>
```

```bash
forge v -c 56 --watch --compiler-version 0.8.20 <abraImplementationAddress> src/token/Abra.sol:Abra 
```

### 2. AbraStaking, RewardsSource
1. Deploy AbraStaking and RewardsSource
```bash
npx hardhat run script/token/03-deploy-abraStaking-and-rewardsSource.ts --network bsc
```

2. Verify AbraStaking

```bash
npx hardhat verify --network bsc <abraStakingAddress> <abraAdress> <epoch> <minStakeDuration> <maxStakeDuration> <rewardsSourceAddress>
```

```bash
forge v -c 56 --watch --compiler-version 0.8.20 <abraStakingImplementationAddress> src/token/AbraStaking.sol:AbraStaking \
--constructor-args \
$(cast abi-encode "constructor(address,uint256,uint256,uint256,address)" \
<abraAddress> <epoch> <misStakeDuration> <maxStakeDuration> <rewardsSourceAddress>)
```

3. Verify RewardsSource

```bash
npx hardhat verify --network bsc <rewardsSourceAddress> 
```

```bash
forge v -c 56 --watch --compiler-version 0.8.20 <rewardsSourceAddress> src/token/RewardsSource.sol:RewardsSource \
--constructor-args \
$(cast abi-encode "constructor(address)" <abraStakingAddress>)
```

### 4. AbraVesting
1. Deploy AbraVesting

Set vesting params into script:
- AbraStakingAddress;
- totalAmount;
- coldownDuraion;
- lockperiodDuration;
- lockperiodCount;

```bash
npx hardhat run script/token/04-deploy-abraVesting.ts --network bsc
```

2. Verify AbraVesting
```bash
npx hardhat verify --network bsc <abraVestingAddress>
```
```bash
sudo forge v -c 56 <abraVestingImplementationAddress> src/token/AbraVesting.sol:AbraVesting --compiler-version 0.8.20 --watch
```
