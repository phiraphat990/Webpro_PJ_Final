<!-- eslint-disable vue/multi-word-component-names -->
<template>
  <div class="container is-widescreen">
    <h1 class="is-size-2 has-text-centered has-text-weight-bold mt-6">Carts</h1>
    <section>
      <div class="column">
        <!-- card cart component แสดงข้อมูลที่อยู่ใน Localstorage ----->
        <div class="card mb-4">
          <!-- <button class="button " @click="backHome()">Back</button> -->
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
                      class="mr-5"
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

      <div class="columns is-size-4">
        <div class="column is-1 is-offset-8">Total</div>
        <div class="column is-3 has-text-right">
          <!-- Total here ---- -->
          {{ this.cart[0].total_price }}
        </div>
      </div>
    </section>

    <section>
      <!-- ที่อยู่ -->
      <div class="feild">
        <label class="label is-size-4 has-text-link">ที่อยู่ผู้รับ :</label>
        <textarea
          class="textarea"
          :class="{ 'is-danger': $v.address.$error }"
          placeholder="Ex. บ้านเลขที่ 5 ต.จอมบึง อ.จอมบึง จ.ราชบุรี 70150"
          v-model="$v.address.$model"
        ></textarea>

        <template v-if="$v.address.$error">
          <p class="help is-danger" v-if="!$v.address.required">
            This field is required
          </p>
          <p class="help is-danger" v-if="!$v.address.minLength">
            Must be at least 5 characters
          </p>
        </template>
      </div>

      <!-- <button class="button mt-3 mr-6" style="background-color: #FF9494 ;">
        Back to product
      </button> -->
      <button
        class="button mt-3 mb-6"
        style="background-color: #bce29e"
        @click="modal_confirm = !modal_confirm"
      >
        Payment
      </button>

      <!-- Modal confirm-->
      <div class="modal" :class="{ 'is-active': modal_confirm }">
        <div class="modal-background"></div>
        <div class="modal-card" style="max-width: 960px; width: 50%">
          <header
            class="modal-card-head has-text-centered has-text-weight-semibold"
            style="background: #ffc074"
          >
            <label class="modal-card-title">ยืนยันการซื้อสินค้า</label>
            <button
              class="delete"
              aria-label="close"
              @click="modal_confirm = !modal_confirm"
            ></button>
          </header>

          <section class="modal-card-body">
            <label
              id="info"
              class="is-4 has-text-link is-size-5 has-text-weight-semibold"
              >รายละเอียดผู้รับ :
            </label>
            <p class="has-text-weight-semibold">{{ address }}</p>

            <p
              class="is-4 has-text-link mt-5 is-size-5 has-text-weight-semibold"
            >
              รายการสินค้า :
            </p>
            <table class="table is-striped" style="width: 100%">
              <tr>
                <th>ชื่อสินค้า</th>
                <th>จำนวน</th>
              </tr>
              <tr v-for="(value, index) in cart" :key="index">
                <td>{{ value.plant_name }}</td>
                <td>
                  <p>{{ value.amount }}</p>
                </td>
              </tr>
            </table>
            <label
              for=""
              class="has-text-link mt-5 is-size-5 has-text-weight-semibold"
              >อัปโหลดหลักฐานการชำระเงิน :</label
            >
            <!-- โชว์รูป -->
            <div class="columns is-multiline">
              <div
                v-for="(image, index) in slip_image"
                :key="image.id"
                class="column is-one-quarter"
              >
                <div class="card">
                  <div class="card-image">
                    <figure class="image is-4by3">
                      <img
                        :src="showSelectImage(image)"
                        alt="Placeholder image"
                      />
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
            <!-- เลือกรูป -->
            <input
              class="input mb-5 mt-2"
              placeholder="Slip Image"
              multiple
              type="file"
              accept="image/png, image/jpeg, image/webp"
              @change="selectImages"
            />

            <button
              class="button has-background-warning mr-6"
              @click="confirmOrder()"
            >
              Confirm
            </button>
            <button
              class="button has-background-danger"
              @click="modal_confirm = false"
            >
              Cancel
            </button>
          </section>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
import axios from "axios";
import { required, minLength } from "vuelidate/lib/validators";

export default {
  data() {
    return {
      cart: [],
      address: "",
      modal_confirm: false,
      slip_image: [], //array picture
    };
  },
  mounted() {
    this.getCartItem(this.$route.params.id);
    this.confirmOrder();
  },
  methods: {
    selectImages(event) {
      this.slip_image = event.target.files;
    },
    showSelectImage(image) {
      // for preview only
      return URL.createObjectURL(image);
    },
    deleteSelectImage(index) {
      console.log(this.slip_image);
      this.slip_image = Array.from(this.slip_image);
      this.slip_image.splice(index, 1);
    },
    imagePath(file_path) {
      if (file_path) {
        return "http://localhost:3000/" + file_path;
      } else {
        return "https://bulma.io/images/placeholders/640x360.png";
      }
    },
    getCartItem(cartId) {
      axios
        .get(`http://localhost:3000/itemsInCart/${cartId}`)
        .then((response) => {
          this.cart = response.data;
          console.log(this.cart);
          // console.log(this.plant_image)
        })
        .catch((err) => {
          console.log(err);
        });
    },
    confirmOrder() {
      let formData = new FormData();
      formData.append("cartId", this.cart[0].cart_id);
      formData.append("cusId", this.cart[0].customer_id);
      formData.append("address", this.address);
      this.slip_image.forEach((image) => {
        formData.append("myImage", image);
      });
      console.log(formData);

      axios
        .post(`http://localhost:3000/confirm/order`, formData)
        .then((response) => {
          alert("Add Success");
          this.$router.push({ path: "/manageProduct" });
          this.modal_confirm = false;
        })
        .catch((error) => {
          console.log(error.response);
        });
    },
  },
  validations: {
    address: {
      required: required,
      minLength: minLength(5),
    },
  },
};
</script>
