<template>
	<v-row justify="center"> 
		<v-card 
			v-if="shown"
			:hover="true"
			:outline="20">
			<v-form
			ref="form"
			:lazy-validation="true">
				<v-container grid-list-xl>
					<v-layout shrink>
						<v-flex xs6>
							<v-text-field 
							label="Company Name"
							v-model="companyName"
							@input="$emit('company-name',{id,companyName,position,start,end})">
							</v-text-field>
						</v-flex>
						<v-flex xs6> 
							<v-text-field 
							label ="Position"
							v-model="position"
							@input="$emit('position',{id,companyName,position,start,end})">
							</v-text-field>
						</v-flex>
					</v-layout>
					<v-row justify="end">
						<v-col md="auto"> 
							<v-btn @click="startDialog=true"> Choose Start Date </v-btn>
								<v-row justify="center">
									<v-dialog v-model="startDialog" persistent max-width="300px">
										<v-date-picker v-model="start":landscape="false" type="month">
										</v-date-picker>
										 <v-btn :text="true" @click="startDialog = false	">OK</v-btn>
									</v-dialog>
								</v-row>
						</v-col>
						<v-col md="auto">
							<v-btn @click="endDialog=true"> Choose End Date </v-btn>
								<v-row justify="center">
									<v-dialog v-model="endDialog" persistent max-width="300px">
										<v-date-picker v-model="end":landscape="false" type="month">
										</v-date-picker>
										 <v-btn :text="true" @click="endDialog = false">OK</v-btn>
									</v-dialog>
								</v-row>
						</v-col>
						<v-col md="auto">
							<v-btn @click="save"> Save </v-btn>
						</v-col>
						<v-col md="auto">
							<v-btn @click="close"> Close </v-btn>
						</v-col>
					</v-row>
				</v-container>
				
			</v-form>
			<v-overlay :absolute="absolute" :value="overlay"> 
				<v-btn @click="edit"> EDIT </v-btn>
			</v-overlay>
		</v-card>
	</v-row>
</template>
<script>
	export default {
		props:['id'],
		data() {
			return {
				shown:true,
				overlay:false,
				absolute:true,
				companyName:null,
				position:null,
				start:new Date().toISOString().substr(0, 7),
				end:new Date().toISOString().substr(0, 7),
				startDialog:false,
				endDialog:false
			}
		},
		methods: {
			save(){
				this.$emit('save',{companyName:this.companyName,position:this.position,id:this.id,start:this.start,end:this.end})
				this.overlay = true
			},
			close(){
				this.shown = false
			},
			edit(){
				this.overlay = false
			}
		}
	}
</script>
<style></style>