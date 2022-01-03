package com.mall.app.service;

import java.util.List;

public interface AppraiseService {
    public List listAppraise(int id);
    public boolean addAppraise(Integer userId, int id, String app_detail);
}
