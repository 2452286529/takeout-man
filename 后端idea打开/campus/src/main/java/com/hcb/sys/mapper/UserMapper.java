package com.hcb.sys.mapper;

import com.hcb.sys.entity.User;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author hcb
 * @since 2023-06-11
 */
public interface UserMapper extends BaseMapper<User> {

    public List<String> getRoleNameByUserId(Long userId);

}
