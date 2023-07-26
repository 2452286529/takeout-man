package com.hcb.sys.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hcb.common.vo.Result;
import com.hcb.sys.entity.Product;
import com.hcb.sys.service.IProductService;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Controller;

import java.util.HashMap;
import java.util.List;
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
@RequestMapping("/product")
@Slf4j
public class ProductController {
    @Autowired
    private IProductService productService;

    @GetMapping("/list")
    public Result<?> getProductList(@RequestParam(value = "name", required = false) String name,
                                    @RequestParam("pageNo") Long pageNo,
                                    @RequestParam("pageSize") Long pageSize) {

        LambdaQueryWrapper<Product> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(StringUtils.hasLength(name), Product::getName, name);

        Page<Product> page = new Page<>(pageNo, pageSize);
        productService.page(page, wrapper);

        Map<String, Object> data = new HashMap<>();
        data.put("total", page.getTotal());
        data.put("rows", page.getRecords());

        log.debug(String.valueOf(page.getRecords()));

        return Result.success(data);
    }

    @PostMapping
    public Result<?> addProduct(@RequestBody Product product) {
        productService.save(product);
        return Result.success("新增商品成功");

    }

    @PostMapping("/{id}")
    public Result<?> productStatusById(@PathVariable("id") Integer id) {
        Product product = productService.getById(id);
        if (product.getStatus() == 1) {
            productService.stopStatus(id);
        } else {
            productService.enableStatus(id);
        }
        return Result.success("设置成功");

    }

    @GetMapping("/{id}")
    public Result<Product> getProductById(@PathVariable("id") Long id) {
        Product product = productService.getById(id);
        return Result.success(product);
    }

    @DeleteMapping("/{id}")
    public Result<Product> deleteProductById(@PathVariable("id") Long id) {
        productService.removeById(id);
        return Result.success("删除商品成功");

    }

}
