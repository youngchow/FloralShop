<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path = request.getContextPath();%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>鲜花网店</title>
<jsp:include page="/font/common/resource.jsp"></jsp:include>
</head>

<body>

<div id="templatemo_wrapper_h">
<div id="templatemo_header_wh">
	<div id="templatemo_header" class="header_home">
    	<div id="site_title"><a href="#" title=""></a></div>
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
                	<li><a href="<c:url value='/CartItemServlet?method=myCart'/>">我的购物车</a></li>
	                <li><a href="<c:url value='/OrderServlet?method=myOrders'/>">我的订单</a></li>
	                <li><a href="<c:url value='/font/user/pwd.jsp'/>">修改密码</a></li>
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
        <a href="#" title="visit "  class="site_repeat" target="_blank"><img src="<c:url value= '/images/top_repeat.png'/>"  alt="visit " /></a><!-- end of templatemo_menu -->

        <div class="slider-wrapper theme-orman">
            <div class="ribbon"></div>
            <div id="slider" class="nivoSlider">
                <img src="<c:url value='/images/portfolio/01.jpg'/>" alt="slider image 1" />
                <img src="<c:url value='/images/portfolio/02.jpg'/>" alt="slider image 2" />
                <img src="<c:url value='/images/portfolio/03.jpg'/>" alt="slider image 3" />
                <img src="<c:url value='/images/portfolio/04.jpg'/>" alt="slider image 4" />
                <img src="<c:url value='/images/portfolio/05.jpg'/>" alt="slider image 5" />
            </div>
        </div> 
		<script type="text/javascript" src="<c:url value='/js/jquery-1.6.1.min.js' />"></script>
        <script type="text/javascript" src="<c:url value='/js/jquery.nivo.slider.pack.js' />"></script>
        <script type="text/javascript">
        $(window).load(function() {
            $('#slider').nivoSlider({
				controlNav:false
			});
        });
        </script>
    </div> <!-- END of header -->
</div> <!-- END of header wrapper -->
<div id="templatemo_main_wrapper">
<div id="templatemo_main">
	<jsp:include page="/font/common/left.jsp"></jsp:include>
    <div id="content" class="right">
		<h2>欢迎来到鲜花网店</h2>
		<p>浪漫花语专业的花艺设计师，主要经营生日鲜花、爱情鲜花、开业花篮，庆典花篮，求婚鲜花，鲜花盆景，婚礼婚庆鲜花，巧克力花束，卡通花束等。本花店承诺“顾客至上”，锐意进取的经营理念。坚持“顾客第一”的原则为广大客户提供优质服务，欢迎广大客户惠顾。</p>
        <p>浪漫花语，花为物语。回忆悠长。如果你有需要，只要一个电话，我们会及时把美丽的鲜花送到你的手中。爱上花语，爱上生活。我们传递的不仅是一种商品，我们更加传递的是一种生活的艺术，鲜花让我们生活变得更加的美好，我们应该去感受鲜花的清香，享受生活的美好。</p>
	        <c:if test="${!empty pb.beanList }">
	        <c:forEach items="${pb.beanList }" var="flower">
	        <div class="product_box">
	            <a rel="lightbox" href="<c:url value='/${flower.image_w }'/>"><img src="<c:url value='/${flower.image_b }'/>" alt="${flower.fname}" /></a>
	            <h3>${flower.fname }</h3>
	          	<p class="product_price">&yen;${flower.currPrice }</p>
	            <p class="add_to_cart">
	                <a href="<%=path%>/FlowerServlet?method=load&fid=${flower.fid}">详情</a>
	                <a href="<%=path%>/CartItemServlet?method=add&fid=${flower.fid}">加入购物车</a>
	            </p>
	        </div>     
	        </c:forEach>
	        	<%@include file="/font/pager/pager.jsp" %>
	        </c:if>
	        <c:if test="${empty pb.beanList }">
	        	<div class="product_box">
	        		<h3><font color="red">暂时无货，敬请期待....</font></h3>
	        	</div>
	        </c:if>
        <div class="blank_box">
        	<a href="#"><img src="images/free_shipping.jpg" alt="Free Shipping" /></a>
        </div>    
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
