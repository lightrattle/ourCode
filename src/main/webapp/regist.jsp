<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>商城-登录</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="./mall/res/layui/css/layui.css">
    <link rel="stylesheet" href="./mall/res/static/css/index.css">
</head>
<body>
<style>
    .layui-form-label{
        width: 60px;
    }
</style>
<div class="house-header">
    <div class="layui-container">
        <div class="house-nav">
          <span class="layui-breadcrumb" lay-separator="|">
            <a id="nickname">登录</a>
            <a href="../../logout">退出登录</a>
          </span>
        </div>
        <div class="house-banner layui-form">

            <div class="layui-input-inline">
            </div>
        </div>
        <ul class="layui-nav close">
            <li class="layui-nav-item"><a href="mall/html/index.html">首页</a></li>
            <li class="layui-nav-item layui-this"><a href="mall/html/user.html">我的</a></li>
            <li class="layui-nav-item"><a href="mall/html/list.html">商城</a></li>
            <li class="layui-nav-item"><a href="mall/html/usershop.html">购物车</a></li>
        </ul>
        <button id="switch">
            <span></span><span class="second"></span><span class="third"></span>
        </button>
    </div>
</div>

<div class="layui-fulid" id="house-login">
    <form  class="layui-form"
           lay-filter="update_info_" action="">
        <br>
        <p style="line-height: 50px">账号注册</p>
        <div class="layui-form-item">
            <label class="layui-form-label">用户名</label>
            <div class="layui-input-inline">

                <input type="text" name="username" required lay-verify="required" placeholder="用户名" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">密码</label>
            <div class="layui-input-inline">
            <input type="password" name="password" required lay-verify="required" placeholder="密码" class="layui-input">
        </div>
        </div>
        <div class=" layui-form-item">
            <label class="layui-form-label">确认密码</label>
            <div class="layui-input-inline">
            <input type="password" name="rpassword" required lay-verify="required" placeholder="确认密码" class="layui-input">
        </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">昵称</label>
            <div class="layui-input-inline">
                <input type="text" name="nickname" required lay-verify="required" autocomplete="off"
                       class="layui-input" placeholder="昵称">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">电话</label>
            <div class="layui-input-inline">
                <input type="text" placeholder="电话" required lay-verify="required" autocomplete="off" name="phoneNumber"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-block">
                <input type="radio" name="sex" value="男" title="男"> <input
                    type="radio" name="sex" value="女" title="女" checked>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">用户类型</label>
            <div class="layui-input-block">
                <input type="radio" name="type" value="2" checked title="买家"> <input
                    type="radio" name="type" value="1" title="卖家" >
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="userRegist">立即提交</button>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript" src="./mall/res/layui/layui.js"></script>
<script type="text/javascript">
    layui.use([ 'layer', 'form', 'jquery' ], function() {
        var layer = layui.layer;
        var form = layui.form;
        var $ = layui.jquery;
        //编写登录对话框
        //提交表单
        form.on('submit(userRegist)', function(data) {
            console.log(data.field);

            $.post('user/regist', data.field, function(flag) {
                console.log(flag);
                if(flag == -1){
                    layer.msg("两次密码输入不正确")
                }else if(flag == -2){
                    layer.msg("用户名已存在")
                }else{
                    layer.msg("注册成功")
                    window.location.href = "/logout"
                }
            })
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });

    })
</script>
<div class="house-footer">
    <div class="layui-container">
        <div class="intro">
            <span class="first"><i class="layui-icon layui-icon-house-shield"></i>7天无理由退换货</span>
            <span class="second"><i class="layui-icon layui-icon-house-car"></i>满99元全场包邮</span>
            <span class="third"><i class="layui-icon layui-icon-house-diamond"></i>100%品质保证</span>
            <span class="last"><i class="layui-icon layui-icon-house-tel"></i>客服000-0000-000</span>
        </div>
        <div class="about">
      <span class="layui-breadcrumb" lay-separator="|">
        <a href="about.html">关于我们</a>
        <a href="about.html">帮助中心</a>
        <a href="about.html">售后服务</a>
        <a href="about.html">配送服务</a>
        <a href="about.html">关于货源</a>
      </span>
            <p>©Web-大作业</p>
        </div>
    </div>
</div>

<!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
<!--[if lt IE 9]>
<script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
<script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
</body>
</html>