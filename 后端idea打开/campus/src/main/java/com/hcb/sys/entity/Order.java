package com.hcb.sys.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
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
@TableName("order_")
public class Order implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 订单编号
     */
    private String code;

    /**
     * 买家地址
     */
    private String address;

    /**
     * 支付状态，0：未支付，1：正在发货，2：已发货，3：已收货
     */
    private Integer status;

    /**
     * 买家id
     */
    private Integer cstid;


}
