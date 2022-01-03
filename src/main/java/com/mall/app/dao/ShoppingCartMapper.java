package com.mall.app.dao;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.mall.app.bean.ShoppingCart;

@Repository
@Mapper
public interface ShoppingCartMapper {
	int findifexist(ShoppingCart shoppingCart);
	int saveShoppingCart(ShoppingCart shoppingCart);
	int updateShoppingCart(ShoppingCart shoppingCart);
	int removeShoppingCart(ShoppingCart shoppingCart);
	int getCountShoppingCart(Map<String, Object> map);
	List<ShoppingCart> listShoppingCart(Map<String, Object> map);
}
