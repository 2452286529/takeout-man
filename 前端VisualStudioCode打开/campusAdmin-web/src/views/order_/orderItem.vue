<template>
  <div>
    <!-- 结果列表 -->
    <el-card>
      <el-table :data="orderList"
                stripe
                style="width: 100%">
        <el-table-column label="#"
                         width="80">
          <template slot-scope="scope">
            {{ (searchModel.pageNo-1)*searchModel.pageSize+ scope.$index+1}}
          </template>
        </el-table-column>
        <el-table-column prop="id"
                         label="订单ID"
                         width="80">
        </el-table-column>
        <el-table-column prop="address"
                         label="地址"
                         width="700">
        </el-table-column>
        <el-table-column prop="cid"
                         label="买家"
                         width="180">
        </el-table-column>
        <el-table-column 
                         label="总价"
                         width="80">
        </el-table-column>
        <el-table-column prop="status"
                         label="状态">
          <template slot-scope="scope">
            <el-tag type="successs"
                    v-if="scope.row.status==2">已发货</el-tag>
            <el-tag type="info"
                    v-if="scope.row.status==1">未发货</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作"
                         width="180">
          <template slot-scope="scope">
            <el-button id="button"
                       v-if="scope.row.status==2"
                       disabled
                       type="info"
                       size="mini"
                       class="button">
              已发货
            </el-button>
            <el-button id="button"
                       v-if="scope.row.status==1"
                       type="success"
                       size="mini"
                       class="button"
                       @click="open(scope.row)">
              发货
            </el-button>
            <el-button type="danger"
                       icon="el-icon-delete"
                       size="mini"
                       @click="deletOrder(scope.row)"></el-button>
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
import orderApi from '@/api/orderManage'
export default {
  data () {
    return {
      username: "",
      formLabelWidth: '130px',
      orderForm: {},
      dialogFormVisible: false,
      title: "",
      total: 0,
      searchModel: {
        pageNo: 1,
        pageSize: 10,
      },
      orderList: [],
    }
  },
  methods: {
    open (order) {
      this.$confirm('确认发货吗?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        orderApi.updataOrder(order.id).then(response => {
          this.$message({
            type: 'success',
            message: response.message
          });
          this.getOrderList();
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消设置'
        });
      });
    },
    deletOrder (order) {
      this.$confirm(`您确定删除这条订单?`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        orderApi.deleteOrderById(order.id).then(response => {
          this.$message({
            type: 'success',
            message: response.message
          });
          this.getOrderList();
        });
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    },
    clearFoem () {
      this.orderForm = {};
      this.$refs.orderFormRef.clearValidate();
    },
    handleSizeChange (pageSize) {
      this.searchModel.pageSize = pageSize;
      this.getOrderList();
    },
    handleCurrentChange (pageNo) {
      this.searchModel.pageNo = pageNo;
      this.getOrderList();
    },
    getOrderList () {
      orderApi.getOrderList(this.searchModel).then(response => {
        this.orderList = response.data.rows;
        this.total = response.data.total;
        this.username = response.data.username;
      });
    }
  },
  created () {
    this.getOrderList();
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