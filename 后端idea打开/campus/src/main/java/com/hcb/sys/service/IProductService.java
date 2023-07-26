package com.hcb.sys.service;

import com.hcb.sys.entity.Product;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author hcb
 * @since 2023-06-11
 */
public interface IProductService extends IService<Product> {

    void stopStatus(Integer id);

    void enableStatus(Integer id);
}
