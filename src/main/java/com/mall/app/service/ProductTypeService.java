package com.mall.app.service;

import java.util.List;
import java.util.Map;

import com.mall.app.bean.ProductType;

public interface ProductTypeService {
	public boolean addProductType(String productTypeName);
	public boolean removeProductType(String[] pids);
	public boolean updateProductType(ProductType productType);
	public List<ProductType> listProductType(Map<String,Object> map);
	public int getCountProductType();
}
