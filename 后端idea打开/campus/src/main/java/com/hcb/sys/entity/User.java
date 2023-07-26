package com.hcb.sys.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 
 * </p>
 *
 * @author hcb
 * @since 2023-06-11
 */
@Data
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 管理员姓名
     */
    private String username;

    /**
     * 管理员密码
     */
    private String password;


    /**
     * 状态，1：启用，0：停用
     */
    private Integer status;

    /**
     * 商家管理员地址
     */
    private String address;

    private String phone;

    /**
     * 最后登陆时间
     */
    private Date lasttime;

    /*public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    public String getName() {
        return username;
    }

    public void setName(String username) {
        this.username = username;
    }
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }
    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
    public LocalDateTime getLasttime() {
        return lasttime;
    }

    public void setLasttime(LocalDateTime lasttime) {
        this.lasttime = lasttime;
    }

    @Override
    public String toString() {
        return "User{" +
            "id=" + id +
            ", name=" + username +
            ", password=" + password +
            ", salt=" + salt +
            ", status=" + status +
            ", address=" + address +
            ", phone=" + phone +
            ", lasttime=" + lasttime +
        "}";
    }*/
}
