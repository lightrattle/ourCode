package com.mall.app.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface CollectMapper {

	public List listCollect(@Param("username") String username);

	public boolean addCollect(@Param("userId") Integer userId, @Param("productId") int productId);

    boolean removeCollect(@Param("userId") Integer userId, @Param("productId") int productId);

}
