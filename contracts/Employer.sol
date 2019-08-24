pragma solidity = 0.5.0;

contract Employer {
	mapping(address => string) employers;
	address[] public addresses

	address public owner
	uint private count;
	constructor() public {
		owner = msg.sender;
		count = 0;
	}

	function register(string calldata _name) external {
		require(addresses[msg.sender] == 0);
		employers[msg.sender] = _name;
		
	}

}