package com.lyy.food.controller;

import com.lyy.food.pojo.User;
import com.lyy.food.service.UserService;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 后台登录
 */
@Controller
@RequestMapping("/admin/login")
public class LoginController {

    @Autowired
    UserService userService;

    @RequestMapping("/login")
    public String login(){
        return "login";
    }

    /**
     * 后台登录页面
     * @param
     * @param name
     * @param password
     * @return
     */
    @RequestMapping(value="/login",method=RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> login(@RequestParam(name = "name") String name,@RequestParam(name="password") String password){//throws ParseException
        Map<String, Object> ret = new HashMap<>();
        ret.put("type","error");
        if(StringUtils.isEmpty(name)){
            ret.put("message","请填写用户名");
            return ret;
        }
        if(StringUtils.isEmpty(password)){
            ret.put("message","请填写密码");
            return ret;
        }
        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(name,password);
        try {
            subject.login(token);
            User us = userService.getByName(name);
            String lastLoginTime = "";
            if(us!=null){
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                //上次时间
                Date time = us.getLasttime();
                lastLoginTime = sdf.format(time);
                //新时间
                String format = sdf.format(new Date());
                //string转date  不处理时间格式会不理想
                ParsePosition pos = new ParsePosition(0);
                Date strtodate = sdf.parse(format, pos);
                us.setLasttime(strtodate);
                userService.update(us);
            }
            if (us.getStatus()==1){
                Session session=subject.getSession();
                session.setAttribute("subject", subject);
                session.setAttribute("adminUser",us);
                session.setAttribute("lastLoginTime",lastLoginTime);
            }else {
                ret.put("message","账号已被停用");
                return ret;
            }
        } catch (AuthenticationException e) {
            ret.put("message","验证失败,无权限");
            return ret;
        }
        ret.put("type","success");
        return ret;
    }

}