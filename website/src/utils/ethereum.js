const Web3 = require('web3')
const localProvider = "http://127.0.0.1:8545"
const realProvider = "https://nd-987-442-424.p2pify.com"
const web3 = new Web3(new Web3.providers.HttpProvider(localProvider))
import contractInfo from '../../../build/contracts/PortfolioFactory.json'
import portFolio from './../../../build/contracts/Portfolio.json'

export const getContractInfo = async() => {
	const portFolioABI = contractInfo.abi
	const deployedAddress = getNetworkId()
	return {portFolioABI,deployedAddress}
	
}
export const getPortfolioInfo = async() => {
	const portFolioABI = portFolio.abi
	return {portFolioABI}
	
}
const getNetworkId = () => {
	for(var i in contractInfo.networks) {
		return contractInfo.networks[i].address
	}
}

