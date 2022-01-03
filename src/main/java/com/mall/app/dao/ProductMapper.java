package com.mall.app.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.mall.app.bean.Product;
import com.mall.app.bean.ProductType;

@Repository
@Mapper
public interface ProductMapper {
	public boolean addProduct(Product product);
	public boolean removeProduct(String[] pids);
	public boolean updateProduct(Product product);
	public List<ProductType> listProduct(Map<String,Object> map);
	public int getCountProduct(Map<String, Object> map);
	public boolean setProductState(Map<String, Object> map);
	public boolean setProductStorage(Map<String, Object> map);
	public boolean updateProductPic(Map<String, Object> map);
}
