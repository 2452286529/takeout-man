package com.hcb.sys.mapper;

import com.hcb.sys.entity.Product;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author hcb
 * @since 2023-06-11
 */
public interface ProductMapper extends BaseMapper<Product> {

    void enableStatus(Integer id);

    void stopStatus(Integer id);
}
