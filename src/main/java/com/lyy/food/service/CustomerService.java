package com.lyy.food.service;

import com.lyy.food.pojo.Customer;
import org.apache.ibatis.annotations.Param;

public interface CustomerService extends CrudService<Customer>{

    /**
     * 返回登录的用户
     * @param customer
     * @return
     */
    public Customer foreLogin(Customer customer);

    /**
     * 设置会员
     * @param id
     */
    public void shezhihuiyuan(int id);
    /**
     * 根据手机号查询客户
     * @param phone
     * @return
     */
    Customer findByPhone(String phone);

    /**
     * 根据用户名查询用户
     * @param name
     * @return
     */
    Customer findByName(String name);
}
