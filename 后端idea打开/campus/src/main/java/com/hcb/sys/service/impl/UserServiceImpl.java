package com.hcb.sys.service.impl;

import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.hcb.common.utils.JwtUtil;
import com.hcb.sys.entity.User;
import com.hcb.sys.mapper.UserMapper;
import com.hcb.sys.service.IUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author hcb
 * @since 2023-06-11
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private JwtUtil jwtUtil;

    @Override
    public Map<String, Object> login(User user) {
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getUsername, user.getUsername());
        User loginUser = this.baseMapper.selectOne(wrapper);

        if (loginUser != null && passwordEncoder.matches(user.getPassword(), loginUser.getPassword())) {
//            String key = "user: " + UUID.randomUUID();

            loginUser.setPassword(null);
//            redisTemplate.opsForValue().set(key, loginUser, 30, TimeUnit.MINUTES);
            String token = jwtUtil.createToken(loginUser);
            Map<String, Object> data = new HashMap<>();
            data.put("token", token);
            return data;
        }
        return null;
    }

    @Override
    public Map<String, Object> getUserInfo(String token) {
//        Object obj = redisTemplate.opsForValue().get(token);
        User loginUser = null;
        try {
            loginUser = jwtUtil.parseToken(token, User.class);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (loginUser != null) {
//             loginUser = JSON.parseObject(JSON.toJSONString(obj), User.class);
            Map<String, Object> data = new HashMap<>();
            data.put("name", loginUser.getUsername());
            List<String> roleList = this.baseMapper.getRoleNameByUserId(loginUser.getId());
            data.put("roles", roleList);

            return data;
        }
        return null;
    }

    @Override
    public void logout(String token) {
//        redisTemplate.delete(token);

    }
}
