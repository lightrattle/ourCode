package com.mall.app.service;

import java.util.List;
import java.util.Map;

public interface UserOrderService {
	List<Map<String,Object>> listUserOrder(int status);
	boolean receiveProduct(int orderId);
	int getOrderNum(int status);
	String getLogisticName(int logisticId);
}
