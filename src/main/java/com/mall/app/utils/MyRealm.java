package com.mall.app.utils;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import com.mall.app.bean.User;
import com.mall.app.service.UserService;

public class MyRealm  extends AuthorizingRealm{
	@Autowired
	private UserService userService;
	/*处理用户授权或者角色分配*/
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		return null;
	}
	/*处理用户登录*/
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		String username=(String)token.getPrincipal();//获得当前登录用户名称
		SimpleAuthenticationInfo  info=null;
		User user=login(username);
		if(user!=null){
			SecurityUtils.getSubject().getSession().setAttribute("user", user);
			System.out.println(user.getType());
			User user2 = (User)SecurityUtils.getSubject().getSession().getAttribute("user");
			System.out.println("type  "+user2.getType());                                                                                                                                    
			//根据用户名称查处该用户，但是不保证输入的密码是否正确，封装目的就是比对密码
			info=new SimpleAuthenticationInfo(user.getUsername(),user.getPassword(),getName());
		}
		return info;
	}
	private User login(String username) {
		return userService.login(username);
	}
}