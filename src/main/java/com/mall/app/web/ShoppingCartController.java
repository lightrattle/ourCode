package com.mall.app.web;

import java.util.HashMap;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mall.app.bean.Goods;
import com.mall.app.bean.ShoppingCart;
import com.mall.app.bean.User;
import com.mall.app.service.GoodsService;
import com.mall.app.service.ShoppingCartService;

@RestController
public class ShoppingCartController {
	@Autowired
	private ShoppingCartService shoppingCartService;
	@Autowired
	private GoodsService goodsService;
	@RequestMapping("/user/detail")
	public Goods   saveorder(int id){
		Goods goods=goodsService.selectGoods(id);
		return goods;
	}
	@RequestMapping("/user/saveShoppingCart")
	public boolean   saveCategory(ShoppingCart shoppingCart){
		User user = (User)SecurityUtils.getSubject().getSession().getAttribute("user");
		shoppingCart.setBuyerId(user.getUserId());
		System.out.println(shoppingCart.getProductId());
		System.out.println(shoppingCart.getNum());
		System.out.println(shoppingCart.getPrice());
		return shoppingCartService.saveShoppingCart(shoppingCart);
	}
	@RequestMapping("/user/immediateBuy")
	public boolean   immediateBuy(int addressId,int productId,int productNum){
		System.out.println(addressId);
		return goodsService.immediateBuy(addressId, productId, productNum);
	}
	@RequestMapping("/user/emptyShoppingcart")
	public boolean   emptyShoppingcart(int addressId,String productIds,String productNums){
		System.out.println(addressId+"  "+productIds+"  "+productNums);
		return shoppingCartService.emptyShoppingcart(addressId, productIds, productNums);
	}
	@RequestMapping("/user/removeShoppingCart")
	public boolean   removeShoppingCart(ShoppingCart shoppingCart){
		User user = (User)SecurityUtils.getSubject().getSession().getAttribute("user");
		shoppingCart.setBuyerId(user.getUserId());
		return shoppingCartService.removeShoppingCart(shoppingCart);
	}
	@RequestMapping("/user/listShoppingCart")
	public Map<String,Object> listShoppingCart(){
		Map<String,Object>  map=new HashMap<String,Object>();
		User user = (User)SecurityUtils.getSubject().getSession().getAttribute("user");
		map.put("buyer_id", user.getUserId());
		Map<String,Object>  result=new HashMap<String,Object>();
		result.put("code", 0);
		result.put("msg", "");
		result.put("count", shoppingCartService.getCountShoppingCart(map));
		result.put("data", shoppingCartService.listShoppingCart(map));
		return result;
	}
}
