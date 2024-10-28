package com.lyy.food.service.impl;

import com.lyy.food.dao.CustomerMapper;
import com.lyy.food.dao.InforMationMapper;
import com.lyy.food.pojo.Customer;
import com.lyy.food.pojo.InforMation;
import com.lyy.food.pojo.InforMationExample;
import com.lyy.food.service.InforMationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InforMationServiceImpl implements InforMationService {

    @Autowired
    private InforMationMapper inforMationMapper;
    @Autowired
    private CustomerMapper customerMapper;

    @Override
    public List<InforMation> list() {
        InforMationExample example = new InforMationExample();
        example.createCriteria().andStatusEqualTo(1);
        List<InforMation> inforMation = inforMationMapper.selectByExample(example);
        for (InforMation z: inforMation){
            Customer customer =customerMapper.selectByPrimaryKey(z.getCstid());
            z.setCustomer(customer);
        }
        return inforMation;
    }

    @Override
    public void save(InforMation entity) {
        inforMationMapper.insert(entity);
    }

    @Override
    public void del(int id) {
        inforMationMapper.deleteByPrimaryKey(id);
    }

    @Override
    public InforMation get(int id) {
        return inforMationMapper.selectByPrimaryKey(id);
    }

    @Override
    public void shenhe(int zid) {
        inforMationMapper.shenhe(zid);
    }

    @Override
    public List<InforMation> list1() {
        List<InforMation> inforMation = inforMationMapper.selectByExample(null);
        for (InforMation z: inforMation){
            Customer customer =customerMapper.selectByPrimaryKey(z.getCstid());
            z.setCustomer(customer);
        }
        return inforMation;
    }
}
