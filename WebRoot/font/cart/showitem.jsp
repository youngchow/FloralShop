<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path = request.getContextPath();%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>鲜花网店</title>
<jsp:include page="/font/common/resource.jsp"></jsp:include>
<script src="<c:url value='/js/round.js'/>"></script>
<style>
#linkSubmit {background: url(/FloralShop/images/icon2.png) no-repeat;display: inline-block;background-position: 0px -35px;height: 40px;width: 190px;text-align: center;text-decoration: none;font-size: 24px;font-weight: 900;color: #ffffff;font-family: 黑体;line-height: 40px;}
#linkSubmit:HOVER {background: url(/FloralShop/images/icon2.png) no-repeat;display: inline-block;background-position: 0px -75px;height: 40px;width: 190px;}
#addr{width: 500px; height: 32px;border: 1px solid #7f9db9; padding-left: 10px; line-height: 32px;}
</style>
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
                	<li><a href="<%=path%>/toIndexServlet">主页</a></li>
                	<li><a href="<c:url value='/CartItemServlet?method=myCart'/>" class="selected">我的购物车</a></li>
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

    </div> <!-- END of header -->
</div> <!-- END of header wrapper -->
<div id="templatemo_main_wrapper">
<div id="templatemo_main">
	<jsp:include page="/font/common/left.jsp"></jsp:include>
    <div id="content" class="right">
    	<h2>生成订单</h2>
		<c:choose>
  	<c:when test="${empty cartItemList}">嘻嘻~</c:when>
  	<c:otherwise>
  	  <form id="form2" action="<c:url value='/OrderServlet'/>" method="post">
		<input type="hidden" name="cartItemIds" value="${cartItemIds }"/>
		<input type="hidden" name="method" value="createOrder"/>
		<table width="700" border="0" cellpadding="5" cellspacing="0">
          	<tr bgcolor="#395015">
                <th width="100" align="left">商品条目</th> 
                <th width="80" align="left">商品名称</th> 
                <th width="60" align="center">数量</th> 
                <th width="80" align="right">单价</th> 
                <th width="80" align="right">小计</th> 
          	</tr>
          	<c:forEach items="${cartItemList}" var="cartItem">
            <tr bgcolor="#41581B">
                <td><img border="0" width="54" align="top" src="<c:url value='/${cartItem.flower.image_b }'/>" alt="flower image" /></td> 
                <td>${cartItem.flower.fname }</td> 
                <td align="center">${cartItem.quantity }</td>
                <td align="right">&yen;${cartItem.flower.currPrice }</td> 
                <td align="right">&yen;<span class="subTotal" id="${cartItem.cartItemId }Subtotal">${cartItem.subtotal }</span></td>
            </tr>
            </c:forEach>
			<tr bgcolor="#41581B">
                <td colspan="3"></td>
                <td align="right"><h4>总计:</h4></td>
                <td><h4>&yen;<span id="total">${total}</span></h4></td>
            </tr>
            <tr>
				<td colspan="5"><h3>---------------------------收货地址---------------------------</h3></td>
			</tr>
			<tr>
			<td colspan="3">
				<input id="addr" type="text" name="address" value="燕山大学西校区"/>
			</td>
			</tr>
			<tr>
				<td style="border-top-width: 4px;" colspan="5" align="right">
					<a id="linkSubmit" href="javascript:$('#form2').submit();">提交订单</a>
				</td>
			</tr>
        </table>
        </form>
		<div class="cleaner h20"></div>
        </c:otherwise>
		</c:choose>
        <div class="cleaner h20"></div>
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