package com.hcb;


import com.hcb.common.utils.JwtUtil;
import com.hcb.sys.entity.User;
import io.jsonwebtoken.Claims;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class JwtUtilTest {
    @Autowired
    private JwtUtil jwtUtil;

    @Test
    public void testCreateJwt(){
        User user = new User();
        user.setUsername("zhangsan");
        user.setPhone("12399988877");
        String token = jwtUtil.createToken(user);
        System.out.println(token);
    }

    @Test
    public void testParseJwt(){
        String token="eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJhYjQ5NjI5OS1hYzc5LTQyZWQtYWE5MC04NGJlYjE0ODM1ZTUiLCJzdWIiOiJ7XCJwaG9uZVwiOlwiMTIzOTk5ODg4NzdcIixcInVzZXJuYW1lXCI6XCJ6aGFuZ3NhblwifSIsImlzcyI6InN5c3RlbSIsImlhdCI6MTY4NjY0MDc1NywiZXhwIjoxNjg2NjQyNTU3fQ.9OHDlziUODAkdjdHJcBqK6Kt4tPMvKcI1TNeUWf4Ybg";
        Claims claims = jwtUtil.parseToken(token);
        System.out.println(claims);
    }

    @Test
    public void testParseJwt2(){
        String token="eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJhYjQ5NjI5OS1hYzc5LTQyZWQtYWE5MC04NGJlYjE0ODM1ZTUiLCJzdWIiOiJ7XCJwaG9uZVwiOlwiMTIzOTk5ODg4NzdcIixcInVzZXJuYW1lXCI6XCJ6aGFuZ3NhblwifSIsImlzcyI6InN5c3RlbSIsImlhdCI6MTY4NjY0MDc1NywiZXhwIjoxNjg2NjQyNTU3fQ.9OHDlziUODAkdjdHJcBqK6Kt4tPMvKcI1TNeUWf4Ybg";
        User user = jwtUtil.parseToken(token,User.class);
        System.out.println(user);
    }
}
