<template>
    <div class="container is-widescreen">
    <!-- Edit Product----->
      <h1 class="is-size-2 has-text-centered has-text-weight-bold mt-6">Edit Products</h1>

        <label class="label is-size-5 has-text-weight-semibold mt-3">Plants Name :</label>
        <input
          class="input mt-3"
          type="text"
          placeholder="Plants Name"
          v-model="plant_name"
        />

        <label class="label is-size-5 has-text-weight-semibold mt-3">Plants Info :</label>
        <textarea 
        class="textarea mt-3"
          type="text"
          placeholder="Plants Info"
          v-model="plant_info">
        </textarea>

        <label class="label is-size-5 has-text-weight-semibold mt-3">Plants Price :</label>
        <input
          class="input mt-3"
          type="text"
          placeholder="Plants Price"
          v-model="plant_price"
        />


            <div class="column is-4 is-offset-4">
                  <img 
                  :src="plant_image ? 'http://localhost:3000' + plant_image : 'https://bulma.io/images/placeholders/640x360.png'"
                />        
            </div>

        <label class="label is-size-5 has-text-weight-semibold mt-3">Plants Image :</label>
        <input
          class="input mt-3"
          placeholder="Plants Image"
          multiple
          type="file"
          accept="image/png, image/jpeg, image/webp"
        />
  
        <div class="mt-6 mb-6">
        <label class="label is-size-5 has-text-weight-semibold">Plants Type :</label>
        <select class="column is-3 is-size-6 " name="plants" id="plants" v-model="plant_type">
          <option value="">--Please choose a Type--</option>
          <option value="begonia">begonia</option>
          <option value="orchid">orchid</option>
          <option value="calathea">calathea</option>
          <option value="hoya">hoya</option>
        </select>
      </div>
    <div class="mb-6">
      <button class="button mt-3 mr-6 " style="background-color: #FF9494 ;" >
        <router-link class="card-footer-item" to="/manageProduct">Back To Products</router-link></button>
      <button class="button mt-3" style="background-color: #BCE29E ;" @click="addProduct">Add Products</button>
    </div>
  </div>
  </template>
    
    
    <script>
  import axios from "axios";
  export default {
    data() {
      return {
        plant_name: "",
        plant_info: "",
        plant_price: 0,
        plant_image: "",
        plant_type: "",
        search: "",
        products: "",
      };
    },
    mounted() {
    //   this.addProduct();
      this.getProductbyID();
    },
    methods: {
    //   addProduct() {
    //     let formData = new FormData();
    //     formData.append("plant_name", this.plant_name);
    //     formData.append("plant_info", this.plant_info);
    //     formData.append("plant_price", this.plant_price);
    //     formData.append("plant_type", this.plant_type);
    //     this.plant_image.forEach((image) => {
    //       formData.append("myImage", image);
    //     });
    //     // Note ***************
    //     // ตอนเรายิง Postmant จะใช้ fromData
    //     // ตอนยิงหลาย ๆ รูปพร้อมกันใน Postman จะเป็นแบบนี้
  
    //     // title   | "This is a title of blog"
    //     // comment | "comment in blog"
    //     // ...
    //     // myImage | [select file 1]
    //     // myImage | [select file 2]
    //     // myImage | [select file 3]
  
    //     // จะสังเกตุว่าใช้ myImage เป็น key เดียวกัน เลยต้องเอามา loop forEach
    //     // พอไปฝั่ง backend มันจะจัด file ให้เป็น Array เพื่อเอาไปใช้งานต่อได้
  
    //     axios
    //       .post("http://localhost:3000/add/product", formData)
    //       .then(
    //         (res) => this.$router.push({ path: "/manageProduct" }),
    //         (this.modal_cart = false)
    //       )
    //       .catch((e) => console.log(e.response.data));
    //   },
    //   imagePath(file_path) {
    //     if (file_path) {
    //       return "http://localhost:3000/" + file_path;
    //     } else {
    //       return "https://bulma.io/images/placeholders/640x360.png";
    //     }
    //   },
      getProductbyID(){
      axios.get(`http://localhost:3000/product/${this.$route.params.id}`)
        .then((response) => {
          this.products = response.data.plants;
          this.plant_name = this.products.plant_name;
          this.plant_info = this.products.plant_info;
          this.plant_price = this.products.plant_price;
          this.plant_type = this.products.plant_type;
          this.plant_image = response.data.plant_image;
          console.log(this.products)
          console.log(this.plant_image)
        })
        .catch((err) => {
          console.log(err);
        });
    }
    },
  };
  </script>