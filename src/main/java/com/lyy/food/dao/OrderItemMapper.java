package com.lyy.food.dao;

import com.lyy.food.pojo.OrderItem;
import com.lyy.food.pojo.OrderItemExample;

import java.util.List;

public interface OrderItemMapper extends CrudDao<OrderItem>{

    List<OrderItem> selectByExample(OrderItemExample example);

}