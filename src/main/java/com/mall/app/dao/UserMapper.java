package com.mall.app.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.mall.app.bean.User;
@Repository
@Mapper
public interface UserMapper {
	User login(@Param("username") String username);
	boolean updateInfo(Map<String, String> info);
	boolean uploadImg(@Param("img")String img, @Param("username")String username);
	public List<User> listUser(Map<String,Object> map);
	public boolean removeUser(String[] lids);
	public int getCountUser();
    int insert(@Param("user") User user);
}
