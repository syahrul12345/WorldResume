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
									label="name">
									v-model="name"
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
				jobs: []
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
			addJobCard(){
				this.addJobCards++
				console.log("creating new job")
			},
			confirm(){
				console.log(this.jobs)
			}

		}
	}
</script>
<style></style>