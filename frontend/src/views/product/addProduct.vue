<template>
  <div class="container is-widescreen">
    <!-- ADD Product----->
      <h1 class="is-size-2 has-text-centered has-text-weight-bold mt-6">Add Products</h1>

      <div class="field">
        <label class="label is-size-5 has-text-weight-semibold mt-3">Plants Name :</label>
        <input
          class="input mt-3"
          :class="{ 'is-danger': $v.plant_name.$error }"
          type="text"
          placeholder="Plants Name"
          v-model="$v.plant_name.$model"
        />
        <template v-if="$v.plant_name.$error">
              <p class="help is-danger" v-if="!$v.plant_name.required">
                This field is required
              </p>
              <p class="help is-danger" v-if="!$v.plant_name.minLength">
                Must be at least 5 characters
              </p>
        </template>
      </div>

      <div class="field">
        <label class="label is-size-5 has-text-weight-semibold mt-3">Plants Info :</label>
        <textarea 
          class="textarea mt-3"
          :class="{ 'is-danger': $v.plant_info.$error }"
          type="text"
          placeholder="Plants Info"
          v-model="$v.plant_info.$model">
        </textarea>
        <template v-if="$v.plant_info.$error">
              <p class="help is-danger" v-if="!$v.plant_info.required">
                This field is required
              </p>
              <p class="help is-danger" v-if="!$v.plant_info.minLength">
                Must be at least 20 characters
              </p>
              <p class="help is-danger" v-if="!$v.plant_info.maxLength">
                Must be at more than 200 characters
              </p>
        </template>
      </div>
        

      <div class="field">
        <label class="label is-size-5 has-text-weight-semibold mt-3">Plants Price :</label>
        <input
          class="input mt-3"
          :class="{ 'is-danger': $v.plant_price.$error }"
          type="text"
          placeholder="Plants Price"
          v-model="$v.plant_price.$model"
        />
        <template v-if="$v.plant_price.$error">
              <p class="help is-danger" v-if="!$v.plant_price.required">
                This field is required
              </p>
        </template>
      </div>

      <div class="feild">
        <label class="label is-size-5 has-text-weight-semibold mt-3">Plants Image :</label>
        <input
          class="input mt-3"
          :class="{ 'is-danger': $v.plant_image.$error }"
          placeholder="Plants Image"
          multiple
          type="file"
          accept="image/png, image/jpeg, image/webp"
          @change="selectImages"
        />
        <template v-if="$v.plant_image.$error">
              <p class="help is-danger" v-if="!$v.plant_image.required">
                This field is required
              </p>
        </template>
      </div>

        <div class="columns is-multiline mt-3">
          <div
            v-for="(image, index) in plant_image"
            :key="image.index"
            class="column is-one-quarter"
          >
            <div class="card">
              <div class="card-image">
                <figure class="image is-4by3">
                  <img :src="showSelectImage(image)" alt="Placeholder image" />
                </figure>
              </div>
              <footer class="card-footer">
                <a
                  @click="deleteSelectImage(index)"
                  class="card-footer-item has-text-danger"
                  >Delete</a
                >
              </footer>
            </div>
          </div>
        </div>

        <div class="feild">
          <div class="mt-6 mb-6">
        <label class="label is-size-5 has-text-weight-semibold">Plants Type :</label>
        <select 
        class="column is-3 is-size-6 " 
        :class="{ 'is-danger': $v.plant_type.$error }"
        name="plants" id="plants" 
        v-model="$v.plant_type.$model">
          <option value="">--Please choose a Type--</option>
          <option value="begonia">begonia</option>
          <option value="orchid">orchid</option>
          <option value="calathea">calathea</option>
          <option value="hoya">hoya</option>
        </select>
        <template v-if="$v.plant_type.$error">
              <p class="help is-danger" v-if="!$v.plant_type.required">
                This field is required
              </p>
        </template>
      </div>
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
import {
  required,
  minLength,
  maxLength,
} from "vuelidate/lib/validators";

export default {
  data() {
    return {
      plant_name: "",
      plant_info: "",
      plant_price: 0,
      plant_image: [], //array of image
      plant_type: "",
      search: "",
    };
  },
  mounted() {
    this.addProduct();
  },
  methods: {
    selectImages(event) {
      this.plant_image = event.target.files;
    },
    showSelectImage(image) {
      // for preview only
      return URL.createObjectURL(image);
    },
    deleteSelectImage(index) {
      console.log(this.plant_image);
      this.plant_image = Array.from(this.plant_image);
      this.plant_image.splice(index, 1);
    },
    addProduct() {
      let formData = new FormData();
      formData.append("plant_name", this.plant_name);
      formData.append("plant_info", this.plant_info);
      formData.append("plant_price", this.plant_price);
      formData.append("plant_type", this.plant_type);
      this.plant_image.forEach((image) => {
        formData.append("myImage", image);
      });
      // Note ***************
      // ตอนเรายิง Postmant จะใช้ fromData
      // ตอนยิงหลาย ๆ รูปพร้อมกันใน Postman จะเป็นแบบนี้

      // title   | "This is a title of blog"
      // comment | "comment in blog"
      // ...
      // myImage | [select file 1]
      // myImage | [select file 2]
      // myImage | [select file 3]

      // จะสังเกตุว่าใช้ myImage เป็น key เดียวกัน เลยต้องเอามา loop forEach
      // พอไปฝั่ง backend มันจะจัด file ให้เป็น Array เพื่อเอาไปใช้งานต่อได้

      axios
        .post("http://localhost:3000/add/product", formData)
        .then( (res) => {
          alert('Add Success')
          this.$router.push({ path: "/manageProduct" })
          this.modal_cart = false
        }
        )
        .catch((e) => console.log(e.response.data));
    },
    // imagePath(file_path) {
    //   if (file_path) {
    //     return "http://localhost:3000/" + file_path;
    //   } else {
    //     return "https://bulma.io/images/placeholders/640x360.png";
    //   }
    // },
  },
  validations: {
    plant_name: {
      required: required,
      minLength: minLength(5),
    },
    plant_info: {
      required: required,
      minLength: minLength(20),
      maxLength: maxLength(200),
    },
    plant_price: {
      required: required,
    },
    plant_image: {
      required: required,
    },
    plant_type: {
      required: required,
    }
  },
};
</script>