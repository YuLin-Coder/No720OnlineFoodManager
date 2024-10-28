package com.lyy.food.dao;

import com.lyy.food.pojo.Product;
import com.lyy.food.pojo.ProductExample;
import com.lyy.food.pojo.ProductVO;

import java.util.List;
import java.util.Map;

public interface ProductMapper extends CrudDao<Product>{

    List<Product> selectByExample(ProductExample example);

    /**
     * 商品上线
     * @param name
     */
    void enableStatus(String name);

    /**
     * 商品下线
     * @param name
     */
    void stopStatus(String name);

    /**
     * 设置图片保存的位置
     * @param vo
     */
    void setImageUrl(ProductVO vo);

    /**
     * 随机五条商品
     * @return
     */
    List<Product> randFive();

    boolean findProByCid(int cid);

    /**
     * 根据名称查询
     * @param name
     * @return
     */
    Product findByPName(String name);

    Integer editStatus(Map<String,Object> queryMap);
}