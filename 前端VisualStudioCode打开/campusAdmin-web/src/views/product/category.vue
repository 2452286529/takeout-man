<template>
  <div>
    <!-- 搜索栏 -->
    <el-card id="search">

      <el-row>
        <el-col :span="20">
          <el-input v-model="searchModel.name"
                    placeholder="请输入分类名称"
                    clearable></el-input>
          <el-button type="primary"
                     round
                     icon="el-icon-search"
                     @click="getCategoryList">查询</el-button>
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
      <el-table :data="categoryList"
                stripe
                style="width: 100%">
        <el-table-column label="#"
                         width="80">
          <template slot-scope="scope">
            {{ (searchModel.pageNo-1)*searchModel.pageSize+ scope.$index+1}}
          </template>
        </el-table-column>
        <el-table-column prop="id"
                         label="ID"
                         width="200">
        </el-table-column>
        <el-table-column prop="name"
                         label="分类名称"
                         >
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
                       @click="deletCategory(scope.row)"></el-button>
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
      <el-form :model="categoryForm"
               ref="categoryFormRef"
               :rules="rules">
        <el-form-item label="角色名称"
                      prop="name"
                      :label-width="formLabelWidth">
          <el-input v-model="categoryForm.name"
                    autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer"
           class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary"
                   @click="saveCategory()">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import categoryApi from '@/api/categoryManage'
export default {
  data () {
    return {
      formLabelWidth: '130px',
      categoryForm: {},
      dialogFormVisible: false,
      title: "",
      total: 0,
      searchModel: {
        pageNo: 1,
        pageSize: 10,
      },
      categoryList: [],
      rules: {
        name: [
          { required: true, message: '请输入角色名称', trigger: 'blur' },
          { min: 1, max: 8, message: '长度在 1 到 8 个字符', trigger: 'blur' }
        ],
        categoryDesc: [
          { required: true, message: '请输角色描述', trigger: 'blur' },
          { min: 0, max: 18, message: '长度在 0 到 18 个字符', trigger: 'blur' }
        ]
      }
    }
  },
  methods: {
    deletCategory (category) {
      this.$confirm(`您确定删除用户${category.name}?`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        categoryApi.deleteCategoryById(category.id).then(response => {
          this.$message({
            type: 'success',
            message: response.message
          });
          this.getCategoryList();
        });
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    },
    saveCategory () {
      this.$refs.categoryFormRef.validate((valid) => {
        if (valid) {
          categoryApi.saveCategory(this.categoryForm).then(response => {
            this.$message({
              message: response.message,
              type: 'success'
            });
            this.dialogFormVisible = false;
            this.getCategoryList();
          });
        } else {
          console.log('error submit!!');
          return false;
        }
      });
    },
    clearFoem () {
      this.categoryForm = {};
      this.$refs.categoryFormRef.clearValidate();
    },
    openEditUI (id) {
      if (id == null) {
        this.title = '新增角色';
      } else {
        this.title = '编辑角色';
        categoryApi.getCategoryById(id).then(response => {
          this.categoryForm = response.data;
        });
      }
      this.dialogFormVisible = true;
    },
    handleSizeChange (pageSize) {
      this.searchModel.pageSize = pageSize;
      this.getCategoryList();
    },
    handleCurrentChange (pageNo) {
      this.searchModel.pageNo = pageNo;
      this.getCategoryList();
    },
    getCategoryList () {
      categoryApi.getCategoryList(this.searchModel).then(response => {
        this.categoryList = response.data.rows;
        this.total = response.data.total;
      });
    }
  },
  created () {
    this.getCategoryList();
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