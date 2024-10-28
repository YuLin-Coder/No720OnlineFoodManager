package com.lyy.food.service.impl;

import com.lyy.food.dao.CategoryMapper;
import com.lyy.food.dao.ProductMapper;
import com.lyy.food.pojo.Category;
import com.lyy.food.pojo.CategoryExample;
import com.lyy.food.pojo.Product;
import com.lyy.food.service.ForeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ForeServiceImpl implements ForeService {

    @Autowired
    private CategoryMapper categoryMapper;
    @Autowired
    private ProductMapper productMapper;

    @Override
    public List<Category> listToThree() {
        CategoryExample example = new CategoryExample();
        example.createCriteria().andIdBetween(1,4); //从1开始计数
        List<Category> categories = categoryMapper.selectByExample(example);
        return categories;
    }

    @Override
    public List<Product> getFivePro() {
        return productMapper.randFive();
    }


}
