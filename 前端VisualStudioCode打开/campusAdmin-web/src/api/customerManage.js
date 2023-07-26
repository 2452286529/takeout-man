import request from "@/utils/request";

export default {
  getCustomerList(searchModel) {
    return request({
      url: "/customer/list",
      method: "get",
      params: {
        pageNo: searchModel.pageNo,
        pageSize: searchModel.pageSize,
        username: searchModel.username,
        phone: searchModel.phone,
      },
    });
  },
  addCustomer(customer) {
    return request({
      url: "/customer",
      method: "post",
      data: customer,
    });
  },
  updataCustomer(customer) {
    return request({
      url: "/customer",
      method: "put",
      data: customer,
    });
  },
  saveCustomer(customer) {
    if (customer.id == null && customer.id == undefined) {
      return this.addCustomer(customer);
    } else {
      return this.updataCustomer(customer);
    }
  },
  getCustomerById(id) {
    return request({
      url: `/customer/${id}`,
      method: "get",
    });
  },
  deleteCustomerById(id) {
    return request({
      url: `/customer/${id}`,
      method: "delete",
    });
  },
  
};
