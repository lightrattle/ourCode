package com.mall.app.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mall.app.bean.Collect;
import com.mall.app.dao.CollectMapper;
import com.mall.app.service.CollectService;
@Service
public class CollectServiceImpl implements CollectService {
	@Autowired
	private CollectMapper collectMapper;
	public boolean addCollect(Integer userId, int id) {
		return collectMapper.addCollect(userId,id);
	}
	public boolean removeCollect(Integer userId, int productId) {
		return collectMapper.removeCollect(userId,productId);
	}
	public List listCollect(String username) {
		List <Collect>l=collectMapper.listCollect(username);
		return l;
	}
}
