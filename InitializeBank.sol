pragma solidity ^0.6.12;


interface IERC20 {
    function _mint(address account, uint256 amount) external;
   // function increaseAllowance(address spender,unit addedValue) external view returns (bool);
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}


contract EthGangSwapBankTest17 {
    
    
    string public name = "DefiBank17";
    uint256 public oldBalance;
    
    // create 2 state variables
    address public usdc;
    address public bankToken;
    
    address public contractAddress;

    address[] public stakers;
    mapping(address => uint256) public startTime;
    mapping(address => uint) public stakingBalance;
    mapping(address => uint256) public rewardBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;


    
    constructor() public {
        usdc = 0xEe0196284a063d46A502b88E4Ed7E2AfEA26EF6E;
        bankToken = 0x91D95070d64Be39cc625136183c832Bb89a6B6be;

    }

    
    
    function approveStake(uint tokens) public {
        IERC20(usdc).approve(address(this),tokens);
      //  emit Approval(msg.sender,address(this),tokens);
    }
    
    
    
    //allow user to stake with 1 parameter @ammount
    function stakeTokens(uint _amount) public {
        
        uint fullAmmount = _amount;//*1000000000000000000;

        // Trasnfer usdc tokens to contract for staking
        IERC20(usdc).transferFrom(msg.sender, address(this), fullAmmount);

        // Update the staking balance in map
        stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount;

        // Add user to stakers array if they haven't staked already
        if(!hasStaked[msg.sender]) {
            stakers.push(msg.sender);
        }
        // Track how many rewards 
        if(isStaking[msg.sender] == true){
            uint256 toTransfer = calculateYieldTotal(msg.sender);
            rewardBalance[msg.sender] += toTransfer;
        }

        // Update staking status to track
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
        startTime[msg.sender] = block.timestamp;
    }


    function getBalance() public view returns (uint){
        uint balance = stakingBalance[msg.sender];
        return balance;
    }
    


    function unstakeTokens(uint amount) public{
        require(stakingBalance[msg.sender] >= amount);
        
        uint256 fullAmmount = amount;//*1000000000000000000;
        
        uint256 yieldTransfer = calculateYieldTotal(msg.sender);
        startTime[msg.sender] = block.timestamp;
        
        stakingBalance[msg.sender] -= amount;
        if(stakingBalance[msg.sender]<= 0){
            isStaking[msg.sender] = false;
        }
        IERC20(usdc).transfer(msg.sender, fullAmmount);
        //usdc.transfer(user,amount);
    }
    
 
    function calculateYieldTime(address user) public view returns(uint256){
        if(isStaking[user] == true){
            uint256 end = block.timestamp;
            uint256 totalTime = end - startTime[user];
            return totalTime;
         }
    }

    function calculateYieldTotal(address user) public view returns(uint256) {
        uint256 time = calculateYieldTime(user) * 10**18;
        uint256 rate = 86400;
        uint256 timeRate = time / rate;
        uint256 rawYield = (stakingBalance[user] * timeRate) / 10**18;
        return rawYield;
    }
    
    function yieldReadable(address user) public view returns(uint256){
        uint256 time = calculateYieldTotal(user)*10**18;
        return time;
    }
    
    function approveYield() public{
        
        
        IERC20(bankToken).approve(msg.sender,oldBalance);
    }
    
    function withdrawYield() public {
        uint256 toTransfer = calculateYieldTotal(msg.sender);
        toTransfer+= rewardBalance[msg.sender];
        require(
            toTransfer > 0 ,
            "Nothing to withdraw"
            );
            
            //oldBalance = rewardBalance[msg.sender];
              rewardBalance[msg.sender] = 0;
            //toTransfer += oldBalance;

        startTime[msg.sender] = block.timestamp;
        IERC20(bankToken).transfer(msg.sender, toTransfer);
        
    } 
    
}
