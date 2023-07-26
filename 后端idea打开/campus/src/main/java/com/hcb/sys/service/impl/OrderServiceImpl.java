package com.hcb.sys.service.impl;

import com.hcb.sys.entity.Order;
import com.hcb.sys.mapper.OrderMapper;
import com.hcb.sys.service.IOrderService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author hcb
 * @since 2023-06-11
 */
@Service
public class OrderServiceImpl extends ServiceImpl<OrderMapper, Order> implements IOrderService {

    @Override
    public void setOrderStatus(Integer id) {

        this.baseMapper.setOrderStatus(id);

    }
}
