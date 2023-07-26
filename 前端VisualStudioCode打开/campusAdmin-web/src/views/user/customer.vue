<template>
  <div>
    <!-- 搜索栏 -->
    <el-card id="search">

      <el-row>
        <el-col :span="20">
          <el-input v-model="searchModel.username"
                    placeholder="用户名"
                    clearable></el-input>
          <el-input v-model="searchModel.phone"
                    placeholder="电话号码"
                    clearable></el-input>
          <el-button type="primary"
                     round
                     icon="el-icon-search"
                     @click="getCustomerList">查询</el-button>
        </el-col>
        <el-col :span="4"
                align="right">
          <el-button @click="openEditUI(null)"
                     type="primary"
                     icon="el-icon-plus"
                     circle></el-button>
        </el-col>
      </el-row>
    </el-card>

    <!-- 结果列表 -->
    <el-card>
      <el-table :data="customerList"
                stripe
                style="width: 100%">
        <el-table-column label="#"
                         width="80">
          <template slot-scope="scope">
            {{ (searchModel.pageNo-1)*searchModel.pageSize+ scope.$index+1}}
          </template>
        </el-table-column>
        <el-table-column prop="id"
                         label="用户ID"
                         width="180">
        </el-table-column>
        <el-table-column prop="username"
                         label="用户名"
                         width="180">
        </el-table-column>
        <el-table-column prop="phone"
                         label="电话"
                         width="180">
        </el-table-column>
        <el-table-column prop="address"
                         label="地址">
        </el-table-column>
        <el-table-column prop="status"
                         label="用户等级">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.status==1">会员用户</el-tag>
            <el-tag type="danger"
                    v-if="scope.row.status==0">普通用户</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作"
                         width="180">
          <template slot-scope="scope">
            <el-button type="primary"
                       icon="el-icon-edit"
                       circle
                       size="mini"
                       @click="openEditUI(scope.row.id)"></el-button>
            <el-button type="danger"
                       icon="el-icon-delete"
                       circle
                       size="mini"
                       @click="deletCustomer(scope.row)"></el-button>
          </template>

        </el-table-column>
      </el-table>
    </el-card>

    <!-- 分页组件 -->
    <el-pagination @size-change="handleSizeChange"
                   @current-change="handleCurrentChange"
                   :current-page="searchModel.pageNo"
                   :page-sizes="[5 ,10, 20, 50]"
                   :page-size="searchModel.pageSize"
                   layout="total, sizes, prev, pager, next, jumper"
                   :total="total">
    </el-pagination>

    <!-- 用户信息编辑对话框 -->
    <el-dialog @close="clearFoem"
               :title="title"
               :visible.sync="dialogFormVisible">
      <el-form :model="customerForm"
               ref="customerFormRef"
               :rules="rules">
        <el-form-item label="用户名"
                      prop="username"
                      :label-width="formLabelWidth">
          <el-input v-model="customerForm.username"
                    autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item v-if="customerForm.id==null || customerForm.id==undefined"
                      label="登录密码"
                      prop="password"
                      :label-width="formLabelWidth">
          <el-input type="password"
                    v-model="customerForm.password"
                    autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="电话"
                      prop="phone"
                      :label-width="formLabelWidth">
          <el-input v-model="customerForm.phone"
                    autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="地址"
                      prop="address"
                      :label-width="formLabelWidth">
          <el-input v-model="customerForm.address"
                    autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="是否设置为会员"
                      :label-width="formLabelWidth">
          <el-switch v-model="customerForm.status"
                     :active-value="1"
                     :inactive-value="0">
          </el-switch>
        </el-form-item>

      </el-form>
      <div slot="footer"
           class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary"
                   @click="saveCustomer()">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import customerApi from '@/api/customerManage'
export default {
  data () {
    return {
      formLabelWidth: '130px',
      customerForm: { status: 0 },
      dialogFormVisible: false,
      title: "",
      total: 0,
      searchModel: {
        pageNo: 1,
        pageSize: 10,
      },
      customerList: [],
      rules: {
        username: [
          { required: true, message: '请输入用户名', trigger: 'blur' },
          { min: 1, max: 8, message: '长度在 1 到 8 个字符', trigger: 'blur' }
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' },
          { min: 6, max: 18, message: '长度在 6 到 18 个字符', trigger: 'blur' }
        ],
        phone: [
          { min: 11, max: 11, message: '请输入正确11位电话号码', trigger: 'blur' }
        ],
        address: [
          { message: '请输入地址', trigger: 'blur' },
        ],
      }
    }
  },
  methods: {
    deletCustomer (customer) {
      this.$confirm(`您确定删除用户${customer.username}?`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        customerApi.deleteCustomerById(customer.id).then(response => {
          this.$message({
            type: 'success',
            message: response.message
          });
          this.getCustomerList();
        });
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    },
    saveCustomer () {
      this.$refs.customerFormRef.validate((valid) => {
        if (valid) {
          customerApi.saveCustomer(this.customerForm).then(response => {
            this.$message({
              message: response.message,
              type: 'success'
            });
            this.dialogFormVisible = false;
            this.getCustomerList();
          });
        } else {
          console.log('error submit!!');
          return false;
        }
      });
    },
    clearFoem () {
      this.customerForm = {};
      this.$refs.customerFormRef.clearValidate();
    },
    openEditUI (id) {
      if (id == null) {
        this.title = '新增用户';
      } else {
        this.title = '编辑用户';
        customerApi.getCustomerById(id).then(response => {
          this.customerForm = response.data;
        });
      }

      this.dialogFormVisible = true;
    },
    handleSizeChange (pageSize) {
      this.searchModel.pageSize = pageSize;
      this.getCustomerList();
    },
    handleCurrentChange (pageNo) {
      this.searchModel.pageNo = pageNo;
      this.getCustomerList();
    },
    getCustomerList () {
      customerApi.getCustomerList(this.searchModel).then(response => {
        this.customerList = response.data.rows;
        this.total = response.data.total;
      });
    }
  },
  created () {
    this.getCustomerList();
  },
}
</script>

<style>
#search .el-input {
  width: 200px;
  margin-right: 10px;
}

.el-dialog {
  width: 35%;
}
.el-input {
  width: 85%;
}
</style>