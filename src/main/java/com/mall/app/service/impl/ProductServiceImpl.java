package com.mall.app.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.mall.app.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mall.app.bean.Product;
import com.mall.app.bean.ProductType;
import com.mall.app.dao.ProductMapper;
import com.mall.app.service.ProductService;

@Service
public class ProductServiceImpl implements ProductService {
	@Autowired
	private ProductMapper mapper;
	@Override
	public boolean addProduct(Product product) {
		product.setCreateTime(DateUtils.formatDateToString(new Date(),"yyyy-MM-dd HH:mm:ss"));
		product.setModifyTime(null);
		product.setSale(0);
		return mapper.addProduct(product);
	}
	@Override
	public boolean removeProduct(String[] pids) {
		return mapper.removeProduct(pids);
	}
	@Override
	public boolean updateProduct(Product product) {
		product.setModifyTime(DateUtils.formatDateToString(new Date(),"yyyy-MM-dd HH:mm:ss"));
		return mapper.updateProduct(product);
	}
	@Override
	public List<ProductType> listProduct(Map<String, Object> map) {
		return mapper.listProduct(map);
	}
	@Override
	public int getCountProduct(Map<String, Object> map) {
		return mapper.getCountProduct(map);
	}
	@Override
	public boolean setProductState(Map<String, Object> map) {
		return mapper.setProductState(map);
	}
	@Override
	public boolean setProductStorage(Map<String, Object> map) {
		return mapper.setProductStorage(map);
	}
	public boolean updateProductPic(Map<String, Object> map) {
		return mapper.updateProductPic(map);
	}

}
