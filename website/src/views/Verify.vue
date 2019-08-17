<template>
	<v-container fill-height>
		<v-row>
			<v-col col="12">
				<v-row justify ="center">
					<v-col md="auto" :key="id">
						<p id="mainText">Your Digital Identity is: {{digitalIdentity}}</p>
					</v-col>
				</v-row>
				<v-row justify="center">
					<v-col md="auto">
						<v-btn @click="createResume"> Create </v-btn>
					</v-col>
					<v-col md="auto">
						<!-- <router-link
						:to="`/Employee/${digitalIdentity}`"
						@click="getContract"> -->
						<v-btn @click="viewResume"> View </v-btn>
						<!-- </router-link> -->
					</v-col>
				</v-row>
			</v-col>
		</v-row>
		
	</v-container>
</template>
<script>
	import {getContractInfo} from '../utils/ethereum.js'
	const Web3 = require('web3')
	export default {
		data() {
			return {
				created: null,
				metmask:null,
				digitalIdentity: null,
				id:null,
				web3:null,
				contract:null,
			}
		},

		async created() {
			if(window.ethereum) {
				const accounts = await ethereum.enable()
				this.digitalIdentity = accounts[0]
				this.id=0
				//we also want to set the web3 & contract
				this.web3 = new Web3(ethereum)
				const results = await getContractInfo()
				const factoryAbi = results.portFolioABI
				const factoryAddress = results.deployedAddress
				this.contract = await new this.web3.eth.Contract(factoryAbi,factoryAddress)
			}else {
				console.log("No metamask")
			}
		},
		mounted() {
			var self = this
			ethereum.on('accountsChanged', async function (accounts) {
				const newAccounts = await ethereum.enable()
				self.digitalIdentity = newAccounts[0]

			})
		},
		methods: {
			async createResume() {
				if(window.ethereum) {
					this.contract.methods.createPortfolio().send({
						from:this.digitalIdentity
					}).then((result) => {
						console.log(result)
					})
				}
			},
			async viewResume(){
				if(window.ethereum){
					this.contract.methods.getPortfolioAddress().call().then((result) => {
						console.log(result)
					})
				}
			}
		}
	}
</script>
<style>
	#mainText {
		font-family: "Monaco";
		text-align: center;
		font-size:25px;
		color: white;
	}
</style>