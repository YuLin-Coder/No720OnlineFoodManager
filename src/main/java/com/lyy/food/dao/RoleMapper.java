package com.lyy.food.dao;

import com.lyy.food.pojo.Role;
import com.lyy.food.pojo.RoleExample;

import java.util.List;

public interface RoleMapper extends SysDao<Role> {

    List<Role> selectByExample(RoleExample example);

}