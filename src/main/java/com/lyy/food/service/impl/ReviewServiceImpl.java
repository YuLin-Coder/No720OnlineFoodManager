package com.lyy.food.service.impl;

import com.lyy.food.dao.CustomerMapper;
import com.lyy.food.dao.ProductMapper;
import com.lyy.food.dao.ReviewMapper;
import com.lyy.food.pojo.Review;
import com.lyy.food.pojo.ReviewExample;
import com.lyy.food.service.ReviewService;
import com.lyy.food.pojo.Customer;
import com.lyy.food.pojo.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    private ReviewMapper reviewMapper;
    @Autowired
    private CustomerMapper customerMapper;
    @Autowired
    private ProductMapper productMapper;

    @Override
    public List<Review> list() {
        List<Review> reviews = reviewMapper.selectByExample(null);
        for (Review review:reviews){
            Customer customer = customerMapper.selectByPrimaryKey(review.getCstid());
            Product product = productMapper.selectByPrimaryKey(review.getPid());
            review.setCustomer(customer);
            review.setProduct(product);
        }
        return reviews;
    }

    @Override
    public List<Review> getReviewListByPid(int id) {
        ReviewExample example = new ReviewExample();
        example.createCriteria().andPidEqualTo(id);
        List<Review> reviews = reviewMapper.selectByExample(example);
        for (Review review:reviews){
            Customer customer = customerMapper.selectByPrimaryKey(review.getCstid());
            review.setCustomer(customer);
        }

        return reviews;
    }

    @Override
    public void del(int id) {
        reviewMapper.deleteByPrimaryKey(id);
    }

    @Override
    public Review get(int id) {
        return reviewMapper.selectByPrimaryKey(id);
    }

    @Override
    public void save(Review review) {
        reviewMapper.insert(review);
    }
}
