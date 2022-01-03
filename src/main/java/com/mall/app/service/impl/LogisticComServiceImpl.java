package com.mall.app.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mall.app.bean.LogisticCom;
import com.mall.app.dao.LogisticComMapper;
import com.mall.app.service.LogisticComService;

@Service
public class LogisticComServiceImpl implements LogisticComService {
	@Autowired
	private LogisticComMapper mapper;
	@Override
	public boolean addLogisticCom(String comName) {
		return mapper.addLogisticCom(comName);
	}
	@Override
	public boolean removeLogisticCom(String[] lids) {
		return mapper.removeLogisticCom(lids);
	}
	@Override
	public boolean updateLogisticCom(LogisticCom logisticCom) {
		return mapper.updateLogisticCom(logisticCom);
	}
	@Override
	public List<LogisticCom> listLogisticCom(Map<String, Object> map) {
		return mapper.listLogisticCom(map);
	}
	@Override
	public int getCountLogisticCom() {
		return mapper.getCountLogisticCom();
	}
}
