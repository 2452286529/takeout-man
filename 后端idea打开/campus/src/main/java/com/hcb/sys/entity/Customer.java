package com.hcb.sys.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author hcb
 * @since 2023-06-11
 */
@Data
public class Customer implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 用户名
     */
    private String username;

    /**
     * 密码
     */
    private String password;

    /**
     * 买家地址
     */
    private String address;

    /**
     * 买家联系方式
     */
    private String phone;

    /**
     * 状态，0：普通用户，1：会员
     */
    private Integer status;

    /*public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
    public String getName() {
        return username;
    }

    public void setName(String name) {
        this.username = name;
    }
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
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
    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Customer{" +
            "id=" + id +
            ", name=" + username +
            ", password=" + password +
            ", address=" + address +
            ", phone=" + phone +
            ", status=" + status +
        "}";
    }*/
}
