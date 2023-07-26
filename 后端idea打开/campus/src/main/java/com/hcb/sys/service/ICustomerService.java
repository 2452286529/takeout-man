package com.hcb.sys.service;

import com.hcb.sys.entity.Customer;
import com.baomidou.mybatisplus.extension.service.IService;


import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author hcb
 * @since 2023-06-11
 */
public interface ICustomerService extends IService<Customer> {
    Map<String, Object> login(Customer customer);

    Map<String, Object> getCustomerInfo(String token);

    void logout(String token);
}
