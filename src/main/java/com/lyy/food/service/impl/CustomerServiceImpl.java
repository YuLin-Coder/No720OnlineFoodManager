package com.lyy.food.service.impl;

import com.lyy.food.dao.CustomerMapper;
import com.lyy.food.pojo.Customer;
import com.lyy.food.pojo.CustomerExample;
import com.lyy.food.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    private CustomerMapper customerMapper;
    @Override
    public Customer foreLogin(Customer customer) {
        CustomerExample example = new CustomerExample();
        example.createCriteria().andNameEqualTo(customer.getName()).andPasswordEqualTo(customer.getPassword());
        List<Customer> customers = customerMapper.selectByExample(example);

        return customers.size()>0?customers.get(0):null;
    }

    @Override
    public void save(Customer customer) {
        customerMapper.insert(customer);
    }

    @Override
    public Customer get(int cstid) {
        return customerMapper.selectByPrimaryKey(cstid);
    }

    @Override
    public List<Customer> list() {
        return customerMapper.selectByExample(null);
    }

    @Override
    public void shezhihuiyuan(int id) {
        customerMapper.enableStatus(id);
    }

    @Override
    public Customer findByPhone(String phone) {
        return customerMapper.findByPhone(phone);
    }

    @Override
    public Customer findByName(String name) {
        return customerMapper.findByName(name);
    }

    @Override
    public void del(int id) {
        customerMapper.deleteByPrimaryKey(id);
    }


}
