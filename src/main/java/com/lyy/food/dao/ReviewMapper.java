package com.lyy.food.dao;

import com.lyy.food.pojo.Review;
import com.lyy.food.pojo.ReviewExample;
import java.util.List;

public interface ReviewMapper extends CrudDao<Review>{

    List<Review> selectByExample(ReviewExample example);

}