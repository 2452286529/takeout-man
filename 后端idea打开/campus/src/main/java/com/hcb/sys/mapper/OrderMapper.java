package com.hcb.sys.mapper;

import com.hcb.sys.entity.Order;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author hcb
 * @since 2023-06-11
 */
public interface OrderMapper extends BaseMapper<Order> {

    void setOrderStatus(Integer id);

}
