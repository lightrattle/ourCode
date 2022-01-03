package com.mall.app.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.mall.app.bean.Order;

@Repository
@Mapper
public interface OrderMapper {
	public boolean addOrder(Order order);
	public boolean removeOrder(String[] oids);
	public boolean updateOrder(Order order);
	public List<Order> listOrder(Map<String,Object> map);
	public int getCountOrder(Map<String, Object> map);
	public int getOrderStatus(@Param(value="orderId")int orderId);
}
