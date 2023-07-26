<template>
  <div>
    <!-- 搜索栏 -->
    <el-card id="search">
      <el-row>
        <el-col :span="20">
          <el-input v-model="searchModel.name"
                    placeholder="商品名称"
                    clearable></el-input>
          <el-button type="primary"
                     round
                     icon="el-icon-search"
                     @click="getProductList">查询</el-button>
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
      <el-table :data="productList"
                stripe
                style="width: 100%">
        <el-table-column label="#"
                         width="80">
          <template slot-scope="scope">
            {{ (searchModel.pageNo-1)*searchModel.pageSize+ scope.$index+1}}
          </template>
        </el-table-column>
        <el-table-column prop="name"
                         label="商品名"
                         width="autocomplete">
        </el-table-column>
        <el-table-column prop="price"
                         label="单价"
                         width="autocomplete">
        </el-table-column>
        <el-table-column prop="zan"
                         label="人气"
                         width="autocomplete">
        </el-table-column>
        <el-table-column prop="number"
                         label="销量"
                         width="autocomplete">
        </el-table-column>
        <el-table-column prop="miaoshu"
                         label="商品描述"
                         width="autocomplete">
        </el-table-column>
        <el-table-column prop="cid"
                         label="分类"
                         width="autocomplete">
        </el-table-column>
        <el-table-column prop="bid"
                         label="所属商家"
                         width="autocomplete">
        </el-table-column>
        <el-table-column label="图片">
          <template slot-scope="scope">
            <img :src="scope.row.imageurl ? require(`../../assets/${scope.row.imageurl}`) : require('../../assets/404_images/no-image.jpg')"
                 alt=""
                 @error="handleImageError">
          </template>
        </el-table-column>
        <el-table-column prop="status"
                         label="是否上线">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.status==1">已上线</el-tag>
            <el-tag type="danger"
                    v-if="scope.row.status==0">已下线</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作"
                         width="150">
          <template slot-scope="scope">
            <el-button type="primary"
                       icon="el-icon-check"
                       circle
                       size="mini"
                       @click="productStatus(scope.row)"></el-button>
            <el-button type="primary"
                       icon="el-icon-edit"
                       circle
                       size="mini"
                       @click="openEditUI(scope.row.id)"></el-button>
            <el-button type="danger"
                       icon="el-icon-delete"
                       circle
                       size="mini"
                       @click="deletProduct(scope.row)"></el-button>
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
      <el-form :model="productForm"
               ref="productFormRef"
               :rules="rules">
        <el-form-item label="商品名称"
                      prop="name"
                      :label-width="formLabelWidth">
          <el-input v-model="productForm.name"
                    autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item v-if="productForm.id==null || productForm.id==undefined"
                      label="商品单价"
                      prop="price"
                      :label-width="formLabelWidth">
          <el-input v-model="productForm.price"
                    autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="人气"
                      prop="zan"
                      :label-width="formLabelWidth">
          <el-input v-model="productForm.zan"
                    autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="销量"
                      prop="number"
                      :label-width="formLabelWidth">
          <el-input v-model="productForm.number"
                    autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="商品描述"
                      prop="miaoshu"
                      :label-width="formLabelWidth">
          <el-input v-model="productForm.miaoshu"
                    autocomplete="off"></el-input>
        </el-form-item>

        <el-form-item label="商品图片"
                      :label-width="formLabelWidth">
          <el-upload class="upload-demo"
                     action="https://jsonplaceholder.typicode.com/posts/"
                     :on-preview="handlePreview"
                     :on-remove="handleRemove"
                     :file-list="fileList"
                     list-type="picture"
                     :before-upload="beforeUpload">
            <el-button size="small"
                       type="primary">点击上传</el-button>
            <div slot="tip"
                 class="el-upload__tip">只能上传jpg/png文件，且不超过1MB</div>
          </el-upload>

        </el-form-item>

        <el-form-item label="分类"
                      prop="cid"
                      :label-width="formLabelWidth">
          <el-input v-model="productForm.imageurl"
                    autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="商家"
                      prop="bid"
                      :label-width="formLabelWidth">
          <el-input v-model="productForm.bid"
                    autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer"
           class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary"
                   @click="saveProduct()">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import productApi from '@/api/productManage'
export default {
  data () {
    return {

      fileList: [],

      formLabelWidth: '130px',
      productForm: {
        status: 0,
      },

      dialogFormVisible: false,
      title: "",
      total: 0,
      searchModel: {
        pageNo: 1,
        pageSize: 10,
      },
      productList: [],
      rules: {
        // name: [
        //   { required: true, message: '请输入用户名', trigger: 'blur' },
        //   { min: 1, max: 8, message: '长度在 1 到 8 个字符', trigger: 'blur' }
        // ],
        // price: [
        //   { required: true, message: '请输入密码', trigger: 'blur' },
        //   { min: 6, max: 18, message: '长度在 6 到 18 个字符', trigger: 'blur' }
        // ],
        // zan: [
        //   { min: 11, max: 11, message: '请输入正确11位电话号码', trigger: 'blur' }
        // ],

      }
    }
  },
  methods: {

    beforeUpload (file) {
      const isJPGOrPNG = file.type === 'image/jpeg' || file.type === 'image/png';
      const isLt1M = file.size / 1024 / 1024 < 1; // 修改为1MB（即1000kb）

      if (!isJPGOrPNG) {
        this.$message.error('只能上传jpg/png文件！');
        return false;
      }
      if (!isLt1M) {
        this.$message.error('上传文件大小不能超过1MB！');
        return false;
      }
      return true;
    },
    handleRemove (file, fileList) {
      console.log(file, fileList);
    },
    handlePreview (file) {
      console.log(file);
    },



    handleImageError (event) {
      event.target.onerror = null; // 避免死循环
      event.target.src = require("../../assets/404_images/no-image.jpg");
    },
    productStatus (product) {
      var statusMessage;
      if (product.status == 1) {
        statusMessage = "下架";
      } else {
        statusMessage = "上架"
      }
      this.$confirm(`您确定${statusMessage} ${product.name}?`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        productApi.productStatusById(product.id).then(response => {
          this.$message({
            type: 'success',
            message: response.message
          });
          this.getProductList();
        });
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消'
        });
      });
    },
    deletProduct (product) {
      this.$confirm(`您确定删除用户${product.name}?`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        productApi.deleteProductById(product.id).then(response => {
          this.$message({
            type: 'success',
            message: response.message
          });
          this.getProductList();
        });
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    },
    saveProduct () {
      this.$refs.productFormRef.validate((valid) => {
        if (valid) {
          productApi.saveProduct(this.productForm).then(response => {
            this.$message({
              message: response.message,
              type: 'success'
            });
            this.dialogFormVisible = false;
            this.getProductList();
          });
        } else {
          console.log('error submit!!');
          return false;
        }
      });
    },
    clearFoem () {
      this.handleRemove(this.file, this.fileList);
      this.productForm = {};
      this.$refs.productFormRef.clearValidate();
    },
    openEditUI (id) {
      if (id == null) {
        this.title = '新增商品';
      } else {
        this.title = '编辑商品';
        productApi.getProductById(id).then(response => {
          this.productForm = response.data;
        });
      }

      this.dialogFormVisible = true;
    },
    handleSizeChange (pageSize) {
      this.searchModel.pageSize = pageSize;
      this.getProductList();
    },
    handleCurrentChange (pageNo) {
      this.searchModel.pageNo = pageNo;
      this.getProductList();
    },
    getProductList () {
      productApi.getProductList(this.searchModel).then(response => {
        this.productList = response.data.rows;
        this.total = response.data.total;
      });
    }
  },
  created () {
    this.getProductList();
  },
}
</script>

<style>
#search .el-input {
  width: 200px;
  margin-right: 10px;
}
img {
  width: auto;
  height: 80px;
}
.el-input {
  width: 85%;
}
</style>