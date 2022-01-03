package com.mall.app.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.mall.app.bean.Product;

@Repository
@Mapper
public interface ListProductMapper {
	int selectProductNumByType(@Param("productType")int productType);
	List<Product> selectProductsByType(@Param("typeId")int typeId, @Param("start")int start,
									   @Param("pageCapacity")int pageCapacity,@Param("goodname")String goodname);
	int selectProductNumByName(@Param("productName")String productName);
	List<Product> selectProductsByName(@Param("productName")String productName, @Param("start")int start,
									   @Param("pageCapacity")int pageCapacity);
	int selectProductNum();
	List<Product> selectProductsByIds(int[] ids);
}
