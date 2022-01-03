package com.mall.app.web;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mall.app.bean.Collect;
import com.mall.app.bean.User;
import com.mall.app.service.impl.CollectServiceImpl;

@RestController
public class CollectController {
	@Autowired
	private CollectServiceImpl collectservice;
	@RequestMapping("/listCollect")
	public List<Collect>listCollect(){
		User user2 = (User)SecurityUtils.getSubject().getSession().getAttribute("user");
		List<Collect> l=collectservice.listCollect(user2.getUsername());
		return l;
	}
	@RequestMapping("/addCollect")
	public boolean addCollect(int id)
	{ 
		User user2 = (User)SecurityUtils.getSubject().getSession().getAttribute("user");
		return collectservice.addCollect(user2.getUserId(),id);
	}

	@RequestMapping("/removeCollect")
	public boolean removeCollect(int productId){
		User user2 = (User)SecurityUtils.getSubject().getSession().getAttribute("user");
		return collectservice.removeCollect(user2.getUserId(),productId);
	}
}
