<template>
  <div class="columns" style="background-color: #f9f7f0">
    <div class="column"></div>

    <!-- Column แสดงสินค้า----->
    <div class="column is-12 pt-6 mr-6">
      <h1 class="is-size-5 mr-6 mb-2">All Products ({{ products.length }})</h1>

       <!-- filter -->
      <!-- <div class="level">
        <label for="plant-select">Filter By Type</label>
        <select class="mr-6" name="plants" id="plants" v-model="plant_type">
          <option value="">--Please choose a Type--</option>
          <option value="begonia">begonia</option>
          <option value="orchid">orchid</option>
          <option value="calathea">calathea</option>
          <option value="hoya">hoya</option>
        </select>
      </div> -->

      <div>
        <button @click="modal_cart = !modal_cart">Add Product</button>
      </div>
      <div class="container">
        <div class="is-multiline columns is-variable is-2">
          <!-- Card element start here-->
          <div
            id="card_product"
            class="column is-one-quarter"
            v-for="(value, index) in products"
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
                  <!-- edit -->
                  <div >
                    <button class="button has-background-warning is-rounded">
                      Edit
                    </button>
                  </div>
                </div>

                <div class="level-right">
                  <!-- del -->
                  <div @click="removeFromProduct(index)">
                    <button class="button has-background-danger is-rounded">
                      Del
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
          <button
            class="delete"
            aria-label="close"
            @click="modal_info = !modal_info"
          ></button>
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

    <!-- Modal AddProduct-->
    <div class="modal" :class="{ 'is-active': modal_cart }">
      <div class="modal-background"></div>
      <div class="modal-card" style="max-width: 960px; width: 50%">
        <header class="modal-card-head has-background-warning-light">
          <p class="modal-card-title">Add Product</p>
          <button
            class="delete"
            aria-label="close"
            @click="modal_cart = !modal_cart"
          ></button>
        </header>

        <section class="modal-card-body">
          <!-- Column add Product---->
          <div class="column is-12 pt-6 pr-5 has-background-primary-light">
            <div>
              <label for="">Plants Name</label>
              <input
                class="input"
                type="text"
                placeholder="Plants Name"
                v-model="title"
              />
            </div>
            <div>
              <label for="">Plants Info</label>
              <input
                class="input"
                type="text"
                placeholder="Plants Info"
                v-model="detail"
              />
            </div>
            <div>
              <label for="">Plants Price</label>
              <input
                class="input"
                type="text"
                placeholder="Plants Price"
                v-model="price"
              />
            </div>
            <div>
              <label for="">Plants Image</label>
              <input
                class="input"
                type="text"
                placeholder="Plants Image"
                v-model="image"
              />
            </div>
            <div class="mt-3">
              <label for="">Plants Type</label>
              <select class="mr-6" name="plants" id="plants" v-model="type">
              <option value="">--Please choose a Type--</option>
              <option value="begonia">begonia</option>
              <option value="orchid">orchid</option>
              <option value="calathea">calathea</option>
              <option value="hoya">hoya</option>
            </select>
            </div>

            <button class="mt-3" @click="addProduct(title, price, type, detail, image)">Add Products</button>
          </div>
        </section>
      </div>
    </div>
  </div>
</template>


<script>
import products from "../product.json";
export default {
  data() {
    return {
      role: "customer",
      modal_info: false,
      modal_cart: false,
      info: { id: 0, image: "", detail: "" },
      // plant_type: "",
      products: products,
      title:"",
      detail:"",
      price: 0,
      image: "",
      type:""
    };
  },
  methods: {
    removeFromProduct(index) {
      this.products.splice(index, 1);
      console.log(index)
      localStorage.setItem("ManagePD", JSON.stringify(this.products));
    },
    ShowInfo(value) {
      this.modal_info = !this.modal_info;
      this.info = value;
      console.log(this.info);
    },
    addProduct(title, price, type, detail, image){
      this.title = title
      this.price = price
      this.type = type
      this.detail = detail
      this.image = image
      this.products.push({
        title : title, 
        detail: detail,
        price: price,
        image:image,
        type: type
      }
      )
      this.modal_cart = false
      localStorage.setItem("ManagePD", JSON.stringify(this.products));
    }
  },
  computed: {
    // FilterType() {
    //   return this.products.filter((data) =>
    //     data.type.includes(this.plant_type)
    //   );
    // },
  },
  watch: {},
};
</script>
