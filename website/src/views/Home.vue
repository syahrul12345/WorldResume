<template>
  <v-container fill-height>
        <v-row>
        	<v-col col="12">
        		<v-row justify="center">
        			<p id="mainText">{{text}}</p>
        		</v-row>
        		<v-row justify="center">
        			<p id="introText">{{text2}}</p>>
        		</v-row>
          		<v-row justify="center">
          			<v-col md="auto">
          				<router-link
                  :to="'/Verify'"
                  style="text-decoration: none">
                  <v-btn
          				> Employees </v-btn>
                  </router-link>
          			</v-col>
          			<v-col md="auto">
                  <router-link
                  :to="'/Employers'"
                   style="text-decoration: none">
          				<v-btn
          				> Employers </v-btn>
                  </router-link>
          			</v-col>
          		</v-row>
          		<v-row justify="center" align="center">
  					<v-img 
      				:max-width="35"
      				aspect-raio="1"
      				:src="metmaskImage"></v-img>
  					<p id="metamask"> Metamask Required</p>
          		</v-row>
              <v-row justify="center">
                <v-dialog v-model="dialog" persistent max-width="300px">
                  <v-card>
                    <v-card-title>No metamask detected!</v-card-title>
                    <v-card-text> Please install metamask before proceeding</v-card-text>
                    <v-card-actions>
                      <v-btn :text="true" @click="dialog=false">OK</v-btn>
                    </v-card-actions>
                  </v-card>
                </v-dialog>
              </v-row>
        	</v-col>
        </v-row>
        
 </v-container>
</template>
<script>
export default {
  components: {
  },
  data() {
  	return {
  		text:"WorldResume, the new resume storage service for the world of Web3.",
  		text2:"Instantly create and personalize your own resume, and get it verfied by past employers.",
  		metmaskImage:require('./../assets/metamask.svg'),
      dialog:false
     
  	}
  },
  beforeRouteLeave(to,from,next) {
    const self = this
    if(to.name == "verify"){
      if(window.ethereum){
        next()
      }else{
        self.dialog=true
      }
    }else{
      next()
    }
    
  }
};
</script>

<style>
	#mainText {
		font-family: "Monaco";
		text-align: center;
		font-size:50px;
		color: white;
	}
	#introText {
		font-family:"Monaco";
		color: white;
	}
	#metamask {
		font-family:"Monaco";
		color: white;
		text-align: center;
		margin-top:15px;
		margin-left:20px;
	}
</style>