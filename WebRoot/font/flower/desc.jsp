<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path = request.getContextPath();%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>鲜花网店</title>
<jsp:include page="/font/common/resource.jsp"></jsp:include>
<script src="<c:url value='/font/js/flower/desc.js'/>"></script>
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
	                <li><a href="<%=path%>/about.jsp">关于我们</a></li>
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
        <a href="#"   class="site_repeat" ><img src="images/top_repeat.png" title="#/"  /></a><!-- end of templatemo_menu -->
       
    </div> <!-- END of header -->
</div> <!-- END of header wrapper -->
<div id="templatemo_main_wrapper">
<div id="templatemo_main">
	<jsp:include page="/font/common/left.jsp"></jsp:include>
    
    <div id="content" class="right">
      	<h2>商品详情</h2>
        <div class="content_half left">
        	<img src="<c:url value='/${flower.image_w}'/>" alt="flowers" />
        </div>
         <div class="content_half right">
         <form id="form2" action="<c:url value='/CartItemServlet'/>" method="post">
         	<input type="hidden" name="method" value="add"/>
			<input type="hidden" name="fid" value="${flower.fid }"/>
            <table width="400px">
            	<tr>
                    <td>商品编号:</td>
                    <td>${flower.fid}</td>
                </tr>
                <tr>
                    <td>促销价:</td>
                    <td>&yen;${flower.currPrice}</td>
                </tr>
                <tr>
                    <td>专柜价:</td>
                    <td><span style="text-decoration:line-through;">&yen;${flower.price}</span></td>
                </tr>
                <tr>
                	<td>折扣:</td>
               		<td>${flower.discount}折</td>
                 </tr>
                 <tr>
                     <td>库存:</td>
                     <td><strong>30件</strong></td>
                 </tr>
                 <tr>
                     <td>月销量:</td>
                     <td><strong>220</strong></td>
                 </tr>
                 <tr>
                  <td>数量:</td>
                  <td><input type="text" name="quantity" size="1" value="1" maxlength="2" id="cnt"/>件</td>
                 </tr>
             </table>
            </form>
            <a href="javascript:$('#form2').submit();" class="button">加入购物车</a>
		</div>
            <div class="cleaner h40"></div>
            <h4>花店介绍</h4>
            <p>鲜花网店是新一代在线花店，总部设立于上海。花里致力于为全中国客户提供最用心的鲜花与礼品解决方案。花里明白您的情思与心动，精心设计、打造每一款花盒、礼品。
            	充满“顶”和“赞”的时代，花里执着于更诚挚、更用心地表达你我的情感，只为您和您在乎的那个人。每一份自花里送出的作品，都经过了精心的设计和制作。但有时会因为一
				些快递和其他意外情况致使收到产品不尽如人意。针对这种情况，本店承诺对于顾客不满意的作品进行妥善处理，直至用户满意。</p>
            <div class="cleaner h40"></div>
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
		<p><a href="<%=path%>/admin/adminLogin.jsp">Admin Login</a> | <a href="<%=path%>/toIndexServlet">Home Page</a> | <a href="<%=path%>/about.jsp">About Us</a></p>
        <p>copyright 2016  Liren College of Yanshan University. All Rights Reserved  版权所有</p>
	</div>
    <div class="cleaner"></div>
</div> <!-- END of footer -->
</div> <!-- END of footer wrapper -->
</div>
</body>
</html>