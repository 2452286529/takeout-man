import request from "@/utils/request";

export default {
  getRoleList(searchModel) {
    return request({
      url: "/role/list",
      method: "get",
      params: {
        pageNo: searchModel.pageNo,
        pageSize: searchModel.pageSize,
        name: searchModel.name,
      },
    });
  },
  addRole(role) {
    return request({
      url: "/role",
      method: "post",
      data: role,
    });
  },
  updataRole(role) {
    return request({
      url: "/role",
      method: "put",
      data: role,
    });
  },
  saveRole(role) {
    if (role.id == null && role.id == undefined) {
      return this.addRole(role);
    } else {
      return this.updataRole(role);
    }
  },
  getRoleById(id) {
    return request({
      url: `/role/${id}`,
      method: "get",
    });
  },
  deleteRoleById(id) {
    return request({
      url: `/role/${id}`,
      method: "delete",
    });
  },
  
};
