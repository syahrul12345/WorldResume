const Web3 = require('web3')
const localProvider = "http://127.0.0.1:8545"
const realProvider = "https://nd-987-442-424.p2pify.com"
const web3 = new Web3(new Web3.providers.HttpProvider(localProvider))
import contractInfo from '../../../build/contracts/PortfolioFactory.json'
import portFolio from './../../../build/contracts/Portfolio.json'
import employer from './../../../build/contracts/Employer.json'
export const getContractInfo = async() => {
	const portFolioABI = contractInfo.abi
	const deployedAddress = getNetworkId(contractInfo)
	return {portFolioABI,deployedAddress}
	
}
export const getPortfolioInfo = async() => {
	const portFolioABI = portFolio.abi
	return {portFolioABI}
	
}

export const getEmployerTracker = async() => {
	const employerTrackerABI = employer.abi
	const deployedAddress = getNetworkId(employer)
	return {employerTrackerABI,deployedAddress}
}


const getNetworkId = (contractInfo) => {
	for(var i in contractInfo.networks) {
		return contractInfo.networks[i].address
	}
}

