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
public class Product implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 商品名称
     */
    private String name;

    /**
     * 价格
     */
    private Float price;

    /**
     * 赞
     */
    private Integer zan;

    /**
     * 销量
     */
    private Integer number;

    /**
     * 状态，1：上线，0：下线
     */
    private Integer status;

    /**
     * 商品图片url
     */
    private String imageurl;

    /**
     * 商品描述
     */
    private String miaoshu;

    /**
     * 分类id
     */
    private Integer cid;

    /**
     * 商家id
     */
    private Long bid;


}
