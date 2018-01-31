pragma solidity ^0.4.4;

import "./SafeMath.sol";

contract ERC20Interface {
  function totalSupply() public view returns (uint256);
  function balanceOf(address who) public view returns (uint256);
  function transfer(address to, uint256 token) public returns (bool);
  function allowance(address owner, address spender) public view returns (uint256);
  function transferFrom(address from, address to, uint256 value) public returns (bool);
  function approve(address spender, uint256 value) public returns (bool);
  event Transfer(address indexed from, address indexed to, uint256 token);
  event Approval(address indexed from, address indexed to, uint256 token);

}


contract Turtle is ERC20Interface {
  string public constant name = "Turtle Coin";
  string public constant symbol = "TUR";
  uint8 public constant decimal = 0; 
  mapping(address => uint256)  balances;
  mapping(address => mapping(address=>uint256)) internal allowed;
  uint256 _totalSupply;

  function Turtle(uint256 initSupply) {
    _totalSupply = initSupply;
  }
  function totalSupply() public view returns (uint256) {
    return _totalSupply;
  }
  function balanceOf(address who) public view returns (uint256) {
    return balances[who];
  }

  function transfer(address to, uint256 value) public  returns (bool) {
    require(to != address(0)); //reciever 不可是 address 0
    require(value <= balances[msg.sender]); // 轉送金額不可以大於sender 的 balance
    balances[msg.sender] = SafeMath.sub(balances[msg.sender], value);
    balances[to] = SafeMath.add(balances[to], value);
    Transfer(msg.sender, to, value);
    return true;
  }
  function allowance(address owner, address spender) public view returns (uint256) {
    return allowed[owner][spender];
  }
  function transferFrom(address from, address to, uint256 value) public returns (bool) {
    require(to != address(0)); //不可轉給 address 0
    require(value <= balances[from]);
    require(value <= allowed[from][msg.sender]); //  value 不可以大於 被允許的數目
    balances[from] = SafeMath.sub(balances[from], value);
    balances[to] = SafeMath.add(balances[to], value);
    allowed[from][msg.sender] = SafeMath.sub(allowed[from][msg.sender], value);
    Transfer(from, to, value);
  }

  function approve(address spender, uint256 value) public returns (bool) {
    require(spender != address(0));
    require(balances[msg.sender] >= value);
    allowed[msg.sender][spender] = value;
    Approval(msg.sender, spender, value);
    return true;
  }
}
