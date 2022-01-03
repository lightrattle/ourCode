package com.mall.app.service;

import java.util.List;

import com.mall.app.bean.Product;

public interface ListProductService {
	List<Product> listPageProductByType(int typeId, int pageNo, int pageCapacity,String goodname);
	List<Product> listPageProductByName(String productName, int pageNo, int pageCapacity);
	List<Product> listRandomProduct(int capacity);
	int getProductNum(String productName, int productTypeId);
}
