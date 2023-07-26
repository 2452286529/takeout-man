import request from "@/utils/request";

export default {
  getCategoryList(searchModel) {
    return request({
      url: "/category/list",
      method: "get",
      params: {
        pageNo: searchModel.pageNo,
        pageSize: searchModel.pageSize,
        name: searchModel.name,
      },
    });
  },
  addCategory(category) {
    return request({
      url: "/category",
      method: "post",
      data: category,
    });
  },
  updataCategory(category) {
    return request({
      url: "/category",
      method: "put",
      data: category,
    });
  },
  saveCategory(category) {
    if (category.id == null && category.id == undefined) {
      return this.addCategory(category);
    } else {
      return this.updataCategory(category);
    }
  },
  getCategoryById(id) {
    return request({
      url: `/category/${id}`,
      method: "get",
    });
  },
  deleteCategoryById(id) {
    return request({
      url: `/category/${id}`,
      method: "delete",
    });
  },
  
};
