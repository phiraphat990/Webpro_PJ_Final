<template >
  <div>
  <div class="container is-fluid mt-6">
    <div class="columns is-centered">
      <div class="column is-4">
        <h1 class="title has-text-centered is-size-1 has-text-weight-bold">Log in</h1>

        <p
          v-if="error"
          class="px-3 py-2 mb-3 has-text-danger-dark has-background-danger-light"
        >
          {{ error }}
        </p>

        <!-- Login form -->
        <div class="field">
          <label class="label">Username</label>
          <div class="control has-icons-left">
            <input v-model="username" class="input" type="text" />
            <span class="icon is-small is-left">
              <i class="fas fa-user"></i>
            </span>
          </div>
        </div>

        <div class="field">
          <label class="label">Password</label>
          <div class="control has-icons-left has-icons-right">
            <input v-model="password" class="input" type="password" />
            <span class="icon is-small is-left">
              <i class="fas fa-lock"></i>
            </span>
            <span class="icon is-small is-right">
              <i class="fas fa-check"></i>
            </span>
          </div>
        </div>

        <!-- <button class="button is-primary is-fullwidth">
          Login
        </button> -->
      <div>
        <p class="has-text-centered mt-1 mb-4">Forgot your password?</p>
      </div>
        
      <div class="has-text-centered">
        <button class="button has-background-success-dark has-text-weight-bold is-rounded" @click="loginCustomer()">
          Login Customer
        </button>
      </div>
      <div class="has-text-centered mt-4">
        <button class="button has-background-success-dark has-text-weight-bold is-rounded" @click="loginSeller()">
          login Seller
        </button>
      </div>

        <p class="my-3">
          Don't have an account yet? <a href="/signup.html">Sign up</a>
        </p>
      </div>
    </div>
  </div>
</div>
</template>

<script>
export default {
  data () {
    return {
      username: '',
      password: '',
      error: ''
    }
  }
}
</script>