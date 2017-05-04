<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path = request.getContextPath();%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>鲜花网店</title>
<jsp:include page="/font/common/resource.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/css.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/font/css/user/pwd.css'/>"/>
<script type="text/javascript" src="<c:url value='/font/js/user/pwd.js'/>"></script>
<script src="<c:url value='/js/common.js'/>"></script>
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
                	<li><a href="<%=path%>/toIndexServlet">主页</a></li>
                	<li><a href="<c:url value='/CartItemServlet?method=myCart'/>">我的购物车</a></li>
	                <li><a href="<c:url value='/OrderServlet?method=myOrders'/>">我的订单</a></li>
	                <li><a href="<c:url value='/font/user/pwd.jsp'/>" class="selected">修改密码</a></li>
	                <li><a href="<%=path%>/about.jsp">关于我们</a></li>
	                <li><a href="<c:url value='/UserServlet?method=quit'/>" onclick="return confirm('您确定要退出吗？')">安全退出</a></li>
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
    	<h2>修改密码</h2>
            <div id="divBody">
				<form action="<c:url value='/UserServlet'/>" method="post" id="changePwdForm">
					<input type="hidden" name="method" value="updatePassword"/>
					<table>
						<tr>
							<td><label class="error">${msg}</label></td>
							<td colspan="2">&nbsp;</td>
						</tr>
						<tr>
							<td align="right">原密码:</td>
							<td><input class="input" type="password" name="loginpass" id="loginpass" value="${user.loginpass }"/></td>
							<td><label id="loginpassError" class="error"></label></td>
						</tr>
						<tr>
							<td align="right">新密码:</td>
							<td><input class="input" type="password" name="newpass" id="newpass" value="${user.newpass }"/></td>
							<td><label id="newpassError" class="error"></label></td>
						</tr>
						<tr>
							<td align="right">确认密码:</td>
							<td><input class="input" type="password" name="reloginpass" id="reloginpass" value="${user.reloginpass }"/></td>
							<td><label id="reloginpassError" class="error"></label></td>
						</tr>
						<tr>
							<td align="right">验证码:</td>
							<td>
							  <input class="input" type="text" name="verifyCode" id="verifyCode" value="${user.verifyCode }""/>
							</td>
							<td><label id="verifyCodeError" class="error"></label></td>
						</tr>
						<tr>
							<td align="right"></td>
							<td>
							  <img id="vCode" src="<c:url value='/VerifyCodeServlet'/>" border="1"/>
					    	  <a href="javascript:_change();">看不清，换一张</a>
							</td>
						</tr>
						<tr>
							<td align="right"></td>
							<td><input id="submit" type="submit" value="修改密码"/></td>
						</tr>
					</table>
				</form>
			</div>
            <div class="cleaner h40"></div>
            
            <p><a href="#"><img src="<c:url value='/images/1311260370_paypal-straight.png'/>" alt="paypal" align="middle" /></a>&nbsp;(recommended if you have a PayPal account. Fastest way to complete your order.)</p>
            <p><a href="#"><img src="<c:url value='/images/flagship.jpg'/>" alt="Flagship" align="middle" /></a>&nbsp;(free shipping for orders above $500)</p>
            <div class="blank_box">
        	<a href="#"><img src="<c:url value='/images/free_shipping.jpg'/>" alt="Free Shipping" /></a>
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
		<p><a href="<%=path%>/admin/adminLogin.jsp">Admin Login</a> | <a href="<%=path%>/toIndexServlet">Home Page</a> | <a href="<%=path%>/about.jsp">About Us</a></p>
        <p>copyright 2016  Liren College of Yanshan University. All Rights Reserved  版权所有</p>
	</div>
    <div class="cleaner"></div>
</div> <!-- END of footer -->
</div> <!-- END of footer wrapper -->
</div>

</body>
</html>