<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>top</title>
    <base target="body">
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
	body {font-size: 10pt;}
	a {color: #aaa;}
</style>
  </head>
  
  <body style="background: #777777;">
<h1 style="text-align: center; line-height: 30px;">鲜花网店后台管理</h1>
<div style="line-height: 10px;">
	<span>管理员：${sessionScope.admin.adminname }</span>
	<a target="_top" href="<c:url value='/AdminServlet?method=quit'/>" onclick="return confirm('您确定要退出吗？')">退出</a>
	<span style="padding-left:50px;">
		<a href="<c:url value='/AdminCategoryServlet?method=findAll'/>">分类管理</a>
		<a href="<c:url value='/admin/admin/flower/main.jsp'/>">鲜花管理</a>
		<a href="<c:url value='/AdminOrderServlet?method=findAll'/>">订单管理</a>
	</span>
</div>
  </body>
</html>
