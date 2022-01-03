package com.mall.app.service;

import java.util.List;
import java.util.Map;

import com.mall.app.bean.ShoppingCart;

public interface ShoppingCartService {
	public boolean saveShoppingCart(ShoppingCart shoppingCart );
	List<ShoppingCart> listShoppingCart(Map<String, Object> map);
	int getCountShoppingCart(Map<String, Object> map);
	boolean removeShoppingCart(ShoppingCart shoppingCart);
	boolean emptyShoppingcart(int addressId,String productIds,String productNums);
}
