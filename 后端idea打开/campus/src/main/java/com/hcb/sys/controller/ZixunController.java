package com.hcb.sys.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hcb.common.vo.Result;
import com.hcb.sys.entity.Role;
import com.hcb.sys.entity.Zixun;
import com.hcb.sys.service.IZixunService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author hcb
 * @since 2023-06-11
 */
@RestController
@RequestMapping("/zixun")
public class ZixunController {
    @Autowired
    private IZixunService zixunService;

    @GetMapping("/list")
    public Result<?> getZixunList(
            @RequestParam("pageNo") Long pageNo,
            @RequestParam("pageSize") Long pageSize) {

        Page<Zixun> page = new Page<>(pageNo, pageSize);
        zixunService.page(page);

        Map<String, Object> data = new HashMap<>();
        data.put("total", page.getTotal());
        data.put("rows", page.getRecords());

        return Result.success(data);
    }

    @PutMapping("/{id}")
    public Result<?> updataZixun(@PathVariable("id") Integer id) {
        zixunService.setZixunStatus(id);
        return Result.success("已审核");
    }

    @DeleteMapping("/{id}")
    public Result<Zixun> deleteZixunById(@PathVariable("id") Long id) {
        zixunService.removeById(id);
        return Result.success("删除资讯成功");

    }
}
