pragma solidity ^0.8.19;

interface ILPStaking {
    function getMultiplier(
        uint256 _from,
        uint256 _to
    ) external view returns (uint256);

    function deposit(uint256 _pid, uint256 _amount) external;

    function withdraw(uint256 _pid, uint256 _amount) external;

    function userInfo(uint256 _pid, address _user) external view returns (uint256 amount, uint256 rewardDebt);

    function poolInfo(uint256 _pid) external view returns (address lpToken, uint256 allocPoint, uint256 lastRewardBlock, uint256 accStargatePerShare);

    function stargate() external view returns (address);

    function pendingStargate(uint256 _pid, address _user) external view returns (uint256);
}
