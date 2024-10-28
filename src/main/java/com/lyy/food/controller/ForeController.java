package com.lyy.food.controller;

import com.lyy.food.service.*;
import com.lyy.food.util.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lyy.food.pojo.*;
import com.lyy.food.util.StringUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 前台所有请求controller
 */
@Controller
@RequestMapping("/fore")
public class ForeController {

    @Autowired
    private ForeService foreService;
    @Autowired
    private ProductService productService;
    @Autowired
    private ReviewService reviewService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private CustomerService customerService;
    @Autowired
    private OrderItemService orderItemService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private InforMationService inforMationService;

    public String PNAME=null;

    /**
     * 前台首页
     * @param model
     * @return
     */
    @RequestMapping("/foreIndex")
    public String index(Model model,HttpSession session){

        //传入3个分类
        List<Category> categories = foreService.listToThree();
        List<Category> categories1 = categoryService.list();
        //给每个分类设置商品
        for (Category c:categories){
            List<Product> products = productService.getProductsByCid(c.getId());
            //如果分类下的商品超过4个，则只显示4个给前端
            if(products.size()>5){
                List<Product> products1 = new ArrayList<>();
                for(int i=0;i<=4;i++){
                    products1.add(products.get(i));
                }
                c.setProducts(products1);
            }else{
                c.setProducts(products);
            }
        }
        model.addAttribute("categories",categories);
        session.setAttribute("categories",categories1); //保存在session  使其他页面也能获取到分类列表 而不用每次都去查询
        return "forepage/index2";
    }


    /**
     * 商品详情跳转
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/foreDetailUI")
    public String detailUI(@RequestParam(value = "id")int id,Model model){
        Product product = productService.get(id);
        if(product==null) return "forepage/noPro";

        User user = productService.getUserByBid(product.getBid());
        Category category = productService.getCategoryByCid(product.getCid());
        product.setCategory(category);
        product.setUser(user);

        List<Product> fivePro = foreService.getFivePro();

        model.addAttribute("product",product);
        model.addAttribute("fivePro",fivePro);

        List<Review> list = reviewService.getReviewListByPid(id);
        model.addAttribute("reviews",list);
        model.addAttribute("rs",list.size());

        return "forepage/proDetail";
    }

    /**
     * 注册页面
     * @return
     */
    @RequestMapping("/foreRegisterUI")
    public String registerUI(){
        return "forepage/foreRegister";
    }

    /**
     * 登录页面
     * @return
     */
    @RequestMapping("/foreLoginUI")
    public String foreLoginUI(){
        return "forepage/forelogin";
    }



    /**
     * ajax判断客户是否登录
     * @param session
     * @return
     */
    @RequestMapping("/foreIsLogin")
    @ResponseBody
    public String isLogin(HttpSession session){
        Customer cst = (Customer) session.getAttribute("cst");
        return cst==null?"false":"true";
    }

    /**
     * 注册
     * @param customer
     * @return
     */
    @ResponseBody
    @RequestMapping("/foreRegister")
    public Map<String,Object> register(Customer customer){
        Map<String, Object> ret = new HashMap<>();
        ret.put("type","error");
        if(StringUtils.isEmpty(customer.getName())){
            ret.put("message","请填写姓名");
            return ret;
        }
        if(StringUtils.isEmpty(customer.getPassword())){
            ret.put("message","请填写密码");
            return ret;
        }
        if(StringUtils.isEmpty(customer.getAddress())){
            ret.put("message","请填写地址");
            return ret;
        }
        if(StringUtils.isEmpty(customer.getPhone())){
            ret.put("message","请填写手机号");
            return ret;
        }
        if(customerService.findByPhone(customer.getPhone())!=null){
            ret.put("message","该手机号已被注册");
            return ret;
        }
        if(customerService.findByName(customer.getName())!=null){
            ret.put("message","该用户名已存在");
            return ret;
        }
        customer.setStatus(0);
        customerService.save(customer);
        ret.put("type","success");
        ret.put("message","注册成功");
        return ret;
    }

    /**
     * 客户登录
     * @param customer
     * @param session
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/foreLogin",method = RequestMethod.POST)
    public Map<String,Object> foreLogin(Customer customer, HttpSession session){
        Map<String, Object> ret = new HashMap<>();
        ret.put("type","error");
        if(StringUtils.isEmpty(customer.getName())){
            ret.put("message","请填写用户名");
            return ret;
        }
        if(StringUtils.isEmpty(customer.getPassword())){
            ret.put("message","请填写密码");
            return ret;
        }
        Customer cst = customerService.foreLogin(customer);
        if (cst!=null){
            session.setAttribute("cst",cst);
           ret.put("type","success");
           ret.put("message","登录成功");
           return ret;
        }else {
            ret.put("message","用户名或者密码错误");
            return ret;
        }
    }

    /**
     * 用户登录返回信息
     * @return
     */
    @RequestMapping("/foreLoginMsg")
    public String foreLoginMsg(HttpServletRequest request){
        request.setAttribute("msg","true");
        return "forepage/forelogin";
    }

    /**
     * 客户注销
     * @param session
     * @return
     */
    @RequestMapping("/foreCstLoginOut")
    public String cstLoginOut(HttpSession session){
        session.setAttribute("cst",null);
        return "redirect:foreIndex";
    }

    /**
     * 立即购买
     * @param session
     * @param pid  商品id
     * @param number  商品数量
     * @return  重定向到支付 ， 传入订单项id
     */
    @RequestMapping("/forebuyone")
    public String forebuyone(HttpSession session,int pid,int number,float totalPrice){
        Customer cst = (Customer) session.getAttribute("cst");
        Product product = productService.get(pid);

        int oiid = 0;

        boolean find = false;
        List<OrderItem> orderItems = orderItemService.listByCustomer(cst.getId());//获得订单项表中该用户的所有订单id为空的订单项
        for (OrderItem oi : orderItems) {
            //基于用户对象customer，查询没有生成订单的订单项集合
            // 如果产品是一样的话，就进行数量追加
            if(oi.getProduct().getId().intValue()==product.getId().intValue()){
                //如果已经存在这个产品对应的OrderItem，并且还没有生成订单，即还在购物车中。 那么就应该在对应的OrderItem基础上，调整数量
                oi.setNumber(oi.getNumber()+number);
                orderItemService.update(oi);
                find = true;
                //获取这个订单项的 id
                oiid = oi.getId();
                break;
            }
        }
        //如果不存在对应的OrderItem,那么就新增一个订单项OrderItem
        if(!find){
            OrderItem oi = new OrderItem();
            oi.setCstid(cst.getId());
            oi.setNumber(number);
            oi.setPid(pid);
            orderItemService.save(oi);
            //获取这个刚添加的订单项的 id
            oiid = oi.getId();
        }

        return "redirect:forebuy?oiid="+oiid;
    }

    /**
     * 立即购买、购物车提交到订单页面调用  根据oiid计算订单项的总价、购买数量 ， 订单项放session
     * 订单-支付  上一次的购物信息会被下次单个挤掉  根据oiid获得订单项
     * @param model
     * @param oiid 立即购买生成的订单项id
     * @param session
     * @return 返回订单项集合   |   返回所有订单项加起来的总价
     */
    @RequestMapping("/forebuy")
    public String forebuy(Model model,String[] oiid,HttpSession session){
        System.out.println(oiid);

        List<OrderItem> ois = new ArrayList<>();

        Customer cst = (Customer)session.getAttribute("cst");

        float total = 0;
        int number = 0;
        if(oiid!=null){
            for (String strid : oiid) {
                int id = Integer.parseInt(strid);
                OrderItem oi= orderItemService.get(id);
                if (cst.getStatus()==1){
                    total +=oi.getProduct().getPrice()*0.8*oi.getNumber();
                }else{
                    total +=oi.getProduct().getPrice()*oi.getNumber();
                }
                number += oi.getNumber();
                ois.add(oi);
            }
        }
        /*
          累计这些ois的价格总数，赋值在total上
          把订单项集合放在session的属性 "ois" 上,方便下订单时候直接获取
          把总价格放在 model的属性 "total" 上
          服务端跳转到buy.jsp
          */
        session.setAttribute("ois", ois);
        model.addAttribute("total", total);
        model.addAttribute("number", number);

        return "forepage/foreBuy";
    }

    /**
     * 添加购物车
     * @param pid  商品id
     * @param number  购买数量
     * @param model
     * @param session
     * @return  boolean
     */
    @RequestMapping("/foreAddCart")
    @ResponseBody
    public String addCart(int pid, int number, Model model,float totalPrice,HttpSession session) {
        Customer customer =(Customer)  session.getAttribute("cst");
        if(customer==null){
            return "false";
        }
        Product p = productService.get(pid);

        boolean found = false;
        //获得订单项表中该用户的所有订单id为空的订单项
        List<OrderItem> ois = orderItemService.listByCustomer(customer.getId());
        for (OrderItem oi : ois) {
            //基于用户对象customer，查询没有生成订单的订单项集合
            // 如果产品是一样的话，就进行数量追加
            if(oi.getProduct().getId().intValue()==p.getId().intValue()){
                //如果已经存在这个产品对应的OrderItem，并且还没有生成订单，即还在购物车中。 那么就应该在对应的OrderItem基础上，调整数量
                oi.setNumber(oi.getNumber()+number);
                orderItemService.update(oi);
                found = true;
                break;
            }
        }
        //如果不存在对应的OrderItem,那么就新增一个订单项OrderItem
        if(!found){
            OrderItem oi = new OrderItem();
            oi.setCstid(customer.getId());
            oi.setNumber(number);
            oi.setPid(pid);
            orderItemService.save(oi);
        }

        return "success";
    }

    /**
     * 查看购物车购物车
     * @param model
     * @param session
     * @return
     */
    @RequestMapping("/forecart")
    public String cart( Model model,HttpSession session) {
        Customer customer =(Customer)  session.getAttribute("cst");
        //cstid等于当前登录用户id 并且oid为null的订单项
        List<OrderItem> ois = orderItemService.listByCustomer(customer.getId());
        //购物车没有商品
        if(ois==null || ois.size()==0){
            return "forepage/cart_noPro";
        }
        int totalProductNumber = 0;
        for (OrderItem oi:ois){
            totalProductNumber += oi.getNumber();
        }
        model.addAttribute("ois", ois);
        model.addAttribute("size", totalProductNumber);

        return "forepage/foreCart";
    }

    /**
     * 删除订单项
     * @param oiid 订单项id
     * @param session
     * @return
     */
    @RequestMapping("/foreDelOrderItem")
    @ResponseBody
    public String foreDelOrderItem(int oiid,HttpSession session){
        Customer customer = (Customer) session.getAttribute("cst");
        if(customer==null){
            return "noSuccess";
        }
        orderItemService.del(oiid);
        return "success";
    }

    /**
     * 生产订单操作
     * @param session
     * @return
     */
    @ResponseBody
    @RequestMapping("/addOrder")
    public  Map<String, Object> createOrder(Order order,HttpSession session){
        Map<String, Object> ret = new HashMap<>();
        ret.put("type","error");
        Customer customer =(Customer)  session.getAttribute("cst");
        order.setCode(StringUtil.randomNumber("od"));
        order.setCstid(customer.getId());
        order.setStatus(0);//未支付
        List<OrderItem> ois= (List<OrderItem>)  session.getAttribute("ois");
        //给每个订单项设置订单id  并且算出订单总价
        float total =orderService.add(order,ois);
        if(total<=0){
            ret.put("message","订单出现问题,请刷新");
            return ret;
        }
        ret.put("type","success");
        ret.put("oid",order.getId());
        ret.put("total",total);
        return ret;
    }

    /**
     * 支付成功跳转
     * @param oid 订单id
     * @param total 总价
     * @param model
     * @return
     */
    @RequestMapping("/forePayed")
    public String payed(int oid, float total, Model model) {
        Order order = orderService.get(oid);
        order.setStatus(1);
        orderService.update(order);
        model.addAttribute("total", total);

        return "forepage/forePayed";
    }

    /**
     * 我的订单  根据session查看当前用户的订单
     * @param model
     * @param session
     * @return
     */
    @RequestMapping("/forebought")
    public String forebought(Model model,HttpSession session){
        Customer customer = (Customer) session.getAttribute("cst");
        List<Order> os= orderService.list(customer.getId());

        //给每个订单的订单项设置属性值，如orderitem、product
        orderItemService.fill(os);

        model.addAttribute("os", os);
        return "forepage/foreBought";
    }

    /**
     * 搜索商品
     * @param model
     * @param pName
     * @return
     */
    @RequestMapping("/foreNameLike")
    public String foreNameLike(Model model, String pName,Page page){
        PageHelper.offsetPage(page.getStart(),page.getCount());//分页查询
        if(pName!=null) PNAME = pName;
        List<Product> products = productService.findByName(PNAME);
        int total = (int) new PageInfo<>(products).getTotal();//总条数
        page.setTotal(total);
        model.addAttribute("products",products);
        model.addAttribute("total",total);
        model.addAttribute("page", page);
        model.addAttribute("name",pName);
        model.addAttribute("proSize",products.size());

        return "forepage/proSeach";
    }

    /**
     * 显示分类下的商品
     * @param model
     * @param cid
     * @return
     */
    @RequestMapping("/foreFindCategory")
    public String foreFindCategory(Model model,@RequestParam(value = "id") int cid){
        List<Product> ps = productService.findByCid(cid);
        Category category = categoryService.get(cid);
        if(ps.size()>8){
            List<Product> ps1 = new ArrayList<>();
            for(int i=0;i<8;i++){
                ps1.add(ps.get(i));
            }
            model.addAttribute("products",ps1);
            model.addAttribute("category",category);
            return "forepage/proCategorySeach";
        }
        model.addAttribute("products",ps);
        model.addAttribute("proSize",ps.size());
        model.addAttribute("category",category);

        return "forepage/proCategorySeach";
    }

    @RequestMapping("/faq")
    public String faq(){
        return "forepage/faq";
    }

    /**
     * 商品评价
     * @param pid
     * @param model
     * @return
     */
    @RequestMapping("/forePingjia")
    public String forePingjia(int pid,Model model){

        return "forePage/pingjia";
    }

    /**
     * 商品评论
     * @param session
     * @param pid
     * @param content
     * @return
     */
    @RequestMapping(value = "/evaluate_product",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> cstPinglun(HttpSession session,int pid,String content){
        Map<String, Object> ret = new HashMap<>();
        ret.put("type","error");
        if(StringUtils.isEmpty(content)){
            content="未及时评价默认好评";
        }
        Customer cst = (Customer) session.getAttribute("cst");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String format = sdf.format(new Date());
        //string转date
        ParsePosition pos = new ParsePosition(0);
        Date strtodate = sdf.parse(format, pos);
        Review review = new Review();
        review.setCstid(cst.getId());
        review.setCustomer(cst);
        review.setPid(pid);
        review.setProduct(productService.get(pid));
        review.setContent(content);
        review.setCreatetime(strtodate);
        try{
            reviewService.save(review);
            ret.put("type","success");
            ret.put("message","评论成功");
            return ret;
        }catch (Exception e){
            ret.put("message","评论失败");
            return ret;
        }
    }

    /**
     * 已审核的资讯
     * @param model
     * @return
     */
    @RequestMapping("/information")
    public String zixun(Model model){
        List<InforMation> list = inforMationService.list();
        model.addAttribute("list",list);
        return "forepage/info_list";
    }

    /**
     * 发布资讯保存操作
     * @param info
     * @param session
     * @return
     */
    @RequestMapping(value = "/infoAdd",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> infoAdd(InforMation info,HttpSession session){
        Map<String, Object> ret = new HashMap<>();
        ret.put("type","error");
        if(StringUtils.isEmpty(info.getContent())){
            ret.put("message","请填写资讯信息");
            return ret;
        }
        Customer c = (Customer) session.getAttribute("cst");
        info.setCstid(c.getId());
        info.setFabudate(new Date());
        info.setStatus(0);
        try{
            inforMationService.save(info);
            ret.put("type","success");
            return ret;
        }catch (Exception e){
            ret.put("message","添加资讯信息失败");
            return ret;
        }

    }

}
