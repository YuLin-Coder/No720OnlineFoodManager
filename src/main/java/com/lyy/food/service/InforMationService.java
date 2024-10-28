package com.lyy.food.service;

import com.lyy.food.pojo.InforMation;

import java.util.List;

/**
 * 资讯
 */
public interface InforMationService extends CrudService<InforMation> {

    /**
     * 资讯审核通过
     * @param zid
     */
    void shenhe(int zid);

    /**
     * 连带未审核的资讯
     * @return
     */
    List<InforMation> list1();

}
