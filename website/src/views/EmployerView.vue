<template>
	<v-row justify="center">
		<v-col cols="auto">
			<v-card>
				<v-card-title> {{name}} </v-card-title>
				<v-card-text> {{blurb}} </v-card-text>
				<v-card-text> {{resumeAddress}}</v-card-text>
			</v-card>
		</v-col>
		<v-col cols="auto" md="8">
			<v-card
				class="mb-4"
				dark
				:outline="false"
				:text="true"
				v-for="employer in employers"
				:key="employer.id">
					<v-card-title>{{employer.name}}</v-card-title>
					<v-card-text class="pb-0">{{employer.duration}} 
						<span id="verify" v-if="employer.verified == true"> Verified</span>
						<span id="verify" v-else> Not Verified. <v-btn>Verify Now!</v-btn> </span>
					</v-card-text>
					<v-card-text class= "pt-0">{{employer.position}}</v-card-text>
				</v-card>
		</v-col>
		<v-dialog v-model="loading" persistent max-width="300">
			<Loader :resumeAddress="resumeAddress"></Loader>
		</v-dialog>
	</v-row>
</template>
<script>
	import Loader from "./../components/LoaderV2.vue"
	import {getPortfolioInfo} from '../utils/ethereum.js'
	const Web3 = require('web3')
	export default {
		title: 'resume',
		components: {
			Loader
		},
		data() {
			return {
				name:null,
				blurb:null,
				created: true,
				employers:null,
				loading:false,
				resumeAddress:null,
				web3:null,
				contract:null,
				employers:[],

			}
		},
		async created(){
			if(window.ethereum){
				this.web3 = new Web3(ethereum)
				this.resumeAddress = this.$route.params.resumeIdentity
				const result = await getPortfolioInfo()
				const abi = result.portFolioABI
				const portfolio = new this.web3.eth.Contract(abi,this.resumeAddress)
				portfolio.methods.getAllJobId().call().then((result) => {
					this.loading = true;
					const promiseArray = []
					result.forEach((jobHash) => {
						promiseArray.push(portfolio.methods.getJobById(jobHash).call())
					})
					Promise.all(promiseArray).then((result) => {
						const converted = result.map((item) => {
								//item[2] and item[3] are the dates
								const promiseArray = []
								promiseArray.push(this.bytes32ToString(this.web3,item[0]))
								promiseArray.push(this.bytes32ToString(this.web3,item[1]))
								const startDate = this.dateExtractor(new Date(Math.round(Number(item[2]))))
								const endDate = this.dateExtractor(new Date(Math.round(Number(item[3]))))
								const stringDate = startDate + ' - ' + endDate
								return Promise.all(promiseArray).then((result) =>{
									return { name:result[0], position:result[1], duration:stringDate}
								})
						})
						Promise.all(converted).then((result) => {
							portfolio.methods.getDetails().call().then((result) =>{
								this.name = result[0]
								this.blurb = result[1]
							})
							this.employers = result
							this.loading = false;
						})
					})
				})
			}else{
				console.log("no metamask")
			}
		},
		methods: {
			bytes32ToString: async(web3,item) => {
				return web3.utils.toAscii(item)
			},
			dateExtractor:(date) => {
				const monthNames = ["January", "February", "March", "April", "May", "June",
				  "July", "August", "September", "October", "November", "December"
				];
				return monthNames[date.getMonth()] + '-' + date.getUTCFullYear()
			}
		}
	}
</script>
<style></style>