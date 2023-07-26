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
public class Orderitem implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 商品id
     */
    private Integer pid;

    /**
     * 订单id
     */
    private Integer oid;

    /**
     * 买家id
     */
    private Integer cstid;

    /**
     * 数量
     */
    private Integer number;


}
