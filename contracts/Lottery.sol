pragma solidity ^0.4.17;

contract Lottery{
    address public manager;
    address[] public players;

    //constructor
    function Lottery() public {
        manager = msg.sender;
    }
    //Enter
    function enter() public payable{
        require(msg.value >.01 ether);
        players.push(msg.sender);
    }
    //random
    function random() public view returns(uint){
        return uint(keccak256(block.difficulty,now,players));
    }
    //pickAWinner
    function pickAWinner() public restricted{
        uint index = random() % players.length;
        players[index].transfer(this.balance);
        players = new address[](0);
    }
    
    //modifier
    modifier restricted(){
        require(msg.sender == manager);
        _;
    }
    function getPlayers() public view returns(address[]){
        return players;
    }
}
