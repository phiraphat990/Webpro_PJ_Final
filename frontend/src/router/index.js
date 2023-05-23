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
    meta: { login: true },
    component: () => import('../views/blogs/CreateBlog.vue')
  },
  {
    path: '/blogs/update/:id',
    name: 'update-blog',
    meta: { login: true },
    component: () => import('../views/blogs/UpdateBlog.vue')
  },
  {
    path: '/user/signup',
    name: 'signup',
    meta: { guess: true },
    component: () => import('../views/Signup.vue')
  },
  {
    path: '/user/login',
    name: 'login',
    meta: { guess: true },
    component: () => import('../views/Login.vue')
  },
  //ใหม่
  {
      path: '/manageProduct',
      name: 'Manageproduct',
      meta: { login: true },
      component: () => import('../views/product/ManageProduct.vue') // set home as path '/'
  },
  {
      path: '/user/manage',
      name: 'ManageAccount',
      component: () => import('../views/ManageAccount.vue') // set home as path '/'
  }
  ,
  {
      path: '/product/add',
      name: 'addProduct',
      component: () => import('../views/product/addProduct.vue') // set home as path '/'
  }
  ,
  {
      path: '/product/edit/:id',
      name: 'editProduct',
      component: () => import('../views/product/editProduct.vue') // set home as path '/'
  },
  {
    path: '/payment',
    name: 'Payment',
    component: () => import('../views/product/Payment.vue') // set home as path '/'
  },
  {
    path: '/itemsInCart/:id',
    name: 'itemsInCart',
    component: () => import('../views/product/Cart.vue') // set home as path '/'
  },
  {
    path: '/mainblog',
    name: 'Mainblog',
    component: () => import('../views/blogs/MainBlog.vue') // set home as path '/'
  },
  {
    path: '/checkorder',
    name: 'CheckOrder',
    component: () => import('../views/product/CheckOrder.vue') // set home as path '/'
  }
]

const router = new VueRouter({ routes })

router.beforeEach((to, from, next) => {
    const isLoggedIn = !!localStorage.getItem('token')
  
    if (to.meta.login && !isLoggedIn) {
      alert('Please login first!')
      next({ path: '/user/login' })
    }
  
    if (to.meta.guess && isLoggedIn) {
      alert("You've already logged in")
      next({ path: '/'})
    }
  
    next()
  })

export default router
