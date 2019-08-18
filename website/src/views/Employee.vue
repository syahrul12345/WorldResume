<template>
	<v-container>
		<v-row justify="center" align="center">
			<v-col md="auto">
				<v-row justify="center" align="center">
					<h1 id="myName"> {{name}} </h1>
				</v-row justify="center" align="center">
					<h2 id="about"> {{blurb}}</h2>
				<v-row justify="center" align="center">
					<h3 id="address"> {{resumeAddress}}</h3>
				</v-row>
			</v-col>
		</v-row>
		<v-layout wrap>
			<v-flex xs12>
				<v-card
					class="mb-4"
					dark
					:outline="false"
					:text="true"
					v-for="employer in employers"
					:key="employer.id">
						<h3>{{employer.name}}</h3>
						<h3>{{employer.duration}} 
							<span id="verify" v-if="employer.verified == true"> Verified</span>
							<span id="verify" v-else> Not Verified </span>
						</h3>
						<h3>{{employer.position}}</h3>
					</v-card>
			</v-flex>
		</v-layout>
		<v-row justify="center" align ="center">
			<v-col md="auto">
				<v-btn> Edit </v-btn>
			</v-col>
			<v-col md ="auto">
				<v-btn> Share </v-btn>
			</v-col>
		</v-row>
		
	</v-container>
</template>
<script>
	import {getContractInfo} from '../utils/ethereum.js'
	const Web3 = require('web3')
	export default{

		components: {

		},
		data() {
			return {
				name:null,
				blurb:null,
				employers:[],
				created:true,
				digitalIdentity:null,
				resumeAddress:null,
				jobIds:null,
				web3:null,
				contract:null,
			}
		},
		async created(){
			const self = this;
			const promiseArray = []
			promiseArray.push(ethereum.enable())
			promiseArray.push(getContractInfo())
			Promise.all(promiseArray).then((result)=>{
				self.digitalIdentity = result[0][0]
				self.web3 = new Web3(ethereum)
				self.contract = new self.web3.eth.Contract(result[1].portFolioABI,result[1].deployedAddress)
				const promiseArray2 = []
				promiseArray2.push(self.contract.methods.getPortfolioAddress()
																							.call({from:self.digitalIdentity}))
				promiseArray2.push(self.contract.methods.getAllJobId(self.digitalIdentity)
																								.call({from:self.digitalIdentity}))
				Promise.all(promiseArray2).then((result) =>{
					self.resumeAddress = result[0]
					self.jobIds = result[1]
					const jobData = self.jobIds.map((item) => {
						const data = self.contract.methods.getJobById(self.digitalIdentity,item).call()
						return data
					})
					Promise.all(jobData).then((result) => {
						const converted = result.map((item) => {
							const promiseArray = []
							promiseArray.push(self.bytes32ToString(self.web3,item[0]))
							promiseArray.push(self.bytes32ToString(self.web3,item[1]))
							return Promise.all(promiseArray).then((result) =>{
								return { name:result[0], position:result[1], start:item[2], end:item[3]}
							})
						})
						Promise.all(converted).then((results) => {
							self.contract.methods
							.getDetails(self.digitalIdentity)
							.call({from:self.digitalIdentity})
							.then((results) => {
								self.name = results[0]
								self.blurb = results[1]
							})
							self.employers = results
						})
					})
				})
			})
		},
		methods: {
			bytes32ToString: async(web3,item) => {
				return web3.utils.toAscii(item)
			}
		}
	}
</script>
<style>
	#myName {
		font-family: "Monaco";
		text-align: center;
		font-size:35px;
		color: white;
	}
	#about {
		font-family: "Monaco";
		text-align: center;
		font-size:25px;
		color: white;
	}
	#address {
		font-family: "Monaco";
		text-align: center;
		color:white;
	}
	#verify {
		float: right;
		margin-right:1%;
	}


</style>