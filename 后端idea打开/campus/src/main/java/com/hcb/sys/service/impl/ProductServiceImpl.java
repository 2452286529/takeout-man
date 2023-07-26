package com.hcb.sys.service.impl;

import com.hcb.sys.entity.Product;
import com.hcb.sys.mapper.ProductMapper;
import com.hcb.sys.service.IProductService;
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
public class ProductServiceImpl extends ServiceImpl<ProductMapper, Product> implements IProductService {

    @Override
    public void stopStatus(Integer id) {
        this.baseMapper.stopStatus(id);
    }

    @Override
    public void enableStatus(Integer id) {
        this.baseMapper.enableStatus(id);
    }


}
