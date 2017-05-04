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
<jsp:include page="/font/common/resource.jsp"></jsp:include>
</head>

<body>

<div id="templatemo_wrapper_sp">
<div id="templatemo_header_wsp">
	<div id="templatemo_header" class="header_subpage">
    	<div id="site_title"><a href="#" title=""></a></div>
    		<c:if test="${!empty sessionScope.sessionUser}">
	    		<font color="#395015">欢迎您:${sessionScope.sessionUser.loginname}</font>
	    	</c:if>
        <div id="templatemo_menu" class="ddsmoothmenu">
            <ul>
                <c:if test="${empty sessionScope.sessionUser}">
                	<li><a href="<%=path%>/toIndexServlet">主页</a></li>
	                <li><a href="<c:url value='/font/user/regist.jsp'/>">注册会员</a></li>
	                <li><a href="<c:url value='/font/user/login.jsp'/>">会员登录</a></li>
	                <li><a href="about.jsp" class="selected">关于我们</a></li>
                </c:if>
                <c:if test="${!empty sessionScope.sessionUser}">
                	<li><a href="<%=path%>/toIndexServlet">主页</a></li>
                	<li><a href="<c:url value='/CartItemServlet?method=myCart'/>">我的购物车</a></li>
	                <li><a href="<c:url value='/OrderServlet?method=myOrders'/>">我的订单</a></li>
	                <li><a href="<c:url value='/font/user/pwd.jsp'/>">修改密码</a></li>
	                <li><a href="about.jsp" class="selected">关于我们</a></li>
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
    </div> <!-- END of header -->
</div> <!-- END of header wrapper -->
<div id="templatemo_main_wrapper">
<div id="templatemo_main">
	<jsp:include page="/font/common/left.jsp"></jsp:include>
    
    <div id="content" class="right">
		<h2>关于我们</h2>
        <div class="cleaner h20"></div>
        <h3>我们的发展历程</h3>
		<p>语心鲜花网中国最专业的鲜花速递服务商,我们是一家专业配送全国送花的鲜花网站|依托国内8000余家加盟花店的紧密合作关系，本着“快捷|诚信|便利”为创办宗旨|专业提供网上订花服务 语心鲜花网为您网上订花、鲜花礼品传递温馨祝福.全国免费送花上门是一家以鲜花速递为主要业务的电子商务型网站。我们采用最先进的网络系统和高效的业务流程确保每位顾客的优质服务，将顾客的订单实时传送达全国，真正做到以最低的费用、最高效率来保证高品质的鲜花速递已经与“快钱”、“支付宝”、等多种在线支付平台实现无缝整合，在线实时支付，实时确认支付顾客通过传统方式付款也可以实时查收 ；</p>
        <div class="cleaner"></div>
        <blockquote>随着网络向现代生活各个角落的不断延伸和渗透，网上购物、时尚消费渐渐成为都市白领的新宠，鲜花速递业务也越来越显现出它的发展空间和潜在市场。语心鲜花网自成立以来，凭借优质的服务和良好的信誉在鲜花速递市场闯出了名堂，在消费者中拥有了一定的知名度，尤其受到白领们的喜爱。在语心鲜花网上订花，不仅方便快捷，而且价格也实惠。只要鼠标轻轻一点，几分钟就可完成订购；3小时之内，不管是全国的哪个地区，鲜花保证按时送达 语心鲜花网指出，鲜花网购的机遇与挑战并存，只有关注需求市场，不断创新，才能赢得消费者的喜爱，才能获得回报。随着电子商务的繁荣将会越来越多人选择网上订花 语心鲜花网服务宗旨：您的满意将是对我们的鼓励！我们会把客户的要求当做我们发展的动力，只有不断创新，才能赢得消费者的喜爱
        </blockquote>
    </div>
    <div class="cleaner"></div>
</div> <!-- END of main -->
</div> <!-- END of main wrapper -->

<div id="templatemo_footer_wrapper">
<div id="templatemo_footer">
	<div class="footer_left">
    	<a href="#"><img src="images/1311260370_paypal-straight.png" alt="Paypal" /></a>
        <a href="#"><img src="images/1311260374_mastercard-straight.png" alt="Master" /></a>
        <a href="#"><img src="images/1311260374_visa-straight.png" alt="Visa" /></a>
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