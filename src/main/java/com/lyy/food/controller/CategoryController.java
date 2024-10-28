package com.lyy.food.controller;

import com.lyy.food.pojo.Category;
import com.lyy.food.service.CategoryService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 商品分类模块controller
 */
@Controller
@RequestMapping("/category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @RequestMapping("/list")
    public String list(Model model){
        List<Category> list = categoryService.list();
        model.addAttribute("list",list);
        model.addAttribute("size",list.size());
        return "productmodule/category-list";
    }

    /**
     * 添加分类操作
     * @param name
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/addCategory",method = RequestMethod.POST)
    public Map<String,Object> add(@RequestParam(value = "name")String name){
        Map<String, Object> ret = new HashMap<>();
        ret.put("type","error");
        if(StringUtils.isEmpty(name)){
        ret.put("message","请填写分类名称");
            return ret;
        }
        Category category = new Category();
        category.setName(name);
        try{
            categoryService.save(category);
        }catch (Exception e){
            ret.put("message","分类添加失败");
            return ret;
        }
        ret.put("type","success");
        ret.put("message","分类添加成功");
        return ret;
    }

    @RequestMapping("/delCategory")
    public String del(@RequestParam(value = "id")int id){
        categoryService.del(id);
        return "redirect:list";
    }

    @RequestMapping("/editCategory")
    public String edit(@RequestParam(value = "id")int id,Model model){
        Category category = categoryService.get(id);
        model.addAttribute("category",category);
        return "productmodule/category-edit";
    }

    @RequestMapping("/updateCategory")
    public String update(Category category,Model model){
        categoryService.update(category);
        return "redirect:list";
    }
}
