package com.hcb.sys.mapper;

import com.hcb.sys.entity.Zixun;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author hcb
 * @since 2023-06-11
 */
public interface ZixunMapper extends BaseMapper<Zixun> {
    public String getCustomerByZixunId(Integer id);

    void setZiXunStatus(Integer id);
}
