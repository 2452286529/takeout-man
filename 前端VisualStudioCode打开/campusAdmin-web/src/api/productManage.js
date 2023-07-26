import request from "@/utils/request";

export default {
  getProductList(searchModel) {
    return request({
      url: "/product/list",
      method: "get",
      params: {
        pageNo: searchModel.pageNo,
        pageSize: searchModel.pageSize,
        name: searchModel.name,
      },
    });
  },
  addProduct(product) {
    return request({
      url: "/product",
      method: "post",
      data: product,
    });
  },
  updataProduct(product) {
    return request({
      url: "/product",
      method: "put",
      data: product,
    });
  },
  productStatusById(id) {
    return request({
      url: `/product/${id}`,
      method: "post",
    });
  },
  saveProduct(product) {
    if (product.id == null && product.id == undefined) {
      return this.addProduct(product);
    } else {
      return this.updataProduct(product);
    }
  },
  getProductById(id) {
    return request({
      url: `/product/${id}`,
      method: "get",
    });
  },
  deleteProductById(id) {
    return request({
      url: `/product/${id}`,
      method: "delete",
    });
  },
};
