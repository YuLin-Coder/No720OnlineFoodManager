package com.lyy.food.dao;

import com.lyy.food.pojo.Order;
import com.lyy.food.pojo.OrderExample;
import java.util.List;

public interface OrderMapper extends CrudDao<Order>{

    List<Order> selectByExample(OrderExample example);

}