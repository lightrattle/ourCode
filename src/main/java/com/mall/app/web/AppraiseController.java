package com.mall.app.web;

import com.mall.app.bean.Appraise;
import com.mall.app.bean.User;
import com.mall.app.service.impl.AppraiseServiceImpl;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class AppraiseController {
    @Autowired
    private AppraiseServiceImpl appraiseservice;
    @RequestMapping("/listAppraise")
    public List<Appraise> listAppraise(int id){
        List<Appraise> a=appraiseservice.listAppraise(id);
        return a;
    }
    @RequestMapping("/addAppraise")
    public boolean addAppraise(int id, String app_detail)
    {
        User user2 = (User)SecurityUtils.getSubject().getSession().getAttribute("user");
        return appraiseservice.addAppraise(user2.getUserId(),id, app_detail);
    }
}
