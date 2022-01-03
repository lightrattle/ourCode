package com.mall.app.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mall.app.bean.LogisticCom;
import com.mall.app.service.impl.LogisticComServiceImpl;

@RestController
@RequestMapping("/logisticCom")
public class LogisticComController {
	@Autowired
	private LogisticComServiceImpl impl;
	@RequestMapping("/addLogisticCom")
	public boolean addLogisticCom(String comName) {return impl.addLogisticCom(comName);}
	@RequestMapping("/removeLogisticCom")
	public boolean removeLogisticCom(@RequestParam("lids[]")String[] lids) {return impl.removeLogisticCom(lids);}
	@RequestMapping("/updateLogisticCom")
	public boolean updateLogisticCom(LogisticCom logisticCom) {
		System.out.println(logisticCom);
		return impl.updateLogisticCom(logisticCom);
	}
	@RequestMapping("/listLogisticCom")
	public Map<String, Object> listLogisticCom(Integer page,Integer limit) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 下拉框查询用
		if(page==null && limit==null){
			map.put("data", impl.listLogisticCom(map));
			return map;
		}
		
		map.put("page", (page-1)*limit );
		map.put("size", limit );
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0 );
		result.put("msg", "" );
		result.put("count", impl.getCountLogisticCom());
		result.put("data", impl.listLogisticCom(map));
		return result;
	}
	@RequestMapping("/getCountLogisticCom")
	public int getCountLogisticCom() {return impl.getCountLogisticCom();}
}
