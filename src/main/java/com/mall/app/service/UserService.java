package com.mall.app.service;

import java.util.List;
import java.util.Map;

import com.mall.app.bean.User;

public interface UserService {
	User login(String username);
	public int addUser(User user);
	public boolean removeUser(String[] lids);
	boolean updateInfo(Map<String, String> info);
	boolean uploadImg(String string, String string2);
	public List<User> listUser(Map<String,Object> map);
	public int getCountUser();
}
