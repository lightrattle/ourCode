package com.mall.app.service.impl;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mall.app.bean.Address;
import com.mall.app.dao.AddressMapper;
import com.mall.app.service.AddressService;
@Service
@Transactional
public class AddressServiceImpl implements AddressService {
	@Autowired
	private AddressMapper addressMapper;
	public boolean saveAddress(Address address) {return addressMapper.saveAddress(address)>0;}
	public boolean removeAddress(String address_id) {return addressMapper.removeAddress(address_id)>0;}
	public boolean updateAddress(Address address) {return addressMapper.updateAddress(address)>0;}
    public int getCountAddress(Map<String, Object> map) {return addressMapper.getCountAddress(map);}
	public List<Address> listPageAddress(Map<String, Object> map) {
		return addressMapper.listPageAddress(map);
	}
	public Address selectAddress(int id) {
		return addressMapper.selectAddress(id);
	}
}
