<!-- eslint-disable vue/multi-word-component-names -->
<template>
    <div>
      <h1 class="is-size-2 has-text-centered has-text-weight-bold mt-6">Carts</h1>
      <div class="section">
        <div class="column">
          <!-- card cart component แสดงข้อมูลที่อยู่ใน Localstorage ----->
          <div class="card mb-4">
            <button class="button " @click="backHome()">Back</button>
            <div class="card-content p-0">
              <div class="media">
                <table class="table is-striped ml-6 mr-6" style="width: 100%">
                  <tr>
                    <th>Item</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                  </tr>
  
                  <tr v-for="(product, index) in cart" :key="index">
                    <td>
                      <img
                      :src="imagePath(product.file_path)"
                        style="width: 120px; height: 120px"
                      />
                      {{ product.plant_name }}
                    </td>
                    <td>{{ product.plant_price }}</td>
                    <td>
                      <div style="display: flex; justify-content: space-between">
                        <!-- ลดสินค้า-
                        <button @click="quantityDel(product, index)">-</button>
                        จำนวนสินค้า- -->
                        <p>{{ product.amount }}</p>
                        <!-- เพิ่มสินค้า-
                        <button @click="quantityPlus(product)">+</button> -->
                      </div>
                    </td>
                    <td>{{ product.total_unit_price }}</td>
                  </tr>
                </table>
              </div>
            </div>
          </div>
        </div>
  
        <div class="columns is-size-4" >
          <div class="column is-1 is-offset-8">Total</div>
          <div class="column is-3 has-text-right">
            <!-- Total here ---- -->
            {{ this.cart[0].total_price }}
          </div>
        </div>
  
        <!-- ที่อยู่ -->
        <h1 class="is-size-4">User Info</h1>
        <div class="columns">
          <div class="column">
            <label class="label">ชื่อผู้รับ - ที่อยู่</label>
            <textarea
              class="textarea"
              placeholder="ชื่อ - นามสกุล ที่อยู่..............."
              v-model="userInfo"
            ></textarea>
            <p></p>
          </div>
        </div>
        <br />
  
        <button @click="(modal_confirm = !modal_confirm), info.push(userInfo)">
          Check out
        </button>
  
        <!-- Modal confirm-->
        <div class="modal" :class="{ 'is-active': modal_confirm }">
          <div class="modal-background"></div>
          <div class="modal-card" style="max-width: 960px; width: 50%">
            <header class="modal-card-head has-background-primary-light">
              <p class="modal-card-title">Confirm</p>
              <button
                class="delete"
                aria-label="close"
                @click="modal_confirm = !modal_confirm"
              ></button>
            </header>
            <section
              class="modal-card-body"
              v-for="(infomation, index) in info"
              :key="index"
            >
              <p id="info" class="is-4 has-text-link">รายละเอียดผู้รับ</p>
              <p>{{ infomation }}</p>
  
              <p class="is-4 has-text-link">รายการสินค้า</p>
              <div class="level" v-for="(value, index) in cart" :key="index">
                <p>{{ value.title }}</p>
                <p class="is-4">จำนวน</p>
                <p>{{ value.quantity }}</p>
              </div>
  
              <input type="file" name="slip" />
              <button @click="(modal_confirm = false), index">Cancel</button>
              <button @click="Confirm()">
                <router-link to="/allProduct"> Confirm</router-link>
              </button>
            </section>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  import axios from 'axios';
  export default {
    data() {
      return {
        cart: [],
        userInfo: "",
        modal_confirm: false,
        info: "",
      };
    },
    mounted() {
      // this.cart = JSON.parse(localStorage.getItem("CartItem"));
      this.getCartItem(this.$route.params.id);
    },
    methods: {
      quantityDel(product, index) {
        product.quantity--;
        if (product.quantity <= 0) {
          product.quantity = 0;
          this.cart.splice(index, 1);
        }
        // localStorage.setItem("CartItem", JSON.stringify(this.cart));
      },
      quantityPlus(product) {
        product.quantity++;
        // localStorage.setItem("CartItem", JSON.stringify(this.cart));
      },
      Confirm() {
        this.modal_confirm = false;
        // localStorage.setItem("Confirm", JSON.stringify(this.));
        // this.cart = []
        // localStorage.setItem("allOrder", JSON.stringify(this.cart, this.info));
      },
      imagePath(file_path) {
        if (file_path) {
          return "http://localhost:3000/" + file_path;
        } else {
          return "https://bulma.io/images/placeholders/640x360.png";
        }
      },
      backHome(){
        // localStorage.setItem("CartItem", JSON.stringify(this.cart));
        this.$router.push({ path: "/manageProduct" });
      },
      getCartItem(cartId){
        axios.get(`http://localhost:3000/itemsInCart/${cartId}`)
          .then((response) => {
            this.cart = response.data;
            console.log(this.cart)
            // console.log(this.plant_image)
          })
          .catch((err) => {
            console.log(err);
          });
      }
    },
    // computed: {
    //   Total() {
    //     var cost = 0;
    //     for (let i = 0; i < this.cart.length; i++) {
    //       cost += this.cart[i].plant_price * this.cart[i].quantity;
    //     }
    //     return cost;
    //   },
    // },
    // watch: {
    //   modal_confirm(index) {
    //     if (this.modal_confirm == false) {
    //       this.info.splice(index, 1);
    //     }
    //   },
    // },
  };
  </script>
  
  <style>
  </style>