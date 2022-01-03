package com.mall.app.web;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mall.app.service.impl.UserOrderServiceImpl;

@RestController
public class UserOrderController {
	@Autowired
	private UserOrderServiceImpl service;
	@RequestMapping("/listUserOrder")
	public List<Map<String,Object>> listUserOrder(/*int pageNo,int pageCapacity,*/int status) {
		return service.listUserOrder(/*pageNo, pageCapacity,*/ status);
	}
	@RequestMapping("/receiveProduct")
	public boolean receiveProduct(int orderId){
		System.out.println(orderId);
		return service.receiveProduct(orderId);
	}
	@RequestMapping("/getUserOrderNum")
	public int getUserOrderNum(int status){
		return service.getOrderNum(status);
	}
	@RequestMapping("/getLogisticName")
	public String getLogisticName(int logisticId){
		System.out.println(logisticId);
		return service.getLogisticName(logisticId);
	}
}
