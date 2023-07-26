package com.hcb.sys.service;

import com.hcb.sys.entity.Zixun;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author hcb
 * @since 2023-06-11
 */
public interface IZixunService extends IService<Zixun> {
    public String getUsernameById(Integer id);
    public void setZixunStatus(Integer id);
}
