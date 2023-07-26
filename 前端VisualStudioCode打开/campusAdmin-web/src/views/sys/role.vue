<template>
  <div>
    <!-- 搜索栏 -->
    <el-card id="search">

      <el-row>
        <el-col :span="20">
          <el-input v-model="searchModel.name"
                    placeholder="角色名称"
                    clearable></el-input>
          <el-button type="primary"
                     round
                     icon="el-icon-search"
                     @click="getRoleList">查询</el-button>
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
      <el-table :data="roleList"
                stripe
                style="width: 100%">
        <el-table-column label="#"
                         width="80">
          <template slot-scope="scope">
            {{ (searchModel.pageNo-1)*searchModel.pageSize+ scope.$index+1}}
          </template>
        </el-table-column>
        <el-table-column prop="id"
                         label="角色ID"
                         width="200">
        </el-table-column>
        <el-table-column prop="name"
                         label="角色名称"
                         width="280">
        </el-table-column>
        <el-table-column prop="roleDesc"
                         label="角色描述">
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
                       @click="deletRole(scope.row)"></el-button>
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

    <!-- 角色信息编辑对话框 -->
    <el-dialog @close="clearFoem"
               :title="title"
               :visible.sync="dialogFormVisible">
      <el-form :model="roleForm"
               ref="roleFormRef"
               :rules="rules">
        <el-form-item label="角色名称"
                      prop="name"
                      :label-width="formLabelWidth">
          <el-input v-model="roleForm.name"
                    autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="角色描述"
                      prop="roleDesc"
                      :label-width="formLabelWidth">
          <el-input v-model="roleForm.roleDesc"
                    autocomplete="off"></el-input>
        </el-form-item>

      </el-form>
      <div slot="footer"
           class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary"
                   @click="saveRole()">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import roleApi from '@/api/roleManage'
export default {
  data () {
    return {
      formLabelWidth: '130px',
      roleForm: {},
      dialogFormVisible: false,
      title: "",
      total: 0,
      searchModel: {
        pageNo: 1,
        pageSize: 10,
      },
      roleList: [],
      rules: {
        name: [
          { required: true, message: '请输入角色名称', trigger: 'blur' },
          { min: 1, max: 8, message: '长度在 1 到 8 个字符', trigger: 'blur' }
        ],
        roleDesc: [
          { required: true, message: '请输角色描述', trigger: 'blur' },
          { min: 0, max: 18, message: '长度在 0 到 18 个字符', trigger: 'blur' }
        ]
      }
    }
  },
  methods: {
    deletRole (role) {
      this.$confirm(`您确定删除用户${role.name}?`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        roleApi.deleteRoleById(role.id).then(response => {
          this.$message({
            type: 'success',
            message: response.message
          });
          this.getRoleList();
        });
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    },
    saveRole () {
      this.$refs.roleFormRef.validate((valid) => {
        if (valid) {
          roleApi.saveRole(this.roleForm).then(response => {
            this.$message({
              message: response.message,
              type: 'success'
            });
            this.dialogFormVisible = false;
            this.getRoleList();
          });
        } else {
          console.log('error submit!!');
          return false;
        }
      });
    },
    clearFoem () {
      this.roleForm = {};
      this.$refs.roleFormRef.clearValidate();
    },
    openEditUI (id) {
      if (id == null) {
        this.title = '新增角色';
      } else {
        this.title = '编辑角色';
        roleApi.getRoleById(id).then(response => {
          this.roleForm = response.data;
        });
      }
      this.dialogFormVisible = true;
    },
    handleSizeChange (pageSize) {
      this.searchModel.pageSize = pageSize;
      this.getRoleList();
    },
    handleCurrentChange (pageNo) {
      this.searchModel.pageNo = pageNo;
      this.getRoleList();
    },
    getRoleList () {
      roleApi.getRoleList(this.searchModel).then(response => {
        this.roleList = response.data.rows;
        this.total = response.data.total;
      });
    }
  },
  created () {
    this.getRoleList();
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