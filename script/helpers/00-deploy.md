### 1. SwapExecutor

uniswapRouter address need to take from https://docs.uniswap.org/contracts/v3/reference/deployments

For BSC set UNISWAP_ROUTER=0xB971eF87ede563556b2ED4b1C0b0019111Dd85d2
poolFee=3000 (0.3%)

```bash
UNISWAP_POOL_FEE=<poolFee> UNISWAP_ROUTER=<uniswapRouter> forge script script/helpers/01-deploy-swap-executor.s.sol:DeploySwapExecutorScript --broadcast --verify --rpc-url https://bsc-dataseed4.ninicoin.io/
```

    
### 2. Router

For BSC set WETH=0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c

```bash
SWAP_EXECUTOR=<swapExecutorAddress> WETH=<wethAddress> forge script script/helpers/02-deploy-router.s.sol:DeployRouterScript --broadcast --verify --rpc-url https://bsc-dataseed4.ninicoin.io/
```


### 3. AccessManager

```bash
forge script script/helpers/03-deploy-access-manager.s.sol:DeployAccessManagerScript --broadcast --verify --rpc-url https://bsc-dataseed4.ninicoin.io/
```


### 4. LiquidityMaster

1. Deploy

nonfungiblePositionManager need to take from https://docs.uniswap.org/contracts/v3/reference/deployments

For BSC set POSITION_MANAGER=0x7b8A01B39D58278b5DE7e48c8449c9f4F5170613

```bash
ABRA=<abraTokenAddress> POSITION_MANAGER=<nonfungiblePositionManager> npx hardhat run script/helpers/04-deploy-liquidity-master.ts --network bsc
```


2. Verify

```bash
npx hardhat verify <liquidityMasterAddress> <positionManagerAddress> <abraAddress> --network bsc
```

```bash
forge v -c 56 --watch --compiler-version 0.8.20 <liquidityMasterImplementationAddress> src/helpers/LiquidityMaster.sol:LiquidityMaster \
--constructor-args \
$(cast abi-encode "constructor(address,address)" <positionManagerAddress> <abraAddress>)
```
