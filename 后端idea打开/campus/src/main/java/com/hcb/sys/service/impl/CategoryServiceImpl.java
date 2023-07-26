package com.hcb.sys.service.impl;

import com.hcb.sys.entity.Category;
import com.hcb.sys.mapper.CategoryMapper;
import com.hcb.sys.service.ICategoryService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author hcb
 * @since 2023-06-11
 */
@Service
public class CategoryServiceImpl extends ServiceImpl<CategoryMapper, Category> implements ICategoryService {

}
