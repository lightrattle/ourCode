package com.mall.app.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.mall.app.bean.Address;

@Repository
@Mapper
public interface AddressMapper {
	int saveAddress(Address address);
	int updateAddress(Address address);
	int removeAddress(String address_id);
	Address selectAddress(int id);
	int getCountAddress(Map<String, Object> map);
	List<Address> listPageAddress(Map<String, Object> map);
}
