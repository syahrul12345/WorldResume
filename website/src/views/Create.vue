<template>
	<v-container fill-height>
		<v-layout justify="center">
			<v-flex xs10 offset-xs1>
				<v-card
				dark
				:hover="true">
					<v-container>
						<v-layout wrap>
							<v-flex xs12>
								<v-form
								ref="form"
								:lazy-validation="true">
									<v-text-field
									v-model="name"
									label="name">
									</v-text-field>
									<v-text-field
									v-model="blurb"
									label="Short Description About Yourself">
									</v-text-field>
									<AddJob
									class = "mb-5"
									v-for="i in addJobCards"
									:id="i"
									v-on:save="updateValue($event)"
									v-on:close="deleteValue($event)"
									>
									</AddJob>
								</v-form>
								<v-row justify="space-between">
									<v-col md="auto">
										<v-btn @click="addJobCard"> Add Job</v-btn>
									</v-col>
									<v-col md="auto">
										<v-btn @click="confirm">Save to Blockchain </v-btn>
									</v-col>
								</v-row>
							</v-flex>
							
						</v-layout>
						
					</v-container>
				</v-card>
			</v-flex>
		</v-layout>
	</v-container>
</template>
<script>
	import AddJob from "../components/AddJob.vue"
	import {getContractInfo} from '../utils/ethereum.js'
	const Web3 = require('web3')
	export default {

		props:[],
		components:{
			AddJob
		},
		data() {
			return {
				name: null,
				blurb:null,
				created:true,
				addJobCards:1,
				digitalIdentity:null,
				web3:null,
				contract:null,
				jobs: []
			}
		},
		async created() {
			//we want to create the web3 object upon creation of this page
			if(window.ethereum) {
				const accounts = await ethereum.enable()
				this.digitalIdentity = accounts[0]
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
		methods: {
			updateValue(value){
				//find if the object key exists
				let item = this.jobs.find(e => e.id === value.id)
				if(item === undefined){
					this.jobs.push(value)
				}else {
					let index = this.jobs.findIndex(e => e.id === value.id)
					this.jobs[index] = value
				}
			},
			deleteValue(value){
				let index = this.jobs.findIndex(e=> e.id === value.id)
				this.jobs.splice(index,1)
				
			},
			addJobCard(){
				this.addJobCards++
				console.log("creating new job")
			},
			confirm(){
				let _companyNames = []
				let _positions=[]
				const _startTimes=[]
				const _endTimes=[]
				this.jobs.forEach((item) =>{
					_companyNames.push(item.companyName)
					_positions.push(item.position)
					_startTimes.push(item.start)
					_endTimes.push(item.end)
				})
				_companyNames = this.stringToBytes32(_companyNames,this.web3)
				_positions = this.stringToBytes32(_positions,this.web3)
				console.log(_companyNames)
				console.log(_positions)
				console.log(_startTimes)
				console.log(_endTimes)
				// this.contract.methods.createPortfolio(
				// 		this.digitalIdentity,
				// 		this.name,
				// 		this.blurb,
				// 		_companyNames,
				// 		_positions,
				// 		_startTimes,
				// 		_endTimes).send({
				// 			from:this.digitalIdentity
				// 		}).then((result) => {
				// 			console.log(result)
				// 		}).catch((error) => {
				// 			console.log(error)
				// 		})
				try{
					this.contract.methods.createPortfolio(
						this.digitalIdentity,
						this.name,
						this.blurb,
						_companyNames,
						_positions,
						_startTimes,
						_endTimes).send({
							from:this.digitalIdentity
						}).then((result) => {
							console.log(result)
						}).catch((error) => {
							console.log(error)
						})
					}catch (ex){
						console.log(ex.toString())
					}
				

			},
			stringToBytes32: (stringArray,web3) => {
				const returnArray = []
				stringArray.forEach((item) => {
					returnArray.push(web3.utils.toHex(item))
					
				})
				return returnArray
			}
			

		}
	}
</script>
<style></style>