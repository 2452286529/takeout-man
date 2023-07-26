package com.hcb.sys.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hcb.common.vo.Result;
import com.hcb.sys.entity.Category;
import com.hcb.sys.service.ICategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

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
@RequestMapping("/category")
public class CategoryController {
    @Autowired
    private ICategoryService categoryService;

    @GetMapping("/list")
    public Result<?> getCategoryList(@RequestParam(value = "name", required = false) String name,
                                     @RequestParam("pageNo") Long pageNo,
                                     @RequestParam("pageSize") Long pageSize) {

        LambdaQueryWrapper<Category> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(StringUtils.hasLength(name), Category::getName, name);

        Page<Category> page = new Page<>(pageNo, pageSize);
        categoryService.page(page, wrapper);

        Map<String, Object> data = new HashMap<>();
        data.put("total", page.getTotal());
        data.put("rows", page.getRecords());

        return Result.success(data);
    }

    @PostMapping
    public Result<?> addCategory(@RequestBody Category category) {
        categoryService.save(category);
        return Result.success("新增分类成功");
    }

    @PutMapping
    public Result<?> updataCategory(@RequestBody Category category) {
        categoryService.updateById(category);
        return Result.success("修改分类成功");
    }

    @GetMapping("/{id}")
    public Result<Category> getCategoryById(@PathVariable("id") Long id) {
        Category category = categoryService.getById(id);
        return Result.success(category);
    }

    @DeleteMapping("/{id}")
    public Result<Category> deleteCategoryById(@PathVariable("id") Long id) {
        categoryService.removeById(id);
        return Result.success("删除分类成功");

    }

}
