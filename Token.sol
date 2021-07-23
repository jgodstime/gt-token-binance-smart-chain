pragma solidity ^0.8.2;

contract Token {
    mapping(address => uint) public balances; //track the token balance for each address eg: 0x8838839393 => 1200, oxgdty7373 => 1000
    
    // 0xhdjd83(owner address) -> 0xvf8838839393(address of person that wants to transfer the token to another 1) => 1200,
    // -> 0x788838839393(address of person that wants to transfer the token to another 2) => 1200,
    // -> 0x8838839393(address of person that wants to transfer the token to another 3) => 1200,
    mapping(address => mapping(address => uint)) public allowance;  

    uint public totalSupply = 10000 * 10 ** 18;
    string public name = "GT Token";
    string public symbol = "GTKN";
    uint public decimals = 18; //smallest fraction of token you can transfer
    
    event Transfer(address indexed from, address indexed to, uint value); //indexed: you can filter this event from outsie the blockchain.  event after transfer is done
    event Approval(address indexed owner, address indexed spender, uint value);
    
    constructor(){
        balances[msg.sender] = totalSupply; //msg.sender the address that sends the transaction (Whoever deploys the token, the admin of the the project )
        
    }
    
    function balanceOf(address owner) public view returns(uint){
        return balances[owner];
    }
    
    // Owner can transfer to another address
    function transfer(address to, uint value) public returns(bool){
        require(balances[msg.sender] >= value, "Balance to low");
        balances[to] += value; 
        balances[msg.sender] -= value;
        emit Transfer(msg.sender, to, value);
        return true;
    }
    
    // Transfer for an address 
    function transferFrom(address from, address to, uint value) public returns(bool){
        require(balances[from] >= value, "Balance to low");
        require(allowance[from][msg.sender] >= value, "Allowance too low"); //check amount that is allowed to send 
        balances[to] += value;
        balances[from] -= value;
        emit Transfer(from, to, value);
        return true;
    }
    
    // Add an address that can transfer for you to another address with amount
    function approve(address spender, uint value) public returns(bool){
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
    
    
    
}
