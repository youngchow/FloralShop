<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>鲜花网店管理员登录</title>

<link href="<c:url value='/admin/css/bootstrap.min.css'/>" rel="stylesheet">
<link href="<c:url value='/admin/css/signin.css'/>" rel="stylesheet">

</head>

<body>

<div class="signin">
	<div class="signin-head"><img src="<c:url value='/admin/images/test/head_120.png'/>" alt="" class="img-circle"></div>
	<form class="form-signin" action="<c:url value='/AdminServlet'/>" method="post">
		<input type="hidden" name="method" value="login"/>
		<input type="text" class="form-control" name="adminname" placeholder="用户名" required autofocus />
		<input type="password" class="form-control" name="adminpwd" placeholder="密码" required />
		<button class="btn btn-lg btn-warning btn-block" type="submit">登录</button>
	</form>
</div>

<div style="text-align:center;">
<br/><br/><br/>
<h2>欢迎管理员登录</h2>
<p style="font-weight: 900; color: red">${msg}</p>
</div>
</body>
</html>
