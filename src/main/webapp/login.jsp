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

<div class="house-header">
  <div class="layui-container">
    <div class="house-nav">
      <span class="layui-breadcrumb" lay-separator="|">
        <a  href="../../logout" id="nickname">登录</a>
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
  <form class="layui-form">
    <p>账号登录</p>
    <div class="layui-input-block login">
      <i class="layui-icon layui-icon-username "></i>
      <input type="text" name="username" required lay-verify="required" placeholder="用户名" class="layui-input">
    </div>
    <div class="layui-input-block login">
      <i class="layui-icon layui-icon-password"></i>
      <input type="password" name="password" required lay-verify="required" placeholder="密码" class="layui-input">
    </div>
    <button type="button" class="layui-btn" lay-submit="lay-submi" lay-filter="userlogin">登录</button>
    <div style="width: 100%;text-align: right;margin-top: 10px"><a type="button" href="/regist.jsp" >没账号？去注册</a></div>
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
			form.on('submit(userlogin)', function(data) {
				console.log(data.field);
				$.post('user/login', data.field, function(flag) {
					console.log(flag);
					if (flag == '-2') {
						layer.msg('用户名称输入不正确', {
							icon : 5
						});
					} else if (flag == '-1') {
						layer.msg('用户密码输入不正确', {
							icon : 5
						});
					} else if (flag == '0') {
						window.location.href = "admin-index.jsp";
					} else if (flag == '1') {
						window.location.href = "seller-index.jsp";
					} else if (flag == '2') {
						window.location.href = "mall/html/index.html";
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
<script>
  layui.config({
    base: './mall/res/static/js/' 
  }).use('house'); 
</script>
   <script src="../res/static/js/nickname.js"></script>
</body>
</html>