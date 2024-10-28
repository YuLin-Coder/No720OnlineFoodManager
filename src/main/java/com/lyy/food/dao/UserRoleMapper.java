package com.lyy.food.dao;

import com.lyy.food.pojo.UserRole;
import com.lyy.food.pojo.UserRoleExample;
import java.util.List;

public interface UserRoleMapper extends SysDao<UserRole>{

    List<UserRole> selectByExample(UserRoleExample example);

}