package com.mall.app.service;

import java.util.List;
import java.util.Map;

import com.mall.app.bean.Goods;

public interface GoodsService {
	Goods selectGoods(int id);
	int getCountGoods();
	List<Goods> listPageGoods(Map<String, Object> map);
	boolean saveGoods(Goods goods);
	boolean immediateBuy(int addressId,int productId,int productNum);
}
