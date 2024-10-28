package com.lyy.food.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/upload")
public class UploadController {
    /**
     * 上传图片
     * @param photo
     * @param request
     * @return
     */
    @RequestMapping(value="/upload_photo",method=RequestMethod.POST)
    @ResponseBody
    public Map<String, String> uploadPhoto(MultipartFile photo, HttpServletRequest request){
        Map<String, String> ret = new HashMap<String, String>();
        if(photo == null){
            ret.put("type", "error");
            ret.put("msg", "请上传图片");
            return ret;
        }
        if(photo.getSize() > 1024*1024*1024){
            ret.put("type", "error");
            ret.put("msg", "图片大小不能大于1MB");
            return ret;
        }

        String suffix = photo.getOriginalFilename().substring(photo.getOriginalFilename().lastIndexOf(".")+1,photo.getOriginalFilename().length());
        if(!"jpg,jpeg,gif,png".toUpperCase().contains(suffix.toUpperCase())){
            ret.put("type", "error");
            ret.put("msg", "请上传图片类型");
            return ret;
        }
        String savePath = request.getServletContext().getRealPath("/") + "/images/product/";
        File savePathFile = new File(savePath);
        if(!savePathFile.exists()){
            savePathFile.mkdir();
        }
        String filename = new Date().getTime()+"."+suffix;
        try {
            photo.transferTo(new File(savePath+filename));
        }catch (Exception e) {
            // TODO Auto-generated catch block
            ret.put("type", "error");
            ret.put("msg", "上传失败");
            e.printStackTrace();
            return ret;
        }
        ret.put("type", "success");
        ret.put("msg", "上传成功");
        ret.put("filepath",request.getServletContext().getContextPath() + "/images/product/" + filename );
        return ret;
    }
}
