package com.lyy.food.dao;

import com.lyy.food.pojo.Customer;
import com.lyy.food.pojo.CustomerExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CustomerMapper extends CrudDao<Customer>{

    List<Customer> selectByExample(CustomerExample example);

    /**
     * 开启用户会员状态
     * @param id
     */
    void enableStatus(int id);

    /**
     * 根据手机号查询客户
     * @param phone
     * @return
     */
    Customer findByPhone(@Param("phone")String phone);

    Customer findByName(@Param("name")String name);
}