<template>
  <div class="columns" style="background-color: #f9f7f0">
    <div class="column is-12 pt-6 mr-6">
      <h1 class="is-size-2 has-text-centered has-text-weight-bold">Products</h1>

      <div class="column is-half is-offset-one-quarter mb-3">
        <div class="level">
          <input class="input" type="text" placeholder="ค้นหา" v-model="search"/>
          <button class="button ml-1 has-background-info" @click="getProduct()">ค้นหา</button>
        </div>
      </div>

      <div class="ml-6 mb-3">
        <!-- filter -->
        <label for="plant-select" class="is-size-5 has-text-weight-bold">Filter By Type :</label>
        <select  class="column is-2 is-size-6 has-background-warning-light" name="plants" id="plants" v-model="plant_type">
          <option value="">--Please choose a Type--</option>
          <option value="begonia">begonia</option>
          <option value="orchid">orchid</option>
          <option value="calathea">calathea</option>
          <option value="hoya">hoya</option>
        </select>
      </div>

      <div class="level mr-6 ml-6" >
        <p class="is-size-5 mb-2">All Products ({{ products.length }})</p>
        <div>
          <button v-if="user.role == 'customer'" class="button has-background-link mr-2" @click="modal_cart = !modal_cart">
            Show Cart 
            <!-- Show Cart {{ cart }} -->
          </button>
          <span v-if="user.role == 'customer'" class="button has-background-link-light">{{ cart.length }}</span>
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
            <div class="box" style="background-color: #FFFDDE;">
              <div class="card-image">
                <figure class="image is-1by1">
                  <img
                    :src="imagePath(value.file_path)"
                    alt="Placeholder image"
                  />
                </figure>
              </div>
              <div class="card-content">
                <div class="media">
                  <div class="media-content">
                    <p id="title" class="title is-5">{{ value.plant_name }}</p>
                    <p id="price" class="price is-5 has-text-danger">
                      Price {{ value.plant_price }} Baht
                    </p>
                  </div>
                </div>
              </div>

              <div class="level">
                <div style="justify-content: space-between" class="level-right">
                  <!-- info -->
                    <button class="button" style="background-color: #BCE29E;" @click="ShowInfo(value)">
                      Info
                    </button>
                </div>

                <div class="level-right">
                  <!-- edit -->
                    <button class="button has-background-warning " v-if="user.role == 'seller'">
                      <router-link :to="`/product/edit/${value.plant_id}`"
                        >Edit</router-link
                      >
                    </button>
                </div>

                <div class="level-right">
                  <!-- del -->
                  <button v-if="user.role == 'seller'"
                    class="button has-background-danger "
                    @click="deleteProduct(value.plant_id)"
                  >
                    Del
                  </button>
                </div>

                <div class="level-right" >
                  <!-- add -->
                  <button v-if="user.role == 'customer'"
                    class="button has-background-warning "
                    @click="showComfirm = true, push(value)"
                  >
                    Add
                  </button>
                </div>

                <!-- Modal info-->
                <div class="modal" :class="{ 'is-active': modal_info }">
                  <div class="modal-background"></div>
                  <div class="modal-card" style="max-width: 960px; width: 90%">
                    <header
                      class="modal-card-head has-text-centered" style="background: #FFC074;"
                    >
                      <p class="modal-card-title">รายละเอียดของสินค้า</p>
                      <button
                        class="delete"
                        aria-label="close"
                        @click="modal_info = !modal_info"
                      ></button>
                    </header>
                    <section class="modal-card-body">
                      <p id="title2" class="title">{{ info.plant_name }}</p>
                      <div class="level">
                        <img
                          :src="imagePath(info.file_path)"
                          style="width: 300px; height: 300px"
                        />
                        <p id="info" class="is-4">{{ info.plant_info }}</p>
                      </div>
                    </section>
                  </div>
                </div>

                <!-- Modal Cart-->
                <div class="modal" :class="{ 'is-active': modal_cart }">
                  <div class="modal-background"></div>
                  <div class="modal-card" style="max-width: 960px; width: 50%">
                    <header
                      class="modal-card-head has-background-warning-light"
                    >
                      <p class="modal-card-title">Cart</p>
                      <button
                        class="delete"
                        aria-label="close"
                        @click="modal_cart = !modal_cart"
                      ></button>
                    </header>
                    <section class="modal-card-body">
                      <!-- Column แสดงตะกร้า---->
                      <div class="column is-12 pt-6 pr-5 has-background-primary-light" >
                        <span class="is-size-4 mb-4 has-text-danger">*** กรุณาตรวจสอบสินค้าก่อนทำรายการถัดไป</span>
                        <div style="display: flex; justify-content: space-between">
                          <span class="is-size-4 mb-4">รายการสินค้า</span>
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
                                <!-- picture -->
                                <figure class="image is-96x96">
                                  <img
                                    :src="imagePath(product.file_path)"
                                    alt="Placeholder image"
                                  />
                                </figure>
                              </div>

                              <div class="media-content pt-2">
                                <p class="is-5">{{ product.plant_name }}</p>
                                <div style="   display: flex; justify-content: space-between; ">

                                    <!-- ราคาสินค้า----->
                                    <span class="is-6">{{ product.plant_price }}</span>

                                  <div style=" display: flex; justify-content: space-between;">
                                    <!-- ลดสินค้า--->
                                    <button class="button mr-3" @click="quantityDel(product, index)">-</button>
                                    <!-- จำนวนสินค้า-->
                                    <p>{{ product.quantity }}</p>
                                    <!-- เพิ่มสินค้า-->
                                    <button class="button ml-3" @click="quantityPlus(product, index)">+</button>
                                    <!-- ราคารวม -->
                                    <span class="button ml-3" >{{ product.plant_price * product.quantity}}</span>
                                  </div>

                                    <!-- ลบออกจาก cart--->
                                      <button class="button has-background-danger" @click="removeFromCart(product, index)">Del</button>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div class="level">
                          <span class="has-text-weight-bold">Total</span>
                          <span id="calculateTotalPrice">{{ calculateTotalPrice }}</span>
                        </div>
                        <button class="button has-background-warning mr-4" @click="addItCart()">
                          Go To Cart
                        </button>
                        <button class="button has-background-danger" @click="modal_cart = false"> Cancel</button>

                      </div>
                    </section>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  props: ['user'],
  data() {
    return {
      modal_info: false,
      modal_cart: false,
      info: { id: 0, image: "", detail: "" },
      // plant_type: "",
      products: [],
      search: "",
      cart: [],
      showComfirm: false,
      cusId: null,
      totalPrice: 0,
      quantity: 0,
      cartId: null,
      plant_type:""
    };
  },
  mounted() {
    this.getProduct();
    this.getCusId();
  },
  methods: {
    ShowInfo(value) {
      this.modal_info = !this.modal_info;
      this.info = value;
      console.log(this.info);
    },
    getCusId(){
      axios.get("http://localhost:3000/cusId")
      .then(res =>{
        this.cusId = res.data.cusId.customer_id // 1
        console.log(this.cusId)
      }).catch(err =>{
        console.log(err);
      })
    },
    getProduct() {
      axios.get("http://localhost:3000/product", {
          params: {
            search: this.search,
          },
        })
        .then((response) => {
          this.products = response.data;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    imagePath(file_path) {
      if (file_path) {
        return "http://localhost:3000/" + file_path;
      } else {
        return "https://bulma.io/images/placeholders/640x360.png";
      }
    },
    deleteProduct(plant_id) {
      console.log(plant_id);
      const index = this.products.findIndex((obj) => {
        console.log("num " + obj.plant_id);
        return obj.plant_id === plant_id; //find index แล้วลบออกจาก array
      });
      console.log(index);
      this.products.splice(index, 1);
      axios.delete(`http://localhost:3000/delete/product/${plant_id}`)
        .then((res) => {
          // this.$router.push({ path: "/manageProduct" });
          console.log(res);
        })
        .catch((error) => {
          alert(error);
        });
    },
    addItCart() {
      axios.post(`http://localhost:3000/addPD/tocart/${this.cusId}`, {
          cart: this.cart,
          // cusId : this.cusId,
          totalPrice : this.totalPrice // total price
        })
        .then((response) => {
          this.cartId = response.data.cartId;
          console.log(this.cartId);
          alert('Add Success')
          this.$router.push({path: `/itemsInCart/${this.cartId}`});
        })
        .catch((error) => {
          console.log(error.response)
        });
    },
    push(value) {
      if (value.quantity === 0) {
        this.cart.push(value);
      }
      console.log(this.cart);
      value.quantity++;
    },
    removeFromCart(product, index) {
      this.cart.splice(index, 1);
      product.quantity = 0;
    },
    quantityDel(product, index) {
      product.quantity--;
      if (product.quantity <= 0) {
        this.cart.splice(index, 1);
      }
    },
    quantityPlus(product) {
      product.quantity++;
      console.log(totalPrice)
    }
  },
  computed: {
    calculateTotalPrice() {
      var total = 0;
      for (let i = 0; i < this.cart.length; i++) {
        total += this.cart[i].plant_price * this.cart[i].quantity;
      }
      return total;
    },
    FilterType(){
      return this.products.filter(data => data.plant_type.includes(this.plant_type))
    }
    
  },
  watch: {
    calculateTotalPrice(newTotal) {
      this.totalPrice = newTotal;
      console.log(this.totalPrice)
    }
  }
};
</script>
