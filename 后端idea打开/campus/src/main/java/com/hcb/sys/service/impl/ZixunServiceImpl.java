package com.hcb.sys.service.impl;

import com.hcb.sys.entity.Zixun;
import com.hcb.sys.mapper.ZixunMapper;
import com.hcb.sys.service.IZixunService;
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
public class ZixunServiceImpl extends ServiceImpl<ZixunMapper, Zixun> implements IZixunService {
    @Override
    public String getUsernameById(Integer id) {
        String username = this.baseMapper.getCustomerByZixunId(id);
        return username;
    }

    @Override
    public void setZixunStatus(Integer id) {
        this.baseMapper.setZiXunStatus(id);
    }
}
