import request from "@/utils/request";

export default {
  getZixunList(searchModel) {
    return request({
      url: "/zixun/list",
      method: "get",
      params: {
        pageNo: searchModel.pageNo,
        pageSize: searchModel.pageSize,
        id: searchModel.id,
      },
    });
  },
  deleteZixunById(id) {
    return request({
      url: `/zixun/${id}`,
      method: "delete",
    });
  },
  updataZixun(id) {
    return request({
      url: `/zixun/${id}`,
      method: "put",
    });
  },
};
