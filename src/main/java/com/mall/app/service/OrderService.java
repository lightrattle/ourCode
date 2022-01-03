package com.mall.app.service;

import java.util.List;
import java.util.Map;

import com.mall.app.bean.Order;

public interface OrderService {
	public boolean addOrder(Order order);
	public boolean removeOrder(String[] oids);
	public boolean updateOrder(Order order);
	public List<Order> listOrder(Map<String,Object> map);
	public int getCountOrder(Map<String, Object> buyerId);
	public int getOrderStatus(int orderId);
}
