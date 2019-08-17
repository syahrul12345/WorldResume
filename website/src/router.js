import Vue from "vue";
import Router from "vue-router";
import Home from "./views/Home.vue";
import Employee from "./views/Employee.vue"
import Verify from "./views/Verify.vue"

Vue.use(Router);

export default new Router({
  mode: "history",
  base: process.env.BASE_URL,
  routes: [
    {
      path: "/",
      name: "home",
      component: Home
    },
    {
    	path:"/Employee/:resumeIdentity",
    	name:"employee",
    	component: Employee
    },
    {
    	path:"/Verify",
    	name:"verify",
    	component: Verify
    }
  ]
});
