package com.lyy.food.dao;

import com.lyy.food.pojo.RolePermission;
import com.lyy.food.pojo.RolePermissionExample;

import java.util.List;

public interface RolePermissionMapper extends SysDao<RolePermission>{

    List<RolePermission> selectByExample(RolePermissionExample example);

}