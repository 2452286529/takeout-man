import Vue from "vue";
import Router from "vue-router";

Vue.use(Router);

/* Layout */
import Layout from "@/layout";

/**
 * Note: sub-menu only appear when route children.length >= 1
 * Detail see: https://panjiachen.github.io/vue-element-admin-site/guide/essentials/router-and-nav.html
 *
 * hidden: true                   if set true, item will not show in the sidebar(default is false)
 * alwaysShow: true               if set true, will always show the root menu
 *                                if not set alwaysShow, when item has more than one children route,
 *                                it will becomes nested mode, otherwise not show the root menu
 * redirect: noRedirect           if set noRedirect will no redirect in the breadcrumb
 * name:'router-name'             the name is used by <keep-alive> (must set!!!)
 * meta : {
    roles: ['admin','editor']    control the page roles (you can set multiple roles)
    title: 'title'               the name show in sidebar and breadcrumb (recommend set)
    icon: 'svg-name'/'el-icon-x' the icon show in the sidebar
    breadcrumb: false            if set false, the item will hidden in breadcrumb(default is true)
    activeMenu: '/example/list'  if set path, the sidebar will highlight the path you set
  }
 */

/**
 * constantRoutes
 * a base page that does not have permission requirements
 * all roles can be accessed
 */
export const constantRoutes = [
  {
    path: "/login",
    component: () => import("@/views/login/index"),
    hidden: true,
  },

  {
    path: "/404",
    component: () => import("@/views/404"),
    hidden: true,
  },

  {
    path: "/",
    component: Layout,
    redirect: "/dashboard",
    children: [
      {
        path: "dashboard",
        name: "Dashboard",
        component: () => import("@/views/dashboard/index"),
        meta: { title: "校园在线订餐系统后台", icon: "dashboard", affix: true },
      },
    ],
  },

  {
    path: "/user",
    component: Layout,
    redirect: "/user/customer",
    name: "userManage",
    meta: { title: "用户管理", icon: "el-icon-s-help" },
    children: [
      {
        path: "customer",
        name: "customer",
        component: () => import("@/views/user/customer"),
        meta: { title: "用户列表", icon: "table" },
      },
      {
        path: "",
        name: "",
      },
    ],
  },
  {
    path: "/product",
    component: Layout,
    redirect: "/product/product",
    name: "productManage",
    meta: { title: "商品管理", icon: "el-icon-s-help" },
    children: [
      {
        path: "category",
        name: "category",
        component: () => import("@/views/product/category"),
        meta: { title: "商品分类管理", icon: "table" },
      },
      {
        path: "product",
        name: "product",
        component: () => import("@/views/product/product"),
        meta: { title: "商品列表", icon: "table" },
      },
    ],
  },
  // {
  //   path: "/review",
  //   component: Layout,
  //   redirect: "/user/customer",
  //   name: "sysManage",
  //   meta: { title: "评论管理", icon: "el-icon-s-help" },
  //   children: [
  //     {
  //       path: "customer1",
  //       name: "customer1",
  //       component: () => import("@/views/sys/user"),
  //       meta: { title: "评论列表", icon: "table" },
  //     },
  //     {
  //       path: "",
  //       name: "",
  //     },
  //   ],
  // },
  {
    path: "/order",
    component: Layout,
    redirect: "/order/orderItem",
    name: "orderManage",
    meta: { title: "订单管理", icon: "el-icon-s-help" },
    children: [
      {
        path: "order",
        name: "order",
        component: () => import("@/views/order_/orderItem"),
        meta: { title: "订单列表", icon: "table" },
      },
      {
        path: "",
        name: "",
      },
    ],
  },
  {
    path: "/sys",
    component: Layout,
    redirect: "/sys/user",
    name: "sysManage",
    meta: { title: "系统管理", icon: "el-icon-s-help" },
    children: [
      {
        path: "user",
        name: "user",
        component: () => import("@/views/sys/user"),
        meta: { title: "管理员管理", icon: "table" },
      },
      {
        path: "role",
        name: "role",
        component: () => import("@/views/sys/role"),
        meta: { title: "角色管理", icon: "tree" },
      },
    ],
  },

  {
    path: "/zixun",
    component: Layout,
    redirect: "/zixun/zixun",
    name: "zixun",
    meta: { title: "咨询管理", icon: "el-icon-s-help" },
    children: [
      {
        path: "zixun",
        name: "zixun",
        component: () => import("@/views/zixun/zixun"),
        meta: { title: "咨询列表", icon: "table" },
      },
      {
        path: "",
        name: "",
      },
    ],
  },

  // 404 page must be placed at the end !!!
  { path: "*", redirect: "/404", hidden: true },
];

const createRouter = () =>
  new Router({
    // mode: 'history', // require service support
    scrollBehavior: () => ({ y: 0 }),
    routes: constantRoutes,
  });

const router = createRouter();

// Detail see: https://github.com/vuejs/vue-router/issues/1234#issuecomment-357941465
export function resetRouter() {
  const newRouter = createRouter();
  router.matcher = newRouter.matcher; // reset router
}

export default router;
