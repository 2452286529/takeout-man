package com.hcb.sys.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.hcb.common.utils.JwtUtil;
import com.hcb.sys.entity.Customer;
import com.hcb.sys.mapper.CustomerMapper;
import com.hcb.sys.service.ICustomerService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author hcb
 * @since 2023-06-11
 */
@Service
public class CustomerServiceImpl extends ServiceImpl<CustomerMapper, Customer> implements ICustomerService {
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private JwtUtil jwtUtil;

    @Override
    public Map<String, Object> login(Customer customer) {
        LambdaQueryWrapper<Customer> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Customer::getUsername, customer.getUsername());
        Customer loginCustomer = this.baseMapper.selectOne(wrapper);

        if (loginCustomer != null && passwordEncoder.matches(customer.getPassword(), loginCustomer.getPassword())) {
            loginCustomer.setPassword(null);
            String token = jwtUtil.createToken(loginCustomer);
            Map<String, Object> data = new HashMap<>();
            data.put("token", token);
            return data;
        }
        return null;
    }

    @Override
    public Map<String, Object> getCustomerInfo(String token) {
        Customer loginCustomer = null;
        try {
            loginCustomer = jwtUtil.parseToken(token, Customer.class);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (loginCustomer != null) {
            Map<String, Object> data = new HashMap<>();
            data.put("username", loginCustomer.getUsername());
            List<String> roleList = null;//this.baseMapper.getRoleNameByCustomerId(loginCustomer.getId());
            data.put("roles", roleList);

            return data;
        }
        return null;
    }

    @Override
    public void logout(String token) {
//        redisTemplate.delete(token);

    }
}
