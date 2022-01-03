package com.mall.app.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mall.app.bean.Order;
import com.mall.app.dao.OrderMapper;
import com.mall.app.service.OrderService;

@Service
public class OrderServiceImpl implements OrderService {
	@Autowired
	private OrderMapper orderMapper;
	@Override
	public boolean addOrder(Order order) {
		return orderMapper.addOrder(order);
	}
	@Override
	public boolean removeOrder(String[] oids) {
		return orderMapper.removeOrder(oids);
	}
	@Override
	public boolean updateOrder(Order order) {
		return orderMapper.updateOrder(order);
	}
	@Override
	public List<Order> listOrder(Map<String, Object> map) {
		return orderMapper.listOrder(map);
	}
	@Override
	public int getCountOrder(Map<String, Object> map) {
		return orderMapper.getCountOrder(map);
	}
	@Override
	public int getOrderStatus(int orderId) {
		return orderMapper.getOrderStatus(orderId);
	}
}
