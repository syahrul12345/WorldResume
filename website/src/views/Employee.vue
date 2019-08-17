<template>
	<v-container>
		<v-row justify="center" align="center">
			<v-col md="auto">
				<v-row justify="center" align="center">
					<h1 id="myName"> {{name}} </h1>
				</v-row justify="center" align="center">
					<h2 id="about"> {{about}}</h2>
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
	export default{
		props:[],
		components: {

		},
		data() {
			return {
				name:"Syahrul Nizam",
				about:"I am a Solidity Developer",
				resumeAddress:"0x21312312312321",
				employers:[
					{"id":1,"name":"Chainstack","duration":"Jun 2019 - Present","position":"Developer Advocate","verified":true},
					{"id":1,"name":"Talenta","duration":"April 2019 - Jun 2019","position":"Project Manager","verified":false}
				],
				created:true,
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