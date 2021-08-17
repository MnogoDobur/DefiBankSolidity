function approveLiquidityPair(address token1,address token2,uint256 amountToken1, uint256 amountToken2) public payable{
      IERC20(token1).approve(address(this),amountToken1);
      IERC20(token2).approve(address(this),amountToken2);
  }
  function addTokenForLiquidity(address token1, address token2, uint256 amountToken1, uint256 amountToken2) public payable{
      IERC20(token1).transferFrom(msg.sender,address(this),amountToken1);
      IERC20(token2).transferFrom(msg.sender,address(this),amountToken2);
  }
  
       
  
  function createLiquidityPair(address token1,address token2,uint256 amountToken1,uint256 amountToken2) public payable{ 
      
      //pancakeFactory.createPair(usdc,bankToken);
      IERC20(token1).approve(pancakeRouterAddress,amountToken1);
      IERC20(token2).approve(pancakeRouterAddress,amountToken2);
      pancakeRouter.addLiquidity(token1,token2,amountToken1,amountToken2,amountToken1,amountToken2,address(msg.sender),block.timestamp + 360);
    }
  function getLiquidityPair(address token1, address token2) public view returns (address pair){
      return pancakeFactory.getPair(token1,token2);
  }
  
  function removeLiquidityPair(uint256 amountToken1, uint256 amountToken2,uint256 liquidityAmount) public payable{
    //  IERC20(usdc).approve(pancakeRouterAddress,amountToken1);
    //  IERC20(bankToken).approve(pancakeRouterAddress,amountToken2);
      IERC20(pancakeFactory.getPair(usdc,bankToken)).approve(pancakeRouterAddress,liquidityAmount);
      pancakeRouter.removeLiquidity(usdc,bankToken,liquidityAmount,amountToken1,amountToken2,address(msg.sender),block.timestamp + 360);
  }
            
    function appoveBnb(uint256 amount)public payable{
        IERC20(pancakeRouter.WETH()).approve(address(this),amount);
    }
    
    function receiveBnb(uint256 amount)public payable{
        IERC20(pancakeRouter.WETH()).transferFrom(msg.sender,address(this),amount);
    }
