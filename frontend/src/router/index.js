import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'home',
    component: () => import('../views/Home.vue')
  },
  {
    path: '/blogs/detail/:id',
    name: 'detail',
    component: () => import('../views/blogs/DetailBlog.vue')
  },
  {
    path: '/blogs/create',
    name: 'create-blog',
    component: () => import('../views/blogs/CreateBlog.vue')
  },
  {
    path: '/blogs/update/:id',
    name: 'update-blog',
    component: () => import('../views/blogs/UpdateBlog.vue')
  },
  {
    path: '/user/signup',
    name: 'signup',
    component: () => import('../views/Signup.vue')
  },
  {
    path: '/user/login',
    name: 'login',
    component: () => import('../views/Login.vue')
  },
  {
      path: '/allProduct',
      name: 'AllProduct',
      component: () => import('../views/product/AllProduct.vue') // set home as path '/'
  },
  {
      path: '/manageProduct',
      name: 'Manageproduct',
      component: () => import('../views/product/ManageProduct.vue') // set home as path '/'
  }
]

const router = new VueRouter({ routes })

export default router
