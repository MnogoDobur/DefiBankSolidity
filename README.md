# DefiBankSolidity
Implementation of DEFI bank in Solidity

Functions:

@approveStake (uint tokens) - Approves the tokens to be used by the smart contract. Emits Approve event.
@stakeTokens (uint amount) - Stake @amount of tokens to the smart contract. Emits Transfer event.
@getBalance - Gets balance of currently staked tokens for the caller of the function (msg.sender).
@unstakeTokens (uint amount) - Unstake @amount of tokens from the smart contract. Emits Transfer event.
@calculateYieldTime (address user) - Calculates current yield time
@calculateYieldTotal (address user) - Calculates current yield receivable based on the calculateYieldTime() function return. 
@yieldReadable (address user) - Shows the yield in a readable format.
@approveYield - Approves the yield to be withdrawn
@withdrawYield - Withdraws yield from the smart contract. The smart contract must have the token which is used as a collateral inside its balance.
