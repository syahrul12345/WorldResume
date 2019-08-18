pragma solidity = 0.5.9;

contract Portfolio {
	address public owner;
	constructor(address _owner) public {
		owner = _owner;
	}
	struct job {
		string companyName;
		string position;
		uint start;
		uint end;
		bool verified;
	}
	uint256 private count;
	bytes32[] private jobIDs;
	mapping(bytes32 => job) jobMapping;

	function addJob(string calldata _companyName,string calldata _position,uint _start,uint _end) external {
		bytes32 id = keccak256(abi.encodePacked(_companyName,_position,_start,_end,count));
		jobIDs.push(id);
		count++;
		jobMapping[id].companyName = _companyName;
		jobMapping[id].position = _position;
		jobMapping[id].start = _start;
		jobMapping[id].end = _end;
		jobMapping[id].verified = false;
	}
	function getJobById(bytes32 _id) external view returns(string memory,string memory,uint,uint,bool) {
		return(jobMapping[_id].companyName,jobMapping[_id].position,jobMapping[_id].start,jobMapping[_id].end,jobMapping[_id].verified);
	}
	function getAllJobId() external view returns (bytes32[] memory) {
		return jobIDs;
	}
	function verify(bytes32 _id) external {
	    jobMapping[_id].verified = true;
	} 

}

contract PortfolioFactory {
	mapping (address => address) ownerToPortFolio;

	constructor() public {

	}
	
	function createPortfolio() public {
		Portfolio p = new Portfolio(tx.origin);
		ownerToPortFolio[tx.origin] = address(p);
	}
	function getPortfolioAddress() public view returns (address) {
		return ownerToPortFolio[tx.origin];
	}
	function addJob(string calldata _companyName,string calldata _position,uint _start,uint _end) external {
		Portfolio p = Portfolio(ownerToPortFolio[tx.origin]);
		p.addJob(_companyName,_position,_start,_end);
	}
	function getAllJobId() external view returns (bytes32[] memory) {
		Portfolio p = Portfolio(ownerToPortFolio[tx.origin]);
		return p.getAllJobId();
	}
	function getJobById(bytes32 _id) external view returns(string memory,string memory,uint,uint,bool) {
		Portfolio p = Portfolio(ownerToPortFolio[tx.origin]);
		return p.getJobById(_id);
	}

}