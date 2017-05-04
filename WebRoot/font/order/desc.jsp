<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path = request.getContextPath();%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>鲜花网店</title>
<jsp:include page="/font/common/resource.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<c:url value='/font/css/order/desc.css'/>" />
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
                	<li><a href="<c:url value='/CartItemServlet?method=myCart'/>">我的购物车</a></li>
	                <li><a href="<c:url value='/OrderServlet?method=myOrders'/>" class="selected">我的订单</a></li>
	                <li><a href="<c:url value='/font/user/pwd.jsp'/>" >修改密码</a></li>
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
    	<h2>订单详情</h2>
    	<div class="divOrder">
		<span>订单号：${order.oid }
		<c:choose>
			<c:when test="${order.status eq 1 }">(等待付款)</c:when>
			<c:when test="${order.status eq 2 }">(准备发货)</c:when>
			<c:when test="${order.status eq 3 }">(等待确认)</c:when>
			<c:when test="${order.status eq 4 }">(交易成功)</c:when>
			<c:when test="${order.status eq 5 }">(已取消)</c:when>
		</c:choose>	
	         下单时间：${order.ordertime }</span>
		</div>
			<dl>
				<dt>收货人信息</dt>
				<dd>${order.address }</dd>
			</dl>
			<dl>
				<dt>商品清单</dt>
				<dd>
					<table cellpadding="0" cellspacing="0">
						<tr>
							<th class="tt"><font color="black">商品名称</font></th>
							<th class="tt" align="left"><font color="black">单价</font></th>
							<th class="tt" align="left"><font color="black">数量</font></th>
							<th class="tt" align="left"><font color="black">小计</font></th>
						</tr>
						<c:forEach items="${order.orderItemList }" var="item">
						<tr style="padding-top: 20px; padding-bottom: 20px;">
							<td class="td" width="400px">
								  <img align="middle" width="70" src="<c:url value='/${item.flower.image_b }'/>"/>
								  <a href="<c:url value='/FlowerServlet?method=load&fid=${item.flower.fid }'/>">${item.flower.fname }</a>
							</td>
							<td class="td" >
								<span>&yen;${item.flower.currPrice }</span>
							</td>
							<td class="td">
								<span>${item.quantity }</span>
							</td>
							<td class="td">
								<span>&yen;${item.subtotal }</span>
							</td>			
						</tr>
						</c:forEach>
					</table>
				</dd>
			</dl>
		<div style="margin: 10px 10px 10px 550px;">
			<span style="font-weight: 900; font-size: 15px;">合计金额：</span>
			<span class="price_t">&yen;${order.total }</span><br/>
		<c:if test="${order.status eq 1 }">
			<a href="<c:url value='/OrderServlet?method=payment&oid=${order.oid }'/>" onclick="return confirm('您确定要支付吗?')" class="pay"></a><br/>
		</c:if>
		<c:if test="${order.status eq 1 and btn eq 'cancel'}">
		    <a id="cancel" href="<c:url value='/OrderServlet?method=cancel&oid=${order.oid }'/>">取消订单</a><br/>
		</c:if>
		<c:if test="${order.status eq 3 and btn eq 'confirm'}">
			<a id="confirm" href="<c:url value='/OrderServlet?method=confirm&oid=${order.oid }'/>">确认收货</a><br/>
		</c:if>	
		</div>
        <div>
        	<a href="#"><img width="900px" src="images/free_shipping.jpg" alt="Free Shipping" /></a>
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