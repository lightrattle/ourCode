package com.mall.app.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.mall.app.bean.ProductType;

@Repository
@Mapper
public interface ProductTypeMapper {
	public boolean addProductType(String productTypeName);
	public boolean removeProductType(String[] pids);
	public boolean updateProductType(ProductType productType);
	public List<ProductType> listProductType(Map<String,Object> map);
	public int getCountProductType();
}
