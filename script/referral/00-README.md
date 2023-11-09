## Deploy referral program contracts
1. Deploy ReferralStakingMain on primary networks. Sure that AbraStaking is deployed yet on primary network and set its address in env. See https://layerzero.gitbook.io/docs/technical-reference/mainnet/supported-chain-ids to set LZ_CHAIN_ID and LZ_ENDPOINT for primary network.
    ```bash
    ABRA_STAKING=<abraStakingAddress> LZ_CHAIN_ID=<primaryLzChainId> LZ_ENDPOINT=<primaryLzEndpoint> npx hardhat run --network bsc script/referral/01-deploy-referral-staking-main.ts
    ```
   For BSC network it looks like below:
   ```bash
    ABRA_STAKING=<abraStakingAddress> LZ_CHAIN_ID=102 LZ_ENDPOINT=0x3c2269811836af69497E5F486A85D7316753cf62 npx hardhat run --network bsc script/referral/01-deploy-referral-staking-main.ts
    ```

2. Deploy ReferralStakingSecondary on secondary networks. Sure that AbraStaking is deployed yet on secondary network and set its address in env. Set MAIN_LZ_CHAIN_ID to lz chain id of primary network where ReferralStakingMain is deployed on the previous step. See https://layerzero.gitbook.io/docs/technical-reference/mainnet/supported-chain-ids to set LZ_ENDPOINT for secondary network.
    ```bash
    ABRA_STAKING=<abraStakingSecondaryAddress> MAIN_LZ_CHAIN_ID=<primaryLzChainId> LZ_ENDPOINT=<secondaryLzEndpoint> npx hardhat run --network optimism script/referral/01-deploy-referral-staking-secondary.ts
    ```
   For OPTIMISM (secondary) and BSC (primary) networks it looks like below:
   ```bash
    ABRA_STAKING=<abraStakingSecondaryAddress> MAIN_LZ_CHAIN_ID=102 LZ_ENDPOINT=0x3c2269811836af69497E5F486A85D7316753cf62 npx hardhat run --network optimism script/referral/01-deploy-referral-staking-secondary.ts
    ```

## Verify referral program contracts
1. Verify ReferralStakingMain on primary networks. Sure constructor arguments is the same as deployed contract has.
   ```bash
   npx hardhat verify --network bsc <referralStakingMainAddress> <abraStakingAddress> <primaryLzChainId>
   ```

    npx hardhat verify --network bsc 0x98047992Da9bbE5477FD58946DEda7f214A33bea 0x34249Ee58B109495c4fc0187c6996AEA07cF700b 102

   ```bash
    forge v -c 56 --watch --compiler-version 0.8.20 <referralStakingMainImplementationAddress> src/referral/ReferralStakingMain.sol:ReferralStakingMain \
    --constructor-args \
    $(cast abi-encode "constructor(address,uint16)" <abraStakingAddress> <lzChainId>)
    ```

2. Verify ReferralStakingSecondary on secondary networks. Sure constructor arguments is the same as deployed contract has.
   ```bash
   npx hardhat verify --network bsc <referralStakingSecondaryAddress> <abraStakingSecondaryAddress> <primaryLzChainId>
   ```

    ```bash
    forge v -c 56 --watch --compiler-version 0.8.20 <referralStakingSecondaryImplementationAddress> src/referral/ReferralStakingSecondary.sol:ReferralStakingSecondary \
    --constructor-args \
    $(cast abi-encode "constructor(address,uint16)" <abraStakingSecondaryAddress> <primaryLzChainId>)
    ```