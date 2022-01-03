package com.mall.app.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface AppraiseMapper {
//列表和添加评论功能
    public List listAppraise(@Param("productId") int productId);
    public boolean addAppraise(@Param("userId") Integer userId,
                               @Param("productId") int productId,
                               @Param("app_detail") String app_detail);
}
