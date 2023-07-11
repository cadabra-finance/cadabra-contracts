// SPDX-License-Identifier: Unlicensed
pragma solidity >=0.8.0 <0.9.0;

interface Wmx {
    function getFactAmounMint(uint256 _amount) external view returns (uint256);
}

interface Booster {
    function poolLength() external view returns (uint256);

    function poolInfo(uint256) external view returns (PoolInfo memory);

    function voterProxy() external view returns (address);

    function earmarkDelegate() external view returns (address);

    function cvx() external view returns (address);

    function customMintRatio(uint256 pid) external view returns (uint256);

    function mintRatio() external view returns (uint256);

    function penaltyShare() external view returns (uint256);
}

interface VoterProxy {
    function lpTokenToPid(
        address gauge,
        address lpToken
    ) external view returns (uint256);
}

interface MasterWombatV3 {
    function poolInfoV3(uint256 pid) external view returns (PoolInfoV3 memory);

    function userInfo(
        uint256 pid,
        address
    ) external view returns (UserInfo memory);

    function basePartition() external view returns (uint256);

    function wom() external view returns (address);

    function getAssetPid(address asset) external view returns (uint256 pid);
}

interface BoosterEarmark {
    function earmarkIncentive() external view returns (uint256);

    function customDistributionByTokenLength(
        uint256 pid,
        address token
    ) external view returns (uint256);

    function customDistributionByTokens(
        uint256 pid,
        address token,
        uint256 index
    ) external view returns (TokenDistro memory);

    function distributionByTokenLength(
        address token
    ) external view returns (uint256);

    function distributionByTokens(
        address token,
        uint256 index
    ) external view returns (TokenDistro memory);
}

interface IERC20 {
    function balanceOf(address) external view returns (uint256);

    function totalSupply() external view returns (uint256);
}

interface Asset is IERC20 {
    function underlyingToken() external view returns (address);

    function liability() external view returns (uint256);

    function cash() external view returns (uint256);
}

interface BaseRewardPool4626 {
    function operator() external view returns (address);

    function pid() external view returns (uint256);

    function balanceOf(address) external view returns (uint256);

    function totalSupply() external view returns (uint256);
}

struct PoolInfo {
    address lptoken;
    address token;
    address gauge;
    address crvRewards;
    bool shutdown;
}
struct UserInfo {
    uint128 amount; // 20.18 fixed point. How many LP tokens the user has provided.
    uint128 factor; // 20.18 fixed point. boosted factor = sqrt (lpAmount * veWom.balanceOf())
    uint128 rewardDebt; // 20.18 fixed point. Reward debt. See explanation below.
    uint128 pendingWom; // 20.18 fixed point. Amount of pending wom
}

struct PoolInfoV3 {
    address lpToken; // Address of LP token contract.
    address rewarder;
    uint40 periodFinish;
    uint128 sumOfFactors; // 20.18 fixed point. the sum of all boosted factors by all of the users in the pool
    uint128 rewardRate; // 20.18 fixed point.
    uint104 accWomPerShare; // 19.12 fixed point. Accumulated WOM per share, times 1e12.
    uint104 accWomPerFactorShare; // 19.12 fixed point. Accumulated WOM per factor share
    uint40 lastRewardTimestamp;
}
struct TokenDistro {
    address distro;
    uint256 share;
    bool callQueue;
}

contract WombexHelper {
    uint256 private constant ACC_TOKEN_PRECISION = 1e12;
    uint256 private constant DENOMINATOR = 10000;

    Booster constant BOOSTER =
        Booster(0x561050FFB188420D2605714F84EdA714DA58da69);
    MasterWombatV3 constant MASTER_WOMBAT =
        MasterWombatV3(0x489833311676B566f888119c29bd997Dc6C95830);

    function wombatShareInfo(
        address assetAddress,
        address staker
    ) external view returns (uint256 totalStaked, uint256 amount) {
        Asset asset = Asset(assetAddress);
        totalStaked = asset.balanceOf(address(MASTER_WOMBAT));
        
        uint256 pid = MASTER_WOMBAT.getAssetPid(assetAddress);
        UserInfo memory userInfo = MASTER_WOMBAT.userInfo(pid, staker);
        amount = userInfo.amount;
    }

    function wombexShareInfo(
        address baseRewardPoolAddress,
        address staker
    ) external view returns (uint256 totalStaked, uint256 amount) {
        totalStaked = BaseRewardPool4626(baseRewardPoolAddress).totalSupply();
        amount = BaseRewardPool4626(baseRewardPoolAddress).balanceOf(staker);
    }

    function wombatRewardInfo(
        address assetAddress
    )
        external
        view
        returns (
            address[] memory stakedTokens,
            uint256[] memory stakedAmounts,
            address[] memory rewardTokens,
            uint256[] memory rewardAmounts
        )
    {
        stakedTokens = new address[](1);
        stakedAmounts = new uint256[](1);
        rewardTokens = new address[](1);
        rewardAmounts = new uint256[](1);

        Asset asset = Asset(assetAddress);
        IERC20 underlying = IERC20(asset.underlyingToken());
        stakedTokens[0] = address(underlying);
        stakedAmounts[0] =
            (asset.cash() * asset.balanceOf(address(MASTER_WOMBAT))) /
            asset.totalSupply();

        rewardTokens[0] = address(MASTER_WOMBAT.wom());
        uint256 pid = MASTER_WOMBAT.getAssetPid(assetAddress);
        PoolInfoV3 memory poolInfoV3 = MASTER_WOMBAT.poolInfoV3(pid);
        if (poolInfoV3.periodFinish > block.timestamp) {
            uint256 basePartition = MASTER_WOMBAT.basePartition();
            uint256 rewardRate = poolInfoV3.rewardRate;
            rewardAmounts[0] = rewardRate * basePartition / 1000;
        }
    }

    function wombexRewardInfo(
        address baseRewardPoolAddress
    )
        external
        view
        returns (
            address[] memory stakedTokens,
            uint256[] memory stakedAmounts,
            address[] memory rewardTokens,
            uint256[] memory rewardAmounts
        )
    {
        stakedTokens = new address[](1);
        stakedAmounts = new uint256[](1);
        rewardTokens = new address[](2);
        rewardAmounts = new uint256[](2);

        uint256 wombexPid = BaseRewardPool4626(baseRewardPoolAddress).pid();
        PoolInfo memory info = BOOSTER.poolInfo(wombexPid);
        address voterProxy = BOOSTER.voterProxy();
        uint256 wombatPid = VoterProxy(voterProxy).lpTokenToPid(
            info.gauge,
            info.lptoken
        );
        MasterWombatV3 masterWombat = MasterWombatV3(info.gauge);
        PoolInfoV3 memory poolInfoV3 = masterWombat.poolInfoV3(wombatPid);
        (
            uint256 womPerShareRate,
            uint256 womPerFactorShareRate
        ) = calRewardRatePerUnit(masterWombat, poolInfoV3);
        UserInfo memory userInfo = masterWombat.userInfo(wombatPid, voterProxy);
        rewardTokens = new address[](2);
        rewardTokens[0] = masterWombat.wom();
        rewardAmounts = new uint256[](2);
        rewardAmounts[0] =
            (womPerShareRate *
                userInfo.amount +
                womPerFactorShareRate *
                userInfo.factor) /
            ACC_TOKEN_PRECISION;

        uint256 rewardShare = earmarkRewardShare(
            BoosterEarmark(BOOSTER.earmarkDelegate()),
            wombexPid,
            rewardTokens[0]
        );
        rewardAmounts[0] = (rewardAmounts[0] * rewardShare) / DENOMINATOR;
        rewardTokens[1] = BOOSTER.cvx();
        rewardAmounts[1] = wmxAmount(wombexPid, rewardAmounts[0]);
        address underlyingToken = Asset(poolInfoV3.lpToken).underlyingToken();
        stakedTokens = new address[](1);
        stakedTokens[0] = underlyingToken;
        stakedAmounts = new uint256[](1);
        stakedAmounts[0] = Asset(info.lptoken).liability();
        // stakedAmounts[0] = Asset(info.lptoken).cash();
        stakedAmounts[0] =
            (stakedAmounts[0] * userInfo.amount) /
            IERC20(info.lptoken).totalSupply();
    }

    function calRewardRatePerUnit(
        MasterWombatV3 masterWombat,
        PoolInfoV3 memory pool
    )
        private
        view
        returns (uint256 womPerShareRate, uint256 womPerFactorShareRate)
    {
        if (pool.periodFinish < block.timestamp) return (0, 0);
        uint256 lpSupply = IERC20(pool.lpToken).balanceOf(
            address(masterWombat)
        );
        uint256 basePartition = masterWombat.basePartition();
        womPerShareRate =
            (pool.rewardRate * ACC_TOKEN_PRECISION * basePartition) /
            (lpSupply * 1000);

        if (pool.sumOfFactors != 0) {
            womPerFactorShareRate =
                (pool.rewardRate *
                    ACC_TOKEN_PRECISION *
                    (1000 - basePartition)) /
                (pool.sumOfFactors * 1000);
        }
    }

    function earmarkRewardShare(
        BoosterEarmark boosterEarmark,
        uint256 pid,
        address token
    ) private view returns (uint256 share) {
        share = DENOMINATOR;
        share -= boosterEarmark.earmarkIncentive();
        uint256 distributionLength = boosterEarmark
            .customDistributionByTokenLength(pid, token);
        if (distributionLength > 0) {
            for (uint256 i = 0; i < distributionLength; i++) {
                share -= boosterEarmark
                    .customDistributionByTokens(pid, token, i)
                    .share;
            }
        } else {
            distributionLength = boosterEarmark.distributionByTokenLength(
                token
            );
            for (uint256 i = 0; i < distributionLength; i++) {
                share -= boosterEarmark.distributionByTokens(token, i).share;
            }
        }
    }

    function wmxAmount(
        uint256 pid,
        uint256 womAmount
    ) private view returns (uint256 amount) {
        womAmount = womAmount * 300; // precision = 300 seconds

        uint256 mintRatio = BOOSTER.customMintRatio(pid);
        if (mintRatio == 0) mintRatio = BOOSTER.mintRatio();
        womAmount = (womAmount * mintRatio) / DENOMINATOR;

        uint256 penaltyShare = BOOSTER.penaltyShare();
        womAmount = (womAmount * (DENOMINATOR - penaltyShare)) / DENOMINATOR;

        amount = Wmx(BOOSTER.cvx()).getFactAmounMint(womAmount) / 300; // take precision back
    }
}
