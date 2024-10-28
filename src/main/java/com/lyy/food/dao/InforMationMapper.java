package com.lyy.food.dao;

import com.lyy.food.pojo.InforMation;
import com.lyy.food.pojo.InforMationExample;

import java.util.List;

public interface InforMationMapper extends CrudDao<InforMation> {

    List<InforMation> selectByExample(InforMationExample example);

    /**
     * 资讯审核
     * @param zid
     */
    void shenhe(int zid);

}