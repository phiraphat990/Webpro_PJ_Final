<template>
  <div class="columns" style="background-color: #f9f7f0">
    <!-- Column แสดงสินค้า-------->
    <div class="column is-12 pt-6 mr-6">
      <h1 class="is-size-2 has-text-centered has-text-weight-bold">Products</h1>
      
      <div class="column is-half is-offset-one-quarter mb-3">
        <div class="level">
          <input
            class="input"
            type="text"
            placeholder="ค้นหา"
            v-model="projectSearch"
          />
          <button class="button ml-1 has-background-info">ค้นหา</button>
        </div>
      </div>

      <div class="ml-6 mb-3 ">
         <!-- filter -->
        <label for="plant-select" class="is-size-5 has-text-weight-bold">Filter By Type :</label>
        <select class="column is-2 is-size-6 has-background-warning-light" name="plants" id="plants" v-model="plant_type">
          <option value="">--Please choose a Type--</option>
          <option value="begonia">begonia</option>
          <option value="orchid">orchid</option>
          <option value="calathea">calathea</option>
          <option value="hoya">hoya</option>
        </select>
      </div>

      <div class="level mr-6 ml-6">
          <p class="is-size-5 mb-2">All Products ({{ products.length }})</p>
          <div>
            <button @click="modal_cart = !modal_cart">
              Show Cart {{ cart.length }}
            </button>
          </div>
        </div>


      <div class="container">
        <div class="is-multiline columns is-variable is-2">
          <!-- Card element start here-->
          <div
            id="card_product"
            class="column is-one-quarter"
            v-for="(value, index) in FilterType"
            :key="index"
          >
            <div class="box">
              <div class="card-image">
                <figure class="image is-1by1">
                  <img :src="value.image" alt="Placeholder image" />
                </figure>
              </div>
              <div class="card-content">
                <div class="media">
                  <div class="media-content">
                    <p id="title" class="title is-5">{{ value.title }}</p>
                    <p id="price" class="price is-5 has-text-danger">
                      Price {{ value.price }} Baht
                    </p>
                  </div>
                </div>
              </div>

              <div class="level">
                <div style="justify-content: space-between" class="level-right">
                  <!-- info -->
                  <div @click="ShowInfo(value)">
                    <button class="button has-background-info is-rounded">
                      Info
                    </button>
                  </div>
                </div>

                <div class="level-right">
                  <!-- add -->
                  <div @click="push(value)">
                    <button class="button has-background-warning is-rounded">
                      Add
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal info-->
    <div class="modal" :class="{ 'is-active': modal_info }">
      <div class="modal-background"></div>
      <div class="modal-card" style="max-width: 960px; width: 90%">
        <header class="modal-card-head has-background-info-light">
              <p class="modal-card-title">Infomation</p>
              <button class="delete" aria-label="close" @click="modal_info = !modal_info"></button>
            </header>
        <section class="modal-card-body">
          <p id="title2" class="title">{{ info.title }}</p>
          <div class="level">
            <img :src="info.image" style="width: 300px; height: 300px" />
            <p id="info" class="is-4">{{ info.detail }}</p>
          </div>
        </section>
      </div>
    </div>

    <!-- Modal Cart-->
    <div class="modal" :class="{ 'is-active': modal_cart }">
      <div class="modal-background"></div>
      <div class="modal-card" style="max-width: 960px; width: 50%">
        <header class="modal-card-head has-background-warning-light">
              <p class="modal-card-title">Cart</p>
              <button class="delete" aria-label="close" @click="modal_cart = !modal_cart"></button>
            </header>
        <section class="modal-card-body">
          <!-- Column แสดงตะกร้า---->
          <div class="column is-12 pt-6 pr-5 has-background-primary-light">
            <div style="display: flex; justify-content: space-between">
              <span class="is-size-4 mb-4">Cart ({{ cart.length }})</span>
              <!-- <a class="is-danger mb-4 button" @click="Clear()">Clear</a> -->
            </div>

            <!-- Card element start here-->
            <div
              v-for="(product, index) in cart"
              :key="index"
              class="card mb-4"
            >
              <div class="card-content p-0">
                <div class="media">
                  <div class="media-left">
                    <figure class="image is-96x96">
                      <img :src="product.image" alt="Placeholder image" />
                    </figure>
                  </div>
                  <div class="media-content pt-2">
                    <p class="is-5">{{ product.title }}</p>
                    <div style="display: flex; justify-content: space-between">
                      <div>
                        <!-- ราคาสินค้า----->
                        <span class="is-6">{{ product.price }}</span>
                      </div>
                      <div
                        style="display: flex; justify-content: space-between"
                      >
                        <!-- ลดสินค้า--->
                        <button @click="quantityDel(product, index)">-</button>
                        <!-- จำนวนสินค้า-->
                        <p>{{ product.quantity }}</p>
                        <!-- เพิ่มสินค้า-->
                        <button @click="quantityPlus(product)">+</button>
                        <span>{{ product.price * product.quantity }}</span>
                      </div>
                      <div>
                        <!-- ลบออกจาก cart--->
                        <span
                          class="icon mr-2"
                          key="false"
                          @click="removeFromCart(index, product)"
                        >
                          <button>del</button>
                        </span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="level">
              <span class="has-text-weight-bold">Total</span>
              <span id="totalPrice">{{ totalPrice }}</span>
            </div>
            <button @click="gotoPay()">
              <router-link to="/payment" class="has-text-black"
                >go to PayMent</router-link
              >
            </button>
          </div>
        </section>
      </div>
    </div>
  </div>
</template>


<script>
import products from '../product.json'
export default {
  data() {
    return {
      role: "customer",
      cart: [],
      show_modal: false,
      modal_info: false,
      modal_cart: false,
      info: { id: 0, image: "", detail: "" },
      plant_type:'',
      products: products,
    };
  },
  methods: {
    push(value) {
      if (value.quantity === 0) {
        this.cart.push(value);
      }
      // console.log(this.cart)
      value.quantity++;
    },
    removeFromCart(index, product) {
      this.cart.splice(index, 1);
      product.quantity = 0;
    },
    ShowInfo(value) {
      this.modal_info = !this.modal_info;
      this.info = value;
      console.log(this.info)
    },
    gotoPay() {
      localStorage.setItem("allCart", JSON.stringify(this.cart));
    },
    quantityDel(product, index) {
      product.quantity--;
      if (product.quantity <= 0) {
        this.cart.splice(index, 1);
      }
    },
    quantityPlus(product) {
      product.quantity++;
    },
    // Clear(){
    //   this.cart = []
      
    // }
  },
  created() {
    this.products = JSON.parse(localStorage.getItem("ManagePD"));
  },
  computed: {
    totalPrice() {
      var total = 0;
      for (let i = 0; i < this.cart.length; i++) {
        total += this.cart[i].price * this.cart[i].quantity;
      }
      return total;
    },
    FilterType(){
      return this.products.filter(data => data.type.includes(this.plant_type))
    }
  },
  watch:{
  }
};
</script>
