package com.mall.app.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.mall.app.bean.LogisticCom;

@Repository
@Mapper
public interface LogisticComMapper {
	public boolean addLogisticCom(String comName);
	public boolean removeLogisticCom(String[] lids);
	public boolean updateLogisticCom(LogisticCom logisticCom);
	public int getCountLogisticCom();
	public List<LogisticCom> listLogisticCom(Map<String,Object> map);
}
