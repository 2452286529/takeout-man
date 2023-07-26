package com.hcb;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hcb.common.vo.Result;
import com.hcb.sys.entity.Product;
import com.hcb.sys.entity.User;
import com.hcb.sys.mapper.UserMapper;
import com.hcb.sys.service.IProductService;
import io.swagger.annotations.ApiOperation;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@SpringBootTest
class CampusApplicationTests {
    @Resource
    private UserMapper userMapper;

    @Autowired
    private IProductService productService;

    @Test
    void testMapper() {
        List<User> users = userMapper.selectList(null);
        users.forEach(System.out::println);
    }

    @Test
    void testProductMapper() {
        String name = null;
        Long pageNo = Long.valueOf(1);
        Long pageSize = Long.valueOf(1);

        LambdaQueryWrapper<Product> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(StringUtils.hasLength(name), Product::getName, name);

        Page<Product> page = new Page<>(pageNo, pageSize);
        productService.page(page, wrapper);

        Map<String, Object> data = new HashMap<>();
        data.put("total", page.getTotal());
        data.put("rows", page.getRecords());

        data.forEach((key,v)->{
            System.out.println(key+"---"+v);

        });
    }

}
