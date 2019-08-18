<template>
	<v-container fill-height>
		<v-row>
			<v-col col="12">
				<v-row justify ="center">
					<v-col md="auto" :key="id">
						<p id="mainText">Your Digital Identity is: {{digitalIdentity}}</p>
					</v-col>
					<v-col md="auto" v-if="resumeNotFound">
						<p id="errorText">Resume not found. If you've just created it, please wait for a few minutes.</p>
					</v-col>
				</v-row>
				<v-row justify="center">
					<v-col md="auto">
						<router-link
						:to="'/Create'"
						style="text-decoration: none">
						<v-btn> Create </v-btn>
						</router-link>
					</v-col>
					<v-col md="auto">
						<router-link
						:to="`/Employee/${digitalIdentity}`"
						style="text-decoration: none"
						>
						<v-btn> View </v-btn>
						</router-link>
					</v-col>
				</v-row>
				<v-row justify="center">
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
				resumeNotFound:false,
				digitalIdentity: null,
				resumeAddress:null,
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
		beforeRouteEnter(to,from,next) {
			console.log("checking for metamask...")
			if(window.ethereum) {
				console.log("metamask detected")
				next()
			}else {
				console.log("no metamask")
				console.log("metamask should be checked for in the previous page")
				console.log(from)
				next(from)
			}
		},
		async beforeRouteLeave(to,from,next) {
			if(to.name == "employee") {
				const resumeAddress = await this.contract
																			.methods
																			.getPortfolioAddress()
																			.call({from:this.digitalIdentity})
				if(resumeAddress !== '0x0000000000000000000000000000000000000000'){
					this.resumeNotFound = false
					next()
				}else {
					this.resumeNotFound = true
				}
			}else {
				next()
			}
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
	#errorText {
		font-family: "Monaco";
		text-align: center;
		font-size:25px;
		color: red;
	}
</style>