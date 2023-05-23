<template>
    <div class="container is-widescreen mt-6">
    <h1 class="is-size-2 has-text-centered has-text-weight-bold">Check Order</h1>
      <!-- Filter -->
      <h1 class="ml-6 is-size-5">Filter by Status</h1>
      <select name="" id="" class="ml-6" v-model="paid_status">
        <option value="">--------Status of Payment--------</option>
        <option value="unpaid">unpaid</option>
        <option value="approved_bill">approved_bill</option>
      </select>
      <section class="column mt-3 ml-6 mr-6">
        <div>
          <table class="table table is-striped" style="width: 100%">
            <tr>
              <th>Cart ID</th>
              <th>First Name</th>
              <th>Last Name</th>
              <th>Phone Number</th>
              <th>Pay Status</th>
              <th>Details</th>
            </tr>
            <tr
              v-for="(orderInfo, index) in FilterStatus"
              :key="index"
              :class="[
                orderInfo.status == 'unpaid'
                  ? 'has-background-danger'
                  : 'has-background-success',
              ]"
            >
              <td>{{ orderInfo.cart_id }}</td>
              <td>{{ orderInfo.first_name }}</td>
              <td>{{ orderInfo.last_name }}</td>
              <td>{{ orderInfo.mobile }}</td>
              <td>{{ orderInfo.status }}</td>
              <td><button class="button" @click="Check(orderInfo)">Check details</button></td>
            </tr>
          </table>
        </div>
      </section>
  
      <!-- Modal detials-->
      <div class="modal" :class="{ 'is-active': modal_detials }">
        <div class="modal-background"></div>
        <div class="modal-card">
          <header class="modal-card-head has-background-primary-light">
            <p class="modal-card-title">Detials</p>
            <button
              class="delete"
              aria-label="close"
              @click="modal_detials = !modal_detials"
            ></button>
          </header>
          <section class="modal-card-body">
            <div class="content">
              <span>Cart ID : {{ detail.cart_id }}</span><br />
              <span>Product Name : {{ detail.plant_name }}</span><br />
              <span>Quantity : {{ detail.amount }}</span><br />
              <span>Total Price : {{ detail.total_price }}</span><br />
              <span>Address : {{ detail.address }}</span><br />
            </div>
          </section>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  import axios from 'axios';
  export default {
    data() {
      return {
        detail: { cart_id: "", amount: "", total_price: "", address: ""   },
        modal_detials: false,
        paid_status:'',
        order: []
      };
    },
    mounted() {
        this.getallOrder();
    },
    methods: {
      Check(orderInfo) {
        this.detail = orderInfo;
        this.modal_detials = true;
        console.log(this.detail);
      },
      getallOrder() {
      axios.get("http://localhost:3000/allorder")
        .then((response) => {
          this.order = response.data;
        })
        .catch((err) => {
          console.log(err);
        });
    }
    },
    computed:{
      FilterStatus(){
        return this.order.filter(data => data.status.includes(this.paid_status))
      }
    }
  };
  </script>
  
  <style>
  </style>