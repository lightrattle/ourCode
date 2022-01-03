package com.mall.app.web;

import java.util.HashMap;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mall.app.bean.Order;
import com.mall.app.bean.User;
import com.mall.app.service.impl.OrderServiceImpl;

@RestController
@RequestMapping("/order")
public class OrderController {
	@Autowired
	private OrderServiceImpl impl;
	@RequestMapping("/addOrder")
	public boolean addOrder(Order order) {return impl.addOrder(order);}
	@RequestMapping("/removeOrder")
	public boolean removeOrder(@RequestParam("oids[]")String[] oids) {return impl.removeOrder(oids);}
	@RequestMapping("/updateOrder")
	public boolean updateOrder(Order order) {return impl.updateOrder(order);}
	@RequestMapping("/listOrder")
	public Map<String, Object> listOrder(int page,int limit) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", (page-1)*limit );
		map.put("size", limit );
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		map.put("sellerId", user.getUserId());
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0 );
		result.put("msg", "" );
		result.put("count", impl.getCountOrder(map));
		result.put("data", impl.listOrder(map));
		return result;
	}
	@RequestMapping("/getCountOrder")
	public int getCountOrder(int buyerId) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		map.put("sellerId", user.getUserId());
		return impl.getCountOrder(map);
	}
	@RequestMapping("/getOrderStatus")
	public int getOrderStatus(int orderId){return impl.getOrderStatus(orderId);}
}
