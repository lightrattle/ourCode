package com.mall.app.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.mall.app.bean.Address;
import com.mall.app.dao.AddressMapper;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mall.app.bean.Goods;
import com.mall.app.bean.User;
import com.mall.app.dao.GoodsMapper;
import com.mall.app.service.GoodsService;
@Service
@Transactional
public class GoodsServiceImpl implements GoodsService {
	@Autowired
	private GoodsMapper goodsMapper;
	@Autowired
	private AddressMapper addressMapper;
	public boolean saveGoods(Goods goods) {
		goods.setCreate_time(new SimpleDateFormat("yyy-MM-dd HH:mm:ss").format(new Date()));
		return goodsMapper.saveGoods(goods)>0;
	}
	public int getCountGoods() {
		return goodsMapper.getCountGoods();
	}
	public List<Goods> listPageGoods(Map<String, Object> map) {
		return goodsMapper.listPageGoods(map);
	}
	@Override
	public Goods selectGoods(int id) {
		return goodsMapper.selectGoods(id);
	}
	@Override
	@Transactional
	public boolean immediateBuy(int addressId, int productId, int productNum) {
		Address address = addressMapper.selectAddress(addressId);
		String addressname = address.getProvince()+address.getCity()+address.getCounty()+address.getAddress_detail();
		Goods goods = goodsMapper.selectGoods(productId);
		boolean ret1;
		if (goods.getStorage() >= productNum) {
			ret1 = goodsMapper.updateProductNum(productNum, productId);
		}else{
			return false;
		}
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Boolean ret2 = goodsMapper.insertOrder(productId, productNum, goods.getPrice(), user.getUserId(), goods.getSeller_id(), addressname,formatter.format(date));
		return ret1&&ret2;
	}
}
