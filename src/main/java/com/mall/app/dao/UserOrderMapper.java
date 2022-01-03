package com.mall.app.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface UserOrderMapper {
	public List<Map<String,Object>> listUserOrder(@Param("buyerId")int buyerId);
	public int getOrderNum(@Param("userId")int userId);
	public List<Map<String,Object>> listUserOrderByStatus(@Param("buyerId")int buyerId, @Param("status")int status);
	public int getOrderNumByStatus(@Param("userId")int userId, @Param("status")int status);
	public boolean userReceiveOrder(@Param("orderId")int orderId,@Param("buyerId")int buyerId);
	public String getLogisticName(@Param("logisticId")int logisticId);
}
