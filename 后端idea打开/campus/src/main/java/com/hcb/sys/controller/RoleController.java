package com.hcb.sys.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hcb.common.vo.Result;
import com.hcb.sys.entity.Role;
import com.hcb.sys.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author hcb
 * @since 2023-06-11
 */
@RestController
@RequestMapping("/role")
public class RoleController {
    @Autowired
    private IRoleService roleService;

    @GetMapping("/list")
    public Result<?> getRoleList(@RequestParam(value = "name", required = false) String name,
                                 @RequestParam("pageNo") Long pageNo,
                                 @RequestParam("pageSize") Long pageSize) {

        LambdaQueryWrapper<Role> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(StringUtils.hasLength(name), Role::getName, name);

        Page<Role> page = new Page<>(pageNo, pageSize);
        roleService.page(page, wrapper);

        Map<String, Object> data = new HashMap<>();
        data.put("total", page.getTotal());
        data.put("rows", page.getRecords());

        return Result.success(data);
    }

    @PostMapping
    public Result<?> addRole(@RequestBody Role role) {
        roleService.save(role);
        return Result.success("新增角色成功");

    }
    @PutMapping
    public Result<?> updataRole(@RequestBody Role role) {
        roleService.updateById(role);
        return Result.success("修改角色成功");
    }

    @GetMapping("/{id}")
    public Result<Role> getRoleById(@PathVariable("id") Long id) {
        Role role = roleService.getById(id);
        return Result.success(role);
    }

    @DeleteMapping("/{id}")
    public Result<Role> deleteRoleById(@PathVariable("id") Long id) {
        roleService.removeById(id);
        return Result.success("删除角色成功");

    }

}
