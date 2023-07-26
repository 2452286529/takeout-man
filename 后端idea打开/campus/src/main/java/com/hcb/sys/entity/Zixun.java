package com.hcb.sys.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 
 * </p>
 *
 * @author hcb
 * @since 2023-06-11
 */
@Data
public class Zixun implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 资讯内容
     */
    private String content;

    /**
     * 客户id
     */
    private Integer cstid;

    /**
     * 审核状态，1：通过，0：未通过;
     */
    private Integer status;

    /**
     * 发布时间;
     */
    private LocalDateTime fabudate;

}
