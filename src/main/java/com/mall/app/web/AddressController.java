package com.mall.app.web;

import java.util.HashMap;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mall.app.bean.Address;
import com.mall.app.bean.User;
import com.mall.app.service.AddressService;

@RestController
public class AddressController {
	@Autowired
	private AddressService addressService;
	//显示一页地址
	@RequestMapping("user/address/listPageAddress")
	public Map<String,Object> listPageCategory(int page,int limit,String user_id){
		Map<String,Object>  map=new HashMap<String,Object>();
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		map.put("page", (page-1)*limit);
		map.put("size", limit);
		map.put("user_id", user.getUserId());
		Map<String,Object>  result=new HashMap<String,Object>();
		result.put("code", 0);
		result.put("msg", "");
		result.put("count", addressService.getCountAddress(map));
		result.put("data", addressService.listPageAddress(map));
		return result;
	}
	@RequestMapping("/user/address/saveAddress")
	public boolean   saveCategory(Address address){
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		address.setUser_id(user.getUserId());
		return addressService.saveAddress(address);
	}
	@RequestMapping("user/address/updateAddress")
	public boolean   updateAddress(Address address){
		return addressService.updateAddress(address);
	}
	@RequestMapping("user/address/removeAddress")
	public boolean   remeveBatchCategory(String address_id){
		return addressService.removeAddress(address_id);
	}
}
