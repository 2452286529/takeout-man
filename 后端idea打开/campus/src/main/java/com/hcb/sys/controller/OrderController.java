package com.hcb.sys.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hcb.common.vo.Result;
import com.hcb.sys.entity.Order;
import com.hcb.sys.service.IOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Controller;

import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author hcb
 * @since 2023-06-11
 */
@RestController
@RequestMapping("/order")
public class OrderController {
    @Autowired
    private IOrderService orderService;

    @GetMapping("/list")
    public Result<?> getOrderList(
            @RequestParam("pageNo") Long pageNo,
            @RequestParam("pageSize") Long pageSize) {

        Page<Order> page = new Page<>(pageNo, pageSize);
        orderService.page(page);

        Map<String, Object> data = new HashMap<>();
        data.put("total", page.getTotal());
        data.put("rows", page.getRecords());

        return Result.success(data);
    }

    @PutMapping("/{id}")
    public Result<?> updataOrder(@PathVariable("id") Integer id) {
        orderService.setOrderStatus(id);
        return Result.success("已发货");
    }

    @DeleteMapping("/{id}")
    public Result<Order> deleteOrderById(@PathVariable("id") Long id) {
        orderService.removeById(id);
        return Result.success("删除订单成功");

    }
}
