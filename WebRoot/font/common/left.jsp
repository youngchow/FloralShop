<%@page import="com.zy.shop.category.dao.CategoryDao"%>
<%@ page language="java" import="java.util.*,com.zy.shop.category.domain.Category" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path = request.getContextPath();%>
<%
CategoryDao categoryDao = new CategoryDao();
List<Category> parents = categoryDao.findAll();
request.setAttribute("parents",parents);
 %>
<div id="sidebar" class="left">
    	<div class="sidebar_box"><span class="bottom"></span>
            <h3>鲜花种类</h3>   
            <div class="content"> 
                <ul class="sidebar_list">
                	<c:forEach items="${parents}" var="parent">
                		<li>
                			<a href="#">${parent.cname}</a>
                			<ul>
	                			<c:forEach items="${parent.children}" var="child">
	                				<li><a href="<c:url value='/FlowerServlet?method=findByCategory&cid=${child.cid}'/>">${child.cname}</a></li>
	                			</c:forEach>
                			</ul>
                		</li>
                	</c:forEach>
                </ul>
            </div>
        </div>
        <div class="sidebar_box"><span class="bottom"></span>
            <h3>本周特色</h3>   
            <div class="content special"> 
                <img src="<%=path%>/images/templatemo_image_01.jpg" alt="Flowers" />
                <a href="#">温馨时刻</a>
                <p>
                	单价:
                    <span class="price normal_price">￥160</span>&nbsp;&nbsp;
                    <span class="price special_price">￥100</span>
                </p>
            </div>
        </div>
    </div>