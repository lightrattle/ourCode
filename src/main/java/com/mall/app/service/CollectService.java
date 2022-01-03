package com.mall.app.service;

import java.util.List;
import java.util.Map;

public interface CollectService {
	public List listCollect(String username);
	public boolean addCollect(Integer userId, int id);
}
