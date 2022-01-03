package com.mall.app.service;

import java.util.List;
import java.util.Map;

import com.mall.app.bean.Product;
import com.mall.app.bean.ProductType;

public interface ProductService {
	public boolean addProduct(Product product);
	public boolean removeProduct(String[] pids);
	public boolean updateProduct(Product product);
	public List<ProductType> listProduct(Map<String,Object> map);
	public int getCountProduct(Map<String, Object> map);
	public boolean setProductState(Map<String, Object> map);
	public boolean setProductStorage(Map<String, Object> map);
	public boolean updateProductPic(Map<String, Object> map);
}
