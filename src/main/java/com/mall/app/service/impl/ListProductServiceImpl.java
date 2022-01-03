package com.mall.app.service.impl;

import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mall.app.bean.Product;
import com.mall.app.dao.ListProductMapper;
import com.mall.app.service.ListProductService;
import org.springframework.util.StringUtils;

@Service
public class ListProductServiceImpl implements ListProductService {
	@Autowired
	private ListProductMapper listProductMapper;
	@Override
	public List<Product> listPageProductByType(int typeId, int pageNo, int pageCapacity,String goodname) {
		if(!StringUtils.isEmpty(goodname)){
			goodname = "%"+goodname+"%";
		}
		return listProductMapper.selectProductsByType(typeId, (pageNo-1)*pageCapacity, pageCapacity,goodname);
	}
	@Override
	public List<Product> listPageProductByName(String productName, int pageNo, int pageCapacity) {
		return listProductMapper.selectProductsByName(productName, (pageNo-1)*pageCapacity, pageCapacity);
	}
	@Override
	public List<Product> listRandomProduct(int capacity) {
		int productNum;
		productNum = listProductMapper.selectProductNum();//获取商品总数
		Random ran = new Random(1);//生成随机数
		int[] array = new int[capacity];
		for(int i=0; i<capacity; i++){
			array[i] = ran.nextInt(productNum);
		}
		return listProductMapper.selectProductsByIds(array);
	}
	@Override
	public int getProductNum(String productName, int productTypeId){
		System.out.println(productName);
		if(productName != null && !productName.isEmpty() && !productName.equals("null")){
			System.out.println(productName);
			return listProductMapper.selectProductNumByName(productName);
		}else if(productTypeId > 0){
			return listProductMapper.selectProductNumByType(productTypeId);
		}else{
			return listProductMapper.selectProductNum();
		}
	}
}
