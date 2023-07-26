package com.hcb.sys.service;

import com.hcb.sys.entity.Order;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author hcb
 * @since 2023-06-11
 */
public interface IOrderService extends IService<Order> {

    void setOrderStatus(Integer id);

}
