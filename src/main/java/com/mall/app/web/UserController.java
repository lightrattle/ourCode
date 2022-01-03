package com.mall.app.web;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;
import com.mall.app.bean.User;
import com.mall.app.service.impl.UserServiceImpl;

@RestController
public class UserController {
	@Autowired
	private UserServiceImpl service;
	@RequestMapping("/user/login")
	public String login(String username,String password){
		UsernamePasswordToken  token=new UsernamePasswordToken(username,password);
		Subject subject=SecurityUtils.getSubject();
		if(!subject.isAuthenticated()){
			try {
				System.out.println(username+"  "+password+"    logining");
				subject.login(token);
			} catch (UnknownAccountException uae) {
				return "-2";
			} catch (IncorrectCredentialsException ice) {
				return "-1";
			}  catch (AuthenticationException  ice) {
				System.out.println("认证失败");
			}      
		}
		User user2 = (User)SecurityUtils.getSubject().getSession().getAttribute("user");
		System.out.println("type  "+user2.getType());
		return String.valueOf(user2.getType());
	}
	@RequestMapping("/user/getInfo")
	public User getInfo(){
		User user=(User)SecurityUtils.getSubject().getSession().getAttribute("user");
		User u=service.login(user.getUsername());
		u.setPassword(null);
		return  u;
	}
	@RequestMapping("/user/updateInfo")
	public boolean updateInfo(String nickname,String phone_number,String sex){
		Map<String,String> info=new HashMap<String,String>();
		info.put("nickname", nickname);
		info.put("phone_number", phone_number);
		info.put("sex", sex);
		User user=(User)SecurityUtils.getSubject().getSession().getAttribute("user");
		info.put("username",user.getUsername());
		System.out.println(info);
        return service.updateInfo(info);
	}
	@RequestMapping("/user/regist")
	public int regist(User user,String rpassword) {
		if(!user.getPassword().equals(rpassword)){
			return -1;
		}else{
			return service.addUser(user);
		}
	}
	@ResponseBody
	@RequestMapping(value="/user/uploadImg",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	public String uploadImg(@RequestParam MultipartFile file,HttpSession session) {
		User user=(User)SecurityUtils.getSubject().getSession().getAttribute("user");
		String fileName = file.getOriginalFilename();  // 文件名
        String suffixName = fileName.substring(fileName.lastIndexOf("."));  // 后缀名
        String filePath = session.getServletContext().getRealPath("/")+"mall\\res\\static\\person_img\\"; // 上传后的路径
        fileName = UUID.randomUUID() + suffixName; // 新文件名
        File dest = new File(filePath + fileName);
        if (!dest.getParentFile().exists()) {
            dest.getParentFile().mkdirs();
        }
        JSONObject j=new JSONObject();
        try {
            file.transferTo(dest);
            service.uploadImg(fileName,user.getUsername());
            j.put("success", true);
            j.put("fileName", fileName);
        } catch (IOException e) {
            e.printStackTrace();
            j.put("success", false);
        }
        return j.toJSONString();
	}
	/*查询用户信息*/
	@RequestMapping("/user/listUser")
	public Map<String, Object> listUser(int page,int limit,Integer type) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", (page-1)*limit );
		map.put("size", limit );
		map.put("type", type);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0 );
		result.put("msg", "" );
		result.put("count", service.getCountUser());
		result.put("data", service.listUser(map));
		return result;
	}
	@RequestMapping("/user/removeUser")
	public boolean removeUser(@RequestParam("lids[]")String[] lids) {
		return service.removeUser(lids);
	}
	/*查询用户数*/
	@RequestMapping("/user/getCountUser")
	public int getCountUser() {
		return service.getCountUser();
	}
	@RequestMapping("/logout")
	public boolean logout() {
	    Subject subject = SecurityUtils.getSubject();
	    subject.logout();
	    return true;
	}
}