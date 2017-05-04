<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>鲜花分类</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="content-type" content="text/html;charset=utf-8">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

<link rel="stylesheet" type="text/css" href="<c:url value='/admin/admin/css/flower/list.css'/>">
<script type="text/javascript" src="<c:url value='/js/jquery.min.js'/>"></script>
<link rel="stylesheet" type="text/css" href="<c:url value='/font/pager/pager.css'/>" />
<script type="text/javascript" src="<c:url value='/font/pager/pager.js'/>"></script>

<script type="text/javascript" src="<c:url value='/admin/admin/js/flower/list.js'/>"></script>
  </head>
  
  <body>
<div class="divFlower">
<ul>

<c:forEach items="${pb.beanList }" var="flower">
 <li>
  <div class="inner">
    <a class="pic" href="<c:url value='/AdminFlowerServlet?method=load&fid=${flower.fid }'/>"><img src="<c:url value='/${flower.image_b }'/>" border="0"/></a>
    <p class="price" >
		<span class="price_n">&yen;${flower.currPrice }</span>
		<span class="price_r">&yen;${flower.price }</span>
		(<span class="price_s">${flower.discount }折</span>)
	</p>
	<p><a id="flowername" title="${flower.fname }" href="<c:url value='/AdminFlowerServlet?method=load&fid=${flower.fid }'/>">${flower.fname }</a></p>
  </div>
 </li>
</c:forEach>
</ul>
</div>
<div style="float:left; width: 100%; text-align: center;">
	<hr/>
	<br/>
	<%@include file="/font/pager/pager.jsp" %>
</div>
  </body>
 
</html>

