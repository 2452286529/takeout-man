package com.hcb.sys.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hcb.common.vo.Result;
import com.hcb.sys.entity.Customer;
import com.hcb.sys.service.ICustomerService;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
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
@RequestMapping("/customer")
public class CustomerController {
    @Autowired
    private ICustomerService customerService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @GetMapping("/all")
    public Result<List<Customer>> getAllCustomer() {
        List<Customer> list = customerService.list();
        return Result.success(list, "查询成功");
    }

    @ApiOperation("用户登录")
    @PostMapping("/login")
    public Result<Map<String, Object>> login(@RequestBody Customer customer) {
        Map<String, Object> data = customerService.login(customer);
        if (data != null) {
            return Result.success(data);
        }
        return Result.fail(20002, "用户名或密码错误");
    }

    @GetMapping("/info")
    public Result<Map<String, Object>> getCustomerInfo(@RequestParam("token") String token) {
        Map<String, Object> data = customerService.getCustomerInfo(token);
        if (data != null) {
            return Result.success(data);
        }
        return Result.fail(20003, "用户信息无效，请重新登录");
    }

    @PostMapping("/logout")
    public Result<?> logout(@RequestHeader("X-Token") String token) {
        customerService.logout(token);
        return Result.success();
    }

    @GetMapping("/list")
    public Result<?> getCustomerList(@RequestParam(value = "username", required = false) String username,
                                 @RequestParam(value = "phone", required = false) String phone,
                                 @RequestParam("pageNo") Long pageNo,
                                 @RequestParam("pageSize") Long pageSize) {

        LambdaQueryWrapper<Customer> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(StringUtils.hasLength(username), Customer::getUsername, username);
        wrapper.eq(StringUtils.hasLength(phone), Customer::getPhone, phone);

        Page<Customer> page = new Page<>(pageNo, pageSize);
        customerService.page(page, wrapper);

        Map<String, Object> data = new HashMap<>();
        data.put("total", page.getTotal());
        data.put("rows", page.getRecords());

        return Result.success(data);
    }

    @PostMapping
    public Result<?> addCustomer(@RequestBody Customer customer) {
        customer.setPassword(passwordEncoder.encode(customer.getPassword()));
        customerService.save(customer);
        return Result.success("新增管理用户成功");

    }

    @PutMapping
    public Result<?> updataCustomer(@RequestBody Customer customer) {
        customer.setPassword(null);
        customerService.updateById(customer);
        return Result.success("修改管理用户成功");

    }

    @GetMapping("/{id}")
    public Result<Customer> getCustomerById(@PathVariable("id") Long id) {
        Customer customer = customerService.getById(id);
        return Result.success(customer);
    }

    @DeleteMapping("/{id}")
    public Result<Customer> deleteCustomerById(@PathVariable("id") Long id) {
        customerService.removeById(id);
        return Result.success("删除用户成功");

    }

}
