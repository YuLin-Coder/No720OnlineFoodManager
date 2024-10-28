package com.lyy.food.dao;

import com.lyy.food.pojo.Permission;
import com.lyy.food.pojo.PermissionExample;

import java.util.List;

public interface PermissionMapper extends SysDao<Permission>{

    List<Permission> selectByExample(PermissionExample example);

}