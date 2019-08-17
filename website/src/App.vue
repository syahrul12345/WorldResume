<template>
  <v-app>
    <v-app-bar 
    app 
    absolute 
    app
    id="header"
    >
        <!-- <v-container grid-list-xs>
          <v-layout shrink>
            <v-flex xs2 offset-xs3>
              ABOUT
            </v-flex>
            <v-flex xs2>
              WHY WORLD RESUME
            </v-flex>
            <v-flex xs2>
              Employees
            </v-flex>
            <v-flex xs2>
              Employers
            </v-flex>
          </v-layout>
        </v-container> -->
    </v-app-bar>
    <v-content id = "animated">
      <router-view/>
    </v-content>
  </v-app>
</template>

<script>
import Home from './views/Home.vue'
export default {
  name: 'App',
  components: {
    Home
  },
  data: () => ({
    //
  }),
  
};
</script>
<style>
  #header {
    background-color: #4F4463;
    background-color:rgba(79,68,99,0.2);
  }
</style>
