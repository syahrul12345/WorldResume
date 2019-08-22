<template>
	<v-card>
		<v-card-text>
			<v-row>
			<p class = "my-1">Share the link below as proof that your resume exists on the Blockchain!</p>
			</v-row>
			<v-row align="center" justify="center">
				<v-cols cols="auto">
					<v-text-field
					v-model="resumeLink"
					single-line
					outlined>
					</v-text-field>
				</v-cols>
				<v-cols cols="auto">
					<v-btn> COPY</v-btn>
				</v-cols>
			<!-- <a 
			target="_blank" rel="noopener noreferrer"
			:href="resumeLink"><p class="mb-0"> Click on this link to see your resume on the blockchain..</p></a> -->
			</v-row>
		</v-card-text>
	</v-card>
</template>
<script>
	export default{
		props:['resumeAddress'],
		data() {
			return{
				created:true,
				resumeLink:null
			}
		},
		created(){
			this.resumeLink = `https://ropsten.etherscan.io/address/${this.resumeAddress}`
		}
	}
</script>
<style></style>