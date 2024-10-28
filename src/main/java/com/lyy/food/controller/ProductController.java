package com.lyy.food.controller;

import com.lyy.food.pojo.Category;
import com.lyy.food.pojo.Product;
import com.lyy.food.pojo.ProductVO;
import com.lyy.food.pojo.User;
import com.lyy.food.service.CategoryService;
import com.lyy.food.service.ProductService;
import com.lyy.food.service.UserService;
import com.lyy.food.util.Page;
import com.lyy.food.util.UploadUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.security.auth.Subject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 商品模块controller
 */
@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductService productService;
    @Autowired
    private UserService userService;
    @Autowired
    private CategoryService categoryService;

    @RequestMapping("/list")
    public String list(Model model, Page page){
        PageHelper.offsetPage(page.getStart(),page.getCount());//分页查询
        List<Product> list= productService.list();
        int total = (int) new PageInfo<>(list).getTotal();//总条数
        page.setTotal(total);

        model.addAttribute("list",list);
        model.addAttribute("total",total);
        model.addAttribute("page", page);

        return "productmodule/product-list";
    }


    /**
     * 上架
     * @param id
     * @return
     */
    @RequestMapping("/enableStatus")
    @ResponseBody
    public Map<String,Object> enableStatus(@RequestParam(value = "id") Integer id){
        Map<String, Object> ret = new HashMap<>();
        Map<String, Object> queryMap = new HashMap<>();
        queryMap.put("id",id);
        queryMap.put("status",1);
        if(productService.editStatus(queryMap)<=0){
            ret.put("type","error");
            ret.put("message","状态修改失败");
            return ret;
        }
        ret.put("type","success");
        ret.put("message","状态修改成功");
        return ret;
    }

    /**
     * 修改状态
     * @param id
     * @return
     */
    @RequestMapping("/stopStatus")
    @ResponseBody
    public Map<String,Object> stopStatus(@RequestParam(value = "id") Integer id){
     Map<String, Object> ret = new HashMap<>();
        Map<String, Object> queryMap = new HashMap<>();
        queryMap.put("id",id);
        queryMap.put("status",0);
        if(productService.editStatus(queryMap)<=0){
            ret.put("type","error");
            ret.put("message","状态修改失败");
            return ret;
        }
        ret.put("type","success");
        ret.put("message","状态修改成功");
        return ret;
    }

    @RequestMapping("/productAddUI")
    public String addUI(Model model){

        List<Category> categoryList = categoryService.list();

        List<User> userList = userService.list();

        model.addAttribute("categoryList",categoryList);
        model.addAttribute("userList",userList);

        return "productmodule/product-add";
    }

    /**
     * 商品添加操作
     * @param product
     * @return
     */
    @ResponseBody
    @RequestMapping("/addProduct")
    public Map<String,Object> add(Product product, HttpServletRequest request) {
        Map<String, Object> ret = new HashMap<>();
        ret.put("type","error");
        if(StringUtils.isEmpty(product.getName())){
            ret.put("message","请填写商品名称");
            return ret;
        }
        if(StringUtils.isEmpty(product.getImageurl())){
            ret.put("message","请上传图片");
            return ret;
        }
        if(StringUtils.isEmpty(product.getMiaoshu())){
            ret.put("message","请填写描述");
            return ret;
        }
        Product byPName = productService.findByPName(product.getName());
        if(byPName!=null){
            ret.put("message","请商品名称已存在");
            return ret;
        }
        try{
            product.setNumber(0);
            User user = (User) request.getSession().getAttribute("adminUser");
            product.setBid(user.getId());
            productService.save(product);
        }catch (Exception e){
            ret.put("message","商品添加失败");
            return ret;
        }
        ret.put("type","success");
        ret.put("message","商品添加成功");
        return ret;
    }

    @RequestMapping("/deleteProduct")
    public String del(@RequestParam(value = "id")int id,HttpSession session){
        productService.del(id);
        String imageName = id+".jpg";
        File file = new File(session.getServletContext().getRealPath("/images/product"),imageName);
        file.delete();
        return "redirect:list";
    }

    /**
     * 商品编辑页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/editProduct")
    public String editUI(@RequestParam(value = "id")int id,Model model){
        //获得要修改商品的信息
        Product product = productService.get(id);
        model.addAttribute("product",product);
        List<Category> categoryList = categoryService.list();
        //通过商品id 返回所属分类
        Category category = categoryService.get(product.getCid());
        model.addAttribute("crrentCategory",category);
        //通过id返回所属商家
        model.addAttribute("categoryList",categoryList);

        return "productmodule/product-edit";
    }

    /**
     * 商品更新操作
     * @param product
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/updateProduct",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> update(Product product) {
        Map<String, Object> ret = new HashMap<>();
        ret.put("type","error");
        if(StringUtils.isEmpty(product.getName())){
            ret.put("message","请填写商品名称");
            return ret;
        }
        if(StringUtils.isEmpty(product.getImageurl())){
            ret.put("message","请上传图片");
            return ret;
        }
        if(StringUtils.isEmpty(product.getMiaoshu())){
            ret.put("message","请填写描述");
            return ret;
        }
        Product byPName = productService.findByPName(product.getName());
        if(byPName!=null){
            if(byPName.getId()!=product.getId()){
                ret.put("message","商品名称已重复");
                return ret;
            }
        }
        Product product1 = productService.get(product.getId());
        try{
            BeanUtils.copyProperties(product,product1,"status","number","bid");
            productService.update(product1);
        }catch (Exception e){
            ret.put("message","商品编辑失败");
            return ret;
        }
        ret.put("type","success");
        ret.put("message","商品编辑成功");
        return ret;

    }

}
