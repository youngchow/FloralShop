<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:forEach items="${pb.beanList }" var="flower">
	<div class="product_box">
	    <a href="productdetail.html"><img src="<c:url value='/${flower.image_b }'/>" alt="${flower.fname}" /></a>
	   <h3>${flower.fname }</h3>
	 	<p class="product_price">&yen;${flower.currPrice }</p>
	    <p class="add_to_cart">
	        <a href="productdetail.html">详情</a>
	        <a href="shoppingcart.html">加入购物车</a>
	    </p>
	</div>     
</c:forEach>
<c:if test="${!empty pb.beanList }">
	<%@include file="/font/pager/pager.jsp" %>
</c:if>
