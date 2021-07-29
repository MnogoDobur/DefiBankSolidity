pragma solidity ^0.6.12;


interface IPancakeFactory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);

    function allPairs(uint) external view returns (address pair);

    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;

    function setFeeToSetter(address) external;
}

interface IPancakePair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);

    function symbol() external pure returns (string memory);

    function decimals() external pure returns (uint8);

    function totalSupply() external view returns (uint);

    function balanceOf(address owner) external view returns (uint);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);

    function transfer(address to, uint value) external returns (bool);

    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);

    function PERMIT_TYPEHASH() external pure returns (bytes32);

    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(address indexed sender, uint amount0In, uint amount1In, uint amount0Out, uint amount1Out, address indexed to);
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);

    function factory() external view returns (address);

    function token0() external view returns (address);

    function token1() external view returns (address);

    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);

    function price0CumulativeLast() external view returns (uint);

    function price1CumulativeLast() external view returns (uint);

    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);

    function burn(address to) external returns (uint amount0, uint amount1);

    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;

    function skim(address to) external;

    function sync() external;

    function initialize(address, address) external;
}

interface IPancakeRouter01 {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);

    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);

    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);

    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);

    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);

    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
    external
    payable
    returns (uint[] memory amounts);

    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
    external
    returns (uint[] memory amounts);

    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
    external
    returns (uint[] memory amounts);

    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
    external
    payable
    returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);

    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);

    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);

    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);

    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

interface IPancakeRouter02 is IPancakeRouter01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);

    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}



    


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


 contract EthGangSwapBankTest19 {
    
    // call it DefiBank
    string public name = "DefiBank19";
    uint256 public oldBalance;
    
    // create 2 state variables
    address public usdc;
    address public bankToken;
    
    address public contractAddress;
    address public pancakeRouterAddress = payable(address(0xD99D1c33F9fC3444f8101754aBC46c52416550D1));
    address public factoryAddress = payable(address(0x6725F303b657a9451d8BA641348b6761A6CC7a17));
    IPancakeRouter02 public pancakeRouter = IPancakeRouter02(pancakeRouterAddress);
    IPancakeFactory public pancakeFactory = IPancakeFactory(factoryAddress);

    address[] public stakers;
    address[] public lockedStakers;
    mapping(address => uint256) public startTime;
    mapping(address => uint256) public lockedStartTime;
    mapping(address => uint) public stakingBalance;
    mapping(address => uint) public lockedStakingBalance;
    mapping(address => uint256) public rewardBalance;
    mapping(address => uint256) public lockedRewardBalance;
    mapping(address => bool) public hasLockedStaked;
    mapping(address => bool) public isLockedStaking;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;


    // in constructor pass in the address for USDC token and your custom bank token
    // that will be used to pay interest
    constructor() public {
        usdc = 0x0A46723329DB264322458226D2412Bc541211e67;
        bankToken = 0x5A4bc888163a21CB2e3eDc3f526980cc15ea1172;
    }

    
    
    function approveStake(uint tokens) public {
        IERC20(usdc).approve(address(this),tokens);
      //  emit Approval(msg.sender,address(this),tokens);
    }
    
    
    
    //allow user to stake with 1 parameter @ammount
    function stakeTokens(uint _amount) public {
        
        uint fullAmmount = _amount;//*(10 ** 18);//*1000000000000000000;
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
            uint256 toTransfer = calculateYieldTotal(msg.sender,1);
            rewardBalance[msg.sender] += toTransfer;
        }

        // Update staking status to track
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
        startTime[msg.sender] = block.timestamp;
    }
    
     function lockedStaking15Days(uint _amount) public {
        
        uint fullAmmount = _amount;//*1000000000000000000;
        IERC20(usdc).transferFrom(msg.sender, address(this), fullAmmount);
        if(!hasLockedStaked[msg.sender]) {
            lockedStakers.push(msg.sender);
        }
        if(isLockedStaking[msg.sender] == true){
            //Say already staked
        }
        isLockedStaking[msg.sender] = true;
        hasLockedStaked[msg.sender] = true;
        lockedStartTime[msg.sender] = block.timestamp;
    }


    function getBalance() public view returns (uint){
        uint balance = stakingBalance[msg.sender];
        return balance;
    }
    

    //has autoharvest of pending rewards
    function unstakeTokens(uint amount) public{
        require(stakingBalance[msg.sender] >= amount);
        
       // uint256 fullAmmount = amount;//*1000000000000000000;
        
        uint256 yieldTransfer = calculateYieldTotal(msg.sender,1);
        
        stakingBalance[msg.sender] -= amount;
        if(stakingBalance[msg.sender]<= 0){
            isStaking[msg.sender] = false;
        }
        IERC20(usdc).transfer(msg.sender, amount);

        yieldTransfer+= rewardBalance[msg.sender];
        rewardBalance[msg.sender] = 0;
        startTime[msg.sender] = block.timestamp;
        IERC20(bankToken).transfer(msg.sender, yieldTransfer);
    }
    
    
    function unstake15Days(uint amount) public{
        if(calculateYieldTime(msg.sender) >= 1314000){
           // uint256 fullAmmount = amount;//*1000000000000000000;
            uint256 yieldTransfer = calculateYieldTotal(msg.sender,2);
            lockedStartTime[msg.sender] = 0;
            lockedStakingBalance[msg.sender] = 0;
            isLockedStaking[msg.sender] = false;
            IERC20(usdc).transfer(msg.sender, amount);
            IERC20(bankToken).transfer(msg.sender, yieldTransfer);
        }
        
        else{
            IERC20(usdc).transfer(msg.sender, amount);
        }
    }
    
 
    function calculateYieldTime(address user) public view returns(uint256){
        if(isStaking[user] == true){
            uint256 end = block.timestamp;
            uint256 totalTime = end - startTime[user];
            return totalTime;
         }
    }

    function calculateYieldTotal(address user,uint256 mode) public view returns(uint256) {
        uint256 time = calculateYieldTime(user) * 10**18;
        uint rate;
        if(mode == 1) {rate = 86400;} // 4.6 for 2 days 7 hours 
        if(mode == 2) {rate = 172800;} //double for locked staking 
        uint256 timeRate = time / rate;
        uint256 rawYield = (stakingBalance[user] * timeRate) / 10**18;
        return rawYield;
    }
    
    function yieldReadable(address user) public view returns(uint256){
        if(isStaking[user]){
            uint256 time = calculateYieldTotal(user,1)*1000000000000000000;
            return time;
        }
    }
    
    function yieldReadableLocked(address user) public view returns(uint256){
        if(isLockedStaking[user]){
            uint256 time = calculateYieldTotal(user,2)*1000000000000000000;
            return time;
        }
    }
    
    
    function withdrawYield() public {
        uint256 toTransfer = calculateYieldTotal(msg.sender,1);
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
    
    function withdrawYield15Days() public {
        uint256 toTransfer = calculateYieldTotal(msg.sender,2);
        if(calculateYieldTime(msg.sender)>=1314000){
            toTransfer+= lockedRewardBalance[msg.sender];
            lockedRewardBalance[msg.sender] = 0;
        }
        startTime[msg.sender] = 0;
        IERC20(bankToken).transfer(msg.sender, toTransfer);
        
    } 
    
    function createLiquidityPair(/*uint256 token1,uint256 token2,*/uint256 amountToken1,uint256 amountToken2) public{
        
        pancakeFactory.createPair(usdc,bankToken);
     //   IERC20(usdc).approve(pancakeRouter,10000000000000000000000);
       // IERC20(bankToken).approve(pancakeRouter,10000000000000000000000);
        addLiquidity(pancakeRouterAddress,msg.sender,amountToken1,amountToken2);
        //pancakeRouter.addLiquidity(usdc,bankToken,amountToken1,amountToken2,amountToken1,amountToken2,address(msg.sender),block.timestamp + 360);
    }
    function createLiquidityWithBNB(uint256 bnbAmount, uint256 bankTokenAmount) public{
        pancakeRouter.addLiquidityETH{value : bnbAmount}(usdc,bankTokenAmount,bnbAmount,bankTokenAmount,address(msg.sender),1619341416);
    }
   
    function addLiquidity(
        address routerAddress,
        address owner,
        uint256 tokenAmount,
        uint256 ethAmount) public {
        IPancakeRouter02 pancakeRouterz = IPancakeRouter02(routerAddress);
        
        //approve 
         IERC20(usdc).approve(routerAddress,tokenAmount);
         IERC20(usdc).transferFrom(msg.sender, address(this),tokenAmount);
         
        // add the liquidity
        pancakeRouterz.addLiquidityETH{value : ethAmount}(
            usdc,
            tokenAmount,
            0, // slippage is unavoidable
            0, // slippage is unavoidable
            owner,
            block.timestamp + 360
        );
    }

   
    
    
    
    /*
    
    
    function swapTokensForEth(address routerAddress, uint256 tokenAmount) public {
        IPancakeRouter02 pancakeRouter = IPancakeRouter02(routerAddress);

        // generate the pancake pair path of token -> weth
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = pancakeRouter.WETH();

        // make the swap
        pancakeRouter.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0, // accept any amount of BNB
            path,
            address(this),
            block.timestamp
        );
    }

    function swapETHForTokens(
        address routerAddress,
        address recipient,
        uint256 ethAmount
    ) public {
        IPancakeRouter02 pancakeRouter = IPancakeRouter02(routerAddress);

        // generate the pancake pair path of token -> weth
        address[] memory path = new address[](2);
        path[0] = pancakeRouter.WETH();
        path[1] = address(this);

        // make the swap
        pancakeRouter.swapExactETHForTokensSupportingFeeOnTransferTokens{value : ethAmount}(
            0, // accept any amount of BNB
            path,
            address(recipient),
            block.timestamp + 360
        );
    }

    function addLiquidity(
        address routerAddress,
        address owner,
        uint256 tokenAmount,
        uint256 ethAmount
    ) public {
        IPancakeRouter02 pancakeRouter = IPancakeRouter02(routerAddress);

        // add the liquidity
        pancakeRouter.addLiquidityETH{value : ethAmount}(
            address(this),
            tokenAmount,
            0, // slippage is unavoidable
            0, // slippage is unavoidable
            owner,
            block.timestamp + 360
        );
    }
    */
    
}
