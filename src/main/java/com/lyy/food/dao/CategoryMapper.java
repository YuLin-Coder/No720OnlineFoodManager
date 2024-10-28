package com.lyy.food.dao;

import com.lyy.food.pojo.Category;
import com.lyy.food.pojo.CategoryExample;

import java.util.List;

public interface CategoryMapper extends CrudDao<Category>{

     List<Category> selectByExample(CategoryExample example);

}