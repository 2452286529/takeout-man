import request from "@/utils/request";

export default {
  getOrderList(searchModel) {
    return request({
      url: "/order/list",
      method: "get",
      params: {
        pageNo: searchModel.pageNo,
        pageSize: searchModel.pageSize,
        id: searchModel.id,
      },
    });
  },
  deleteOrderById(id) {
    return request({
      url: `/order/${id}`,
      method: "delete",
    });
  },
  updataOrder(id) {
    return request({
      url: `/order/${id}`,
      method: "put",
    });
  },
};
