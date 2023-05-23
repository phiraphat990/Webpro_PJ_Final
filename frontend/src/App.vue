<template>
  <div id="app">
        <!-- nav bar -->
        <nav class="navbar" role="navigation" aria-label="main navigation"
    style="background: linear-gradient(180deg, #32AFA9 0%, rgba(50, 168, 175, 0.6) 100%);
box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);">
      <div class="navbar-brand">
        <router-link to="/" class="navbar-item is-size-4">
          Home
        </router-link>

        <a
          role="button"
          class="navbar-burger"
          aria-label="menu"
          aria-expanded="false"
          data-target="navbarBasicExample"
        >
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
        </a>
      </div>

      <div class="navbar-menu">
        <div class="navbar-end">
          <div v-if="user && user.role == 'seller'" class="navbar-item">
            <router-link to="/blogs/create" class="button is-primary">
              <strong>New Blog</strong>
            </router-link>
          </div>
          <div v-if="!user" class="navbar-item">
            <router-link to="/user/login">
              <strong>Login</strong>
            </router-link>
          </div>
          <div v-if="!user" class="navbar-item">
            <router-link to="/user/signup">
              <strong>Signup</strong>
            </router-link>
          </div>
          <div v-if="user" class="navbar-item">
            <router-link to="/manageProduct">
              <strong>Product</strong>
            </router-link>
          </div>
          <div v-if="user && user.role == 'seller'" class="navbar-item">
            <router-link to="/product/add">
              <strong>Add Product</strong>
            </router-link>
          </div>
          <div v-if="user && user.role == 'seller'" class="navbar-item">
            <router-link to="/checkorder">
              <strong>Check Order</strong>
            </router-link>
          </div>
          <div v-if="user" class="navbar-item">
            <router-link :to="`/mainblog`">
              <strong>Blog</strong>
            </router-link>
          </div>

          <div v-if="user" class="navbar-item has-dropdown is-hoverable">
            <a class="navbar-link">
              <figure class="image is-24x24 my-auto">
                <img class="is-rounded" src="https://bulma.io/images/placeholders/128x128.png">
              </figure>
              <span class="pl-3">{{ user.first_name }} {{ user.last_name }}</span>
            </a>
            <div class="navbar-dropdown">
              <a class="navbar-item"><router-link to="/user/manage">
              <strong>Profile</strong>
            </router-link></a>
              <a class="navbar-item">Log out</a>
            </div>
          </div>
        </div>
      </div>
    </nav>
    
    <router-view :key="$route.fullPath" @auth-change="onAuthChange" :user="user" />
  </div>
</template>

<script>
import axios from '@/plugins/axios'
export default {
  data () {
    return {
      user: null,
    }
  },
   mounted () {
     this.onAuthChange()
   },
   methods: {
     onAuthChange () {
       const token = localStorage.getItem('token')
       if (token) {
         this.getUser()
       }
     },
     getUser () {
      // const token = localStorage.getItem('token')
      axios.get('/user/me').then(res => {
         this.user = res.data
       })
     },
   }
}
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Anuphan');
  #app,button,option{
    font-family: 'Anuphan';
    /* background-color: #E5FDD1; */
  }
</style>

