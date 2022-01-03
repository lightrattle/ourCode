package com.mall.app.service;

import java.util.List;
import java.util.Map;

import com.mall.app.bean.Address;

public interface AddressService {
	boolean saveAddress(Address address);
	int getCountAddress(Map<String, Object> map);
	List<Address>listPageAddress(Map<String, Object> map);
	boolean updateAddress(Address address);
	boolean removeAddress(String address_id);
}
