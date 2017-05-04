<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>flower_desc.jsp</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="content-type" content="text/html;charset=utf-8">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" type="text/css" href="<c:url value='/admin/admin/css/flower/desc.css'/>">
<script type="text/javascript" src="<c:url value='/js/jquery.min.js'/>"></script>

<script type="text/javascript" src="<c:url value='/admin/admin/js/flower/desc.js'/>"></script>

<script type="text/javascript">

$(function() {
	$("#box").attr("checked", false);
	$("#formDiv").css("display", "none");
	$("#show").css("display", "");	
	
	// 操作和显示切换
	$("#box").click(function() {
		if($(this).attr("checked")) {
			$("#show").css("display", "none");
			$("#formDiv").css("display", "");
		} else {
			$("#formDiv").css("display", "none");
			$("#show").css("display", "");		
		}
	});
});

function loadChildren() {
	/*
	1. 获取pid
	2. 发出异步请求，功能之：
	  3. 得到一个数组
	  4. 获取cid元素(<select>)，把内部的<option>全部删除
	  5. 添加一个头（<option>请选择2级分类</option>）
	  6. 循环数组，把数组中每个对象转换成一个<option>添加到cid中
	*/
	// 1. 获取pid
	var pid = $("#pid").val();
	// 2. 发送异步请求
	$.ajax({
		async:true,
		cache:false,
		url:"/FloralShop/AdminBookServlet",
		data:{method:"ajaxFindChildren", pid:pid},
		type:"POST",
		dataType:"json",
		success:function(arr) {
			// 3. 得到cid，删除它的内容
			$("#cid").empty();//删除元素的子元素
			$("#cid").append($("<option>====请选择2级分类====</option>"));//4.添加头
			// 5. 循环遍历数组，把每个对象转换成<option>添加到cid中
			for(var i = 0; i < arr.length; i++) {
				var option = $("<option>").val(arr[i].cid).text(arr[i].cname);
				$("#cid").append(option);
			}
		}
	});
}

</script>
  </head>
  
  <body>
    <input type="checkbox" id="box"><label for="box">编辑或删除</label>
    <br/>
    <br/>
  <div id="show">
    <div class="sm">${flower.fname }</div>
    <img align="top" src="<c:url value='/${flower.image_w }'/>" class="tp"/>
    <div id="flower" style="float:left;">
	    <ul>
	    	<li>商品编号：${flower.fid }</li>
	    	<li>鲜花名：${flower.fname }</li>
	    	<li>当前价：<span class="price_n">&yen;${flower.currPrice }</span></li>
	    	<li>定价：<span style="text-decoration:line-through;">&yen;${flower.price }</span>　折扣：<span style="color: #c30;">${flower.discount }</span>折</li>
	    </ul>
	</div>
  </div>
  
  
  <div id='formDiv'>
   <div class="sm">&nbsp;</div>
   <form action="<c:url value='/AdminFlowerServlet'/>" method="post" id="form">
    <input type="hidden" name="method" id="method"/>
   	<input type="hidden" name="fid" value="${flower.fid }"/>
    <img align="top" src="<c:url value='/${flower.image_w }'/>" class="tp"/>
    <div style="float:left;">
	    <ul>
	    	<li>商品编号：${flower.fid }</li>
	    	<li>鲜花名：　<input id="fname" type="text" name="fname" value="${flower.fname}" style="width:500px;"/></li>
	    	<li>当前价：<input id="currPrice" type="text" name="currPrice" value="${flower.currPrice }" style="width:50px;"/></li>
	    	<li>定价：　<input id="price" type="text" name="price" value="${flower.price }" style="width:50px;"/>
	    	折扣：<input id="discount" type="text" name="discount" value="${flower.discount }" style="width:30px;"/>折</li>
	    </ul>
		<hr style="margin-left: 50px; height: 1px; color: #dcdcdc"/>
		<table class="tab">
			<tr>
				<td>
					一级分类：<select name="pid" id="pid" onchange="loadChildren()">
						<option value="">==请选择1级分类==</option>
						<c:forEach items="${parents }" var="parent">
						  <option value="${parent.cid }" <c:if test="${flower.category.parent.cid eq parent.cid }">selected="selected"</c:if>>${parent.cname }</option>
						</c:forEach>
					</select>
				</td>
				<td>
					二级分类：<select name="cid" id="cid">
						<option value="">==请选择2级分类==</option>
						<c:forEach items="${children }" var="child">
						  <option value="${child.cid }" <c:if test="${flower.category.cid eq child.cid }">selected="selected"</c:if>>${child.cname }</option>
						</c:forEach>
					</select>
				</td>
				<td></td>
			</tr>
			<tr>
				<td colspan="2">
					<input onclick="editForm()" type="button" name="method" id="editBtn" class="btn" value="编　　辑">
					<input onclick="deleteForm()" type="button" name="method" id="delBtn" class="btn" value="删　　除">
				</td>
				<td></td>
			</tr>
		</table>
	</div>
   </form>
  </div>

  </body>
</html>
