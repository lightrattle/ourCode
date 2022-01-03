package com.mall.app.utils;

import java.util.LinkedHashMap;
import java.util.Map;

import org.apache.shiro.spring.LifecycleBeanPostProcessor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;

@Configuration
public class ShiroConfiguration {
	@Bean(name = "lifecycleBeanPostProcessor")
	public LifecycleBeanPostProcessor lifecycleBeanPostProcessor() {
		return new LifecycleBeanPostProcessor();
	}

	/*ShiroRealm，这是个自定义的认证类，继承自AuthorizingRealm，负责用户的认证和权限的处理*/
	@Bean(name="shiroRealm")
	@DependsOn("lifecycleBeanPostProcessor")
	public MyRealm shiroRealm() {
		return  new MyRealm();
	}

	/*SecurityManager，权限管理，这个类组合了登陆，登出，权限，session的处理，是个比较重要的类*/
	@Bean(name = "getSecurityManager")
	public DefaultWebSecurityManager getSecurityManager() {
		DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
		securityManager.setRealm(shiroRealm());
		return securityManager;
	}
	/**ShiroFilterFactoryBean，是个factorybean，为了生成ShiroFilter。
	 *它主要保持了三项数据，securityManager，filters，filterChainDefinitionManager。*/
	@Bean(name = "shiroFilter")
	public ShiroFilterFactoryBean shiroFilterFactoryBean() {
		ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
		shiroFilterFactoryBean.setSecurityManager(getSecurityManager());

		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("/user/login", "anon");
		map.put("/user/regist", "anon");
		map.put("/layui/**", "anon");
		map.put("/mall/**", "anon");
		map.put("/mall/html/user.html", "authc");
		map.put("/mall/html/useradd.html", "authc");
		map.put("/mall/html/detail.html", "authc");
		map.put("/mall/html/usercol.html", "authc");
		map.put("/mall/html/usershop.html", "authc");
		map.put("/logout", "logout");
		map.put("/regist.jsp", "anon");
		map.put("/**", "authc");
		shiroFilterFactoryBean.setUnauthorizedUrl("/login.jsp");
		shiroFilterFactoryBean.setFilterChainDefinitionMap(map);
		return shiroFilterFactoryBean;
	}
}
