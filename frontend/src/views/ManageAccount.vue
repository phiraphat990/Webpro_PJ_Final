<template>
  <div>
    <div class="mt-5">
      <p class="has-text-centered is-size-1 has-text-weight-bold">
        User Profile
      </p>
    </div>

    <div class="section level">
      <div
        class="hero level-item is-fullheight p-6 has-background-primary-light"
      >
        <p class="title has-text-centered mb-5 mt-6">Profile Picture</p>
        <div class="columns is-centered">
          <!-- <figure class="image is-square"> -->
          <!-- <img class="is-rounded" :src="user.picture" /> -->

          <!-- </figure> -->
        </div>

        <div class="has-text-centered">
          <button class="button is-warning has-text-weight-bold is-rounded">
            Edit
          </button>
        </div>
      </div>
      <div
        class="hero level-item is-fullheight column is-5 has-background-info-light"
      >
        <div class="pt-6 pb-6 ml-6 mr-6">
          <div class="column">
            <label class="label">First Name</label>
            <div>
              <input
                class="input"
                type="text"
                :disabled="disabled"
                v-model="first_name"
              />
            </div>
          </div>

          <div class="column">
            <label class="label">Last Name</label>
            <div>
              <input
                class="input"
                type="text"
                :disabled="disabled"
                v-model="last_name"
              />
            </div>
          </div>

          <div class="column">
            <label class="label">Phone Number</label>
            <div>
              <input
                class="input"
                type="text"
                :disabled="disabled"
                v-model="mobile"
              />
            </div>
          </div>

          <div class="column">
            <label class="label">Email</label>
            <div>
              <input
                class="input"
                type="email"
                :disabled="disabled"
                v-model="email"
              />
            </div>
          </div>

          <div class="level">
            <button
              class="button is-danger has-text-weight-bold is-rounded"
              @click="disabled = false"
            >
              Edit
            </button>
            <button
              class="button is-info has-text-weight-bold is-rounded"
              @click="disabled = true"
            >
              Cancel
            </button>
            <button class="button is-warning has-text-weight-bold is-rounded" 
            @click="updateProfile()">
              Update
            </button>
          </div>
        </div>
      </div>
    </div>

    <div class="modal" :class="{ 'is-active': showEmailModal }">
        <div class="modal-background"></div>
        <div class="modal-card">
          <header class="modal-card-head has-background-info">
            <p class="modal-card-title has-text-centered has-text-white">
              ยืนยัน
            </p>
          </header>
          <section class="modal-card-body has-text-centered">
            ยืนยันการแก้ไขข้อมูล
          </section>
          <footer class="modal-card-foot">
            <button class="button is-danger" @click="showEmailModal = false, disabled = true">
              Confirm
            </button>
            <button class="button">Cancel</button>
          </footer>
        </div>
      </div>
  </div>
</template>

<script>
import axios from '@/plugins/axios'
export default {
  data () {
    return {
      user: {},
      disabled: true,
      first_name: "",
      last_name: "",
      mobile: "",
      email: "",
      password:"",
      showEmailModal: false
    }
  },
  mounted() {
     this.getUser();
   },
   methods: {
     getUser() {
      // const token = localStorage.getItem('token')
      axios.get('http://localhost:3000/user/manage').then(res => {
         this.user = res.data.user
         this.first_name = this.user.first_name
         this.last_name = this.user.last_name
         this.mobile = this.user.mobile
         this.email = this.user.email
         this.password = this.user.password
        //  console.log(this.user)
       }).catch((error) => { 
        console.log(error.response.data)
        });
     },
     updateProfile(){
      axios.put('http://localhost:3000/user/updateProfile',{
        first_name: this.first_name,
        last_name: this.last_name,
        mobile: this.mobile,
        email: this.email
      }).then(res => {
         this.first_name = res.data.first_name
         this.last_name = res.data.last_name
         this.mobile = res.data.mobile
         this.email = res.data.email
         this.showEmailModal = true
       }).catch((error) => { 
        console.log(error.response.data)
        });
     }
   }
}
</script>