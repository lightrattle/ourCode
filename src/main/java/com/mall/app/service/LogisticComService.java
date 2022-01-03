package com.mall.app.service;

import java.util.List;
import java.util.Map;

import com.mall.app.bean.LogisticCom;

public interface LogisticComService {
	public boolean addLogisticCom(String comName);
	public boolean removeLogisticCom(String[] lids);
	public boolean updateLogisticCom(LogisticCom logisticCom);
	public List<LogisticCom> listLogisticCom(Map<String,Object> map);
	public int getCountLogisticCom();
}
