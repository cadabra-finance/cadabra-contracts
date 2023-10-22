# GOALS
The goal of the project is to create multi-asset vaults that allocate their fund into multiple (1..N) underlying
protocols to receive yield. We call these vaults strategies.


# ARCHITECTURE OVERVIEW
Strategy contract (`Balancer`) works similar to ERC4626, but instead of using `totalAssets` to calculate how much
shares a user receives, we use a notion of underlying `value` i.e. we calculate the total `value` of all 
underlying protocols of the strategy via oracles. This value is calculated using an equivalent which is specific to each
strategy. For example for stablecoin strategies we calculate `value` in USD (via Chainlink), for ETH or BNB strategies we
calculate `value` based on ETH or BNB.

Each strategy has one or more `Adapter`'s. They incapsulate details of the protols (i.e. depositing, withdrawing, 
selling rewards). All strategy's funds are distributed between different adapters, that means that adapters have token 
balances while `Balancer` has 0 token balance. 

## ENTERING STRATEGY
Currently when entering a strategy, the user must specify which `Adapter` they want to deposit their assets to. 
Our fronted will ensure that users deposit to the most profitable adapter, but we don't currently impose these restrictions
on the contract level.

## LEAVING STRATEGY
When leaving the strategy the user also specifies which `Adapter` will be use to withdraw assets from. Our frontend will
specify the least profitable adapter, but as with invest above we don't expose any limitations on the contract level.

## ORGANIC REBALANCE
With the organic flow described above we hope that the strategy will always gravitate towards the most profitable protocol
given it has constant flow of funds entering/leaving the strategy.

## MANUAL REBALANCE
We also have manual reabalance. It's used when organic rebalance is not sufficient. 
It involves dissolving LP tokens of one protocol, swapping these tokens into a combination of new tokens, and then 
deposit of the new tokens to another protocols. We decided to support any arbitrary swap path via opaque callee and 
calldata and in order to prevent rug pull we introduced two measures to protect the users:
1. Value check after the rebalance: `rebalance` ensures that no more that a configured % of the total value was lost 
   during the rebalance.  
2. Rebalance cooldown period: ensures that we can execute rebalance no more than once every N hours. 


## ADDING ADAPTERS
Since adding a new adapter to the existing strategy involves risks of rug pulls, all additions must be performed via
timelock, so that users have a time to make a decision. `Balancer` doesn't implement timelocking mechanism by itself, we
have delegated timelocking to a separate contract (Openzeppelin's TimeLock).
After adding an adapter it's still inactive, meaning that assets cannot be rebalanced to it. To make the adapter active
we must call `activateAdapter` method.

## REMOVING ADAPTERS
Any adapter can be removed without a timelock if it:
1. Deactivated
2. Has 0 liquidity.


## TOKEN

`Balancer` swaps all earned rewards and buys ABRA token which is then distributed to the participats.
Tokens are bought back using Uniswap V3 pools.
