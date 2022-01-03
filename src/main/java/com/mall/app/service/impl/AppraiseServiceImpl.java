package com.mall.app.service.impl;

import com.mall.app.bean.Appraise;
import com.mall.app.dao.AppraiseMapper;
import com.mall.app.service.AppraiseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class AppraiseServiceImpl implements AppraiseService {
    @Autowired
    private AppraiseMapper appraiseMapper;
    public boolean addAppraise(Integer userId, int id, String app_detail) {
        return appraiseMapper.addAppraise(userId,id,app_detail);
    }
    public List listAppraise(int id) {
        List <Appraise>a=appraiseMapper.listAppraise(id);
        return a;
    }
}
