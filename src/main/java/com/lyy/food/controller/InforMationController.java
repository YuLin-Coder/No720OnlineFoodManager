package com.lyy.food.controller;

import com.lyy.food.pojo.InforMation;
import com.lyy.food.service.InforMationService;
import com.lyy.food.util.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/info")
public class InforMationController {

    @Autowired
    private InforMationService inforMationService;

    /**
     * 资讯列表
     * @param page
     * @param model
     * @return
     */
    @RequestMapping("/list")
    public String list(Page page, Model model){
        PageHelper.offsetPage(page.getStart(),page.getCount());//分页查询
        List<InforMation> list = inforMationService.list1();
        int total = (int) new PageInfo<>(list).getTotal();//总条数
        page.setTotal(total);
        model.addAttribute("list",list);
        model.addAttribute("totals",total);
        return "cstpage/info_list";
    }

    /**
     * 审核
     * @param zid
     * @return
     */
    @RequestMapping("/zixunshenhe")
    @ResponseBody
    public String zixunshenhe(int zid){
        inforMationService.shenhe(zid);
        return "success";
    }

    @RequestMapping("/del")
    public String del(int id){
        inforMationService.del(id);
        return "redirect:list";
    }

}
