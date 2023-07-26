<template>
  <div>
    <!-- 结果列表 -->
    <el-card>
      <el-table :data="zixunList"
                stripe
                style="width: 100%">
        <el-table-column label="#"
                         width="80">
          <template slot-scope="scope">
            {{ (searchModel.pageNo-1)*searchModel.pageSize+ scope.$index+1}}
          </template>
        </el-table-column>
        <el-table-column prop="username"
                         label="发布者"
                         width="200">
        </el-table-column>
        <el-table-column prop="content"
                         label="发布内容"
                         width="280">
        </el-table-column>
        <el-table-column prop="fabudate"
                         label="发布时间">
        </el-table-column>
        <el-table-column prop="status"
                         label="审核状态">
          <template slot-scope="scope">
            <el-tag type="successs"
                    v-if="scope.row.status==1">已审核</el-tag>
            <el-tag type="info"
                    v-if="scope.row.status==0">未审核</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作"
                         width="180">
          <template slot-scope="scope">
            <el-button id="button"
                       v-if="scope.row.status==1"
                       disabled
                       type="info"
                       size="mini"
                       class="button">
              已通过
            </el-button>
            <el-button id="button"
                       v-if="scope.row.status==0"
                       type="success"
                       size="mini"
                       class="button"
                       @click="open(scope.row)">
              通过
            </el-button>
            <el-button type="danger"
                       icon="el-icon-delete"
                       size="mini"
                       @click="deletZixun(scope.row)"></el-button>
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

  </div>
</template>

<script>
import zixunApi from '@/api/zixunManage'
export default {
  data () {
    return {
      username: "",
      formLabelWidth: '130px',
      zixunForm: {},
      dialogFormVisible: false,
      title: "",
      total: 0,
      searchModel: {
        pageNo: 1,
        pageSize: 10,
      },
      zixunList: [],
    }
  },
  methods: {
    open (zixun) {
      this.$confirm('确认通过审核吗?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        zixunApi.updataZixun(zixun.id).then(response => {
          this.$message({
            type: 'success',
            message: response.message
          });
          this.getZixunList();
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消设置'
        });
      });
    },
    deletZixun (zixun) {
      this.$confirm(`您确定删除这条咨询?`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        zixunApi.deleteZixunById(zixun.id).then(response => {
          this.$message({
            type: 'success',
            message: response.message
          });
          this.getZixunList();
        });
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    },
    clearFoem () {
      this.zixunForm = {};
      this.$refs.zixunFormRef.clearValidate();
    },
    handleSizeChange (pageSize) {
      this.searchModel.pageSize = pageSize;
      this.getZixunList();
    },
    handleCurrentChange (pageNo) {
      this.searchModel.pageNo = pageNo;
      this.getZixunList();
    },
    getZixunList () {
      zixunApi.getZixunList(this.searchModel).then(response => {
        this.zixunList = response.data.rows;
        this.total = response.data.total;
        this.username = response.data.username;
      });
    }
  },
  created () {
    this.getZixunList();
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
.button .span {
}
</style>