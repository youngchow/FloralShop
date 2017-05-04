<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>鲜花网店</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/font/css/user/regist.css'/>" />
<jsp:include page="/font/common/resource.jsp"></jsp:include>
<script type="text/javascript" src="<c:url value='/font/js/user/regist.js'/>"></script>
<style type="text/css">
a {text-decoration: none;}
a:visited {color: #018BD3;}
a:hover {color:#FF6600; text-decoration: underline;}
}
</style>
</head>

<body>

<div id="templatemo_wrapper_sp">
<div id="templatemo_header_wsp">
	<div id="templatemo_header" class="header_subpage">
    	<div id="site_title"><a href="#"></a></div>
    		<c:if test="${!empty sessionScope.sessionUser}">
	    		<font color="#395015">欢迎您:${sessionScope.sessionUser.loginname}</font>
	    	</c:if>
        <div id="templatemo_menu" class="ddsmoothmenu">
            <ul>
                <c:if test="${empty sessionScope.sessionUser}">
                	<li><a href="<%=path%>/toIndexServlet" class="selected">主页</a></li>
	                <li><a href="<c:url value='/font/user/regist.jsp'/>">注册会员</a></li>
	                <li><a href="<c:url value='/font/user/login.jsp'/>">会员登录</a></li>
	                <li><a href="about.jsp">关于我们</a></li>
                </c:if>
                <c:if test="${!empty sessionScope.sessionUser}">
                	<li><a href="<%=path%>/toIndexServlet" class="selected">主页</a></li>
                	<li><a href="about.html">我的购物车</a></li>
	                <li><a href="products.html">我的订单</a></li>
	                <li><a href="checkout.html">修改密码</a></li>
	                <li><a href="about.jsp">关于我们</a></li>
	                <li><a href="<c:url value='/UserServlet?method=quit'/>" onclick="return confirm('您确定要退出吗？')">安全退出</a></li>
                </c:if>
            </ul>
            <div id="templatemo_search">
                <form action="<c:url value='/FlowerServlet?method=findByCname'/>" method="post" id="form1">
                  	<input type="text" value="玫瑰" name="cname" id="keyword" title="keyword" 
                  			onfocus="clearText(this)" onblur="clearText(this)" class="txt_field" />
               		<input type="submit" name="Search" value="" alt="Search" id="searchbutton" title="Search" class="sub_btn" />
                </form>
            </div>
            <br style="clear: left" />
        </div> 
        <a href="#" title=""  class="site_repeat" target="_blank"><img src="<c:url value='/images/top_repeat.png'/>" title=""  /></a><!-- end of templatemo_menu -->

    </div> <!-- END of header -->
</div> <!-- END of header wrapper -->
<div id="templatemo_main_wrapper">
<div id="templatemo_main">
	<jsp:include page="/font/common/left.jsp"></jsp:include>
    
    <div id="content" class="right">
    	<h2>Welcome to FloralShop</h2>
            <c:choose>
			  	<c:when test="${code eq 'success' }"><%--如果code是功能，它显示对号图片 --%>
			  		<c:set var="img" value="/images/duihao.jpg"/>
			  		<c:set var="title" value="成功"/>
			  	</c:when>
			  	<c:when test="${code eq 'error' }"><%--如果code是功能，它显示错号图片 --%>
			  		<c:set var="img" value="/images/cuohao.png"/>
			  		<c:set var="title" value="失败"/>
			  	</c:when>
			  	
			</c:choose>
					<img style="float: left; margin-right: 30px;" src="<c:url value='${img }'/>" width="150"/>
					<span style="font-size: 30px; color: #c30; font-weight: 900;">${msg }</span>
					<br/>
					<br/>
					<br/>
					<br/>
					<span style="margin-left: 50px;"><a target="_top" href="<c:url value='/font/user/login.jsp'/>">登录</a></span>
					<span style="margin-left: 50px;"><a target="_top" href="<c:url value='/welcome.jsp'/>">主页</a></span>
				<div class="cleaner h40"></div>
            
            <p><a href="#"><img src="<c:url value='/images/1311260370_paypal-straight.png'/>" alt="paypal" align="middle" /></a>&nbsp;(recommended if you have a PayPal account. Fastest way to complete your order.)</p>
            <p><a href="#"><img src="<c:url value='/images/flagship.jpg'/>" alt="Flagship" align="middle" /></a>&nbsp;(free shipping for orders above $500)</p>
            <div class="blank_box">
        	<a href="#"><img src="<c:url value='/images/free_shipping.jpg'/>" alt="Free Shipping" /></a>
				</div>
        	</div>    
        
    </div>
    
    <div class="cleaner"></div>
</div> <!-- END of main -->
</div> <!-- END of main wrapper -->

<div id="templatemo_footer_wrapper">
<div id="templatemo_footer">
	<div class="footer_left">
    	<a href="#"><img src="<c:url value='/images/1311260370_paypal-straight.png'/>" alt="Paypal" /></a>
        <a href="#"><img src="<c:url value='/images/1311260374_mastercard-straight.png'/>" alt="Master" /></a>
        <a href="#"><img src="<c:url value='/images/1311260374_visa-straight.png'/>" alt="Visa" /></a>
    </div>
	<div class="footer_right">
		<p><a href="<%=path%>/admin/adminLogin.jsp">Admin Login</a> | <a href="<%=path%>/toIndexServlet">Home Page</a> | <a href="about.jsp">About Us</a></p>
        <p>copyright 2016  Liren College of Yanshan University. All Rights Reserved  版权所有</p>
	</div>
    <div class="cleaner"></div>
</div> <!-- END of footer -->
</div> <!-- END of footer wrapper -->
</div>

</body>
</html>