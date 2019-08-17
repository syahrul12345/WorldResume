<template>
	<v-container fill-height>
		<v-row>
			<v-col col="12">
				<v-row justify ="center">
					<v-col md="auto">
						<p id="mainText">Your Digital Identity is: {{digitalIdentity}}</p>
						<p id="mainText">Your Resume Identity is: {{resumeIdentity}}</p>

					</v-col>
				</v-row>
				<v-row justify="center">
					<v-col md="auto">
						<v-btn> Create </v-btn>
					</v-col>
					<v-col md="auto">
						<router-link
						:to="`/Employee/${resumeIdentity}`">
						<v-btn> View </v-btn>
						</router-link>
					</v-col>
				</v-row>
			</v-col>
		</v-row>
		
	</v-container>
</template>
<script>
	export default {
		data() {
			return {
				created: null,
				metmask:null,
				digitalIdentity: null,
				resumeIdentity: null,
			}
		},

		async created() {
			if(window.ethereum) {
				const accounts = await ethereum.enable()
				this.digitalIdentity = accounts[0]
			}else {
				console.log("No metamask")
			}
		},
		mounted() {
			var self = this
			ethereum.on('accountsChanged', async function (accounts) {
				const newAccounts = await ethereum.enable()
				self.$emit("address-changed",newAccounts[0])
			})
		},
		methods: {
			updateAddress() {
				console.log("address updated")
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