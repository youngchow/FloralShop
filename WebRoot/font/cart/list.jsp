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
.spanEmpty{margin-top: 50px; font-size: 24px; font-weight: 900;}
.jian:HOVER {background: url(/FloralShop/images/icon.png) no-repeat;display: inline-block;background-position: -166px -125px;height: 11px;width: 11px;margin: 0;}
.jian {background: url(/FloralShop/images/icon.png) no-repeat;display: inline-block;background-position: -166px -145px;height: 11px;width: 11px;margin: 0;}
.jia:HOVER {background: url(/FloralShop/images/icon.png) no-repeat;display: inline-block;background-position: -178px -125px;height: 11px;width: 11px;margin: 0;}
.jia {background: url(/FloralShop/images/icon.png) no-repeat;display: inline-block;background-position: -178px -145px;height: 11px;width: 11px;margin: 0;}
.quantity {width: 25px;text-align: center;margin: 0;}
.jiesuan {background: url(/FloralShop/images/icon.png) no-repeat;display: inline-block;background-position: 0 -35px;height: 40px;width: 190px;margin: 0;}
.kill {background: url(/FloralShop/images/icon.png) no-repeat;display: inline-block;background-position: 0 -480px;height: 40px;width: 190px;}
.jiesuan:HOVER {background: url(/FloralShop/images/icon.png) no-repeat;display: inline-block;background-position: 0 -75px;height: 40px;width: 190px;poorfish: expression(this.onclick = function jiesuan(){return true});}
</style>
<script type="text/javascript">
$(function() {
	showTotal();//计算总计
	/*
	给全选添加click事件
	*/
	$("#selectAll").click(function() {
		/*
		1. 获取全选的状态
		*/
		var bool = $("#selectAll").attr("checked");
		/*
		2. 让所有条目的复选框与全选的状态同步
		*/
		setItemCheckBox(bool);
		/*
		3. 让结算按钮与全选同步
		*/
		setJieSuan(bool);
		/*
		4. 重新计算总计
		*/
		showTotal();
	});
	
	/*
	给所有条目的复选框添加click事件
	*/
	$(":checkbox[name=checkboxBtn]").click(function() {
		var all = $(":checkbox[name=checkboxBtn]").length;//所有条目的个数
		var select = $(":checkbox[name=checkboxBtn][checked=true]").length;//获取所有被选择条目的个数

		if(all == select) {//全都选中了
			$("#selectAll").attr("checked", true);//勾选全选复选框
			setJieSuan(true);//让结算按钮有效
		} else if(select == 0) {//谁都没有选中
			$("#selectAll").attr("checked", false);//取消全选
			setJieSuan(false);//让结算失效
		} else {
			$("#selectAll").attr("checked", false);//取消全选
			setJieSuan(true);//让结算有效				
		}
		showTotal();//重新计算总计
	});
	
	/*
	给减号添加click事件
	*/
	$(".jian").click(function() {
		// 获取cartItemId
		var id = $(this).attr("id").substring(0, 32);
		// 获取输入框中的数量
		var quantity = $("#" + id + "Quantity").val();
		// 判断当前数量是否为1，如果为1,那就不是修改数量了，而是要删除了。
		if(quantity == 1) {
			if(confirm("您是否真要删除该条目？")) {
				location = "/FloralShop/CartItemServlet?method=batchDelete&cartItemIds=" + id;
			}
		} else {
			sendUpdateQuantity(id, quantity-1);
		}
	});
	
	// 给加号添加click事件
	$(".jia").click(function() {
		// 获取cartItemId
		var id = $(this).attr("id").substring(0, 32);
		// 获取输入框中的数量
		var quantity = $("#" + id + "Quantity").val();
		sendUpdateQuantity(id, Number(quantity)+1);
	});
});

// 请求服务器，修改数量。
function sendUpdateQuantity(id, quantity) {
	$.ajax({
		async:false,
		cache:false,
		url:"/FloralShop/CartItemServlet",
		data:{method:"updateQuantity",cartItemId:id,quantity:quantity},
		type:"POST",
		dataType:"json",
		success:function(result) {
			//1. 修改数量
			$("#" + id + "Quantity").val(result.quantity);
			//2. 修改小计
			$("#" + id + "Subtotal").text(result.subtotal);
			//3. 重新计算总计
			showTotal();
		}
	});
}

/*
 * 计算总计
 */
function showTotal() {
	var total = 0;
	/*
	1. 获取所有的被勾选的条目复选框！循环遍历之
	*/
	$(":checkbox[name=checkboxBtn][checked=true]").each(function() {
		//2. 获取复选框的值，即其他元素的前缀
		var id = $(this).val();
		//3. 再通过前缀找到小计元素，获取其文本
		var text = $("#" + id + "Subtotal").text();
		//4. 累加计算
		total += Number(text);
	});
	// 5. 把总计显示在总计元素上
	$("#total").text(round(total, 2));//round()函数的作用是把total保留2位
}

/*
 * 统一设置所有条目的复选按钮
 */
function setItemCheckBox(bool) {
	$(":checkbox[name=checkboxBtn]").attr("checked", bool);
}

/*
 * 设置结算按钮样式
 */
function setJieSuan(bool) {
	if(bool) {
		$("#jiesuan").removeClass("kill").addClass("jiesuan");
		$("#jiesuan").unbind("click");//撤消当前元素所有click事件
	} else {
		$("#jiesuan").removeClass("jiesuan").addClass("kill");
		$("#jiesuan").click(function() {return false;});
	}
	
}

/*
 * 批量删除
 */
function batchDelete() {
	// 1. 获取所有被选中条目的复选框
	// 2. 创建一数组，把所有被选中的复选框的值添加到数组中
	// 3. 指定location为CartItemServlet，参数method=batchDelete，参数cartItemIds=数组的toString()
	var cartItemIdArray = new Array();
	$(":checkbox[name=checkboxBtn][checked=true]").each(function() {
		cartItemIdArray.push($(this).val());//把复选框的值添加到数组中
	});
	location = "/FloralShop/CartItemServlet?method=batchDelete&cartItemIds=" + cartItemIdArray;
}

/*
 * 结算
 */
function jiesuan() {
	// 1. 获取所有被选择的条目的id，放到数组中
	var cartItemIdArray = new Array();
	$(":checkbox[name=checkboxBtn][checked=true]").each(function() {
		cartItemIdArray.push($(this).val());//把复选框的值添加到数组中
	});	
	// 2. 把数组的值toString()，然后赋给表单的cartItemIds这个hidden
	$("#cartItemIds").val(cartItemIdArray.toString());
	// 把总计的值，也保存到表单中
	$("#hiddenTotal").val($("#total").text());
	// 3. 提交这个表单
	$("#jieSuanForm").submit();
}
</script>
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
    	<h2>我的购物车</h2>
		<c:choose>
			<c:when test="${empty cartItemList }">
			<table width="95%" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td align="right">
						<img align="top" src="<c:url value='/images/icon_empty.png'/>"/>
					</td>
					<td>
						<span class="spanEmpty">您的购物车中暂时没有商品</span>
					</td>
				</tr>
			</table>  
			</c:when>
			<c:otherwise>
		<table width="700" border="0" cellpadding="5" cellspacing="0">
          	<tr bgcolor="#395015">
          		<th align="left" width="88"><input type="checkbox" id="selectAll" checked="checked"/><label for="selectAll">全选</label></th>
                <th width="100" align="left">商品条目</th> 
                <th width="80" align="left">商品名称</th> 
                <th width="60" align="center">数量</th> 
                <th width="80" align="right">单价</th> 
                <th width="80" align="right">小计</th> 
                <th width="64">操作</th>
          	</tr>
          	<c:forEach items="${cartItemList}" var="cartItem">
            <tr bgcolor="#41581B">
            	<td align="left"><input value="${cartItem.cartItemId}" type="checkbox" name="checkboxBtn" checked="checked"/></td>
                <td><img border="0" width="54" align="top" src="<c:url value='/${cartItem.flower.image_b }'/>" alt="flower image" /></td> 
                <td>${cartItem.flower.fname }</td> 
                <td align="center">
                	<a class="jian" id="${cartItem.cartItemId }Jian"></a><input class="quantity" readonly="readonly" id="${cartItem.cartItemId }Quantity" type="text" value="${cartItem.quantity }"/><a class="jia" id="${cartItem.cartItemId }Jia"></a>
                </td>
                <td align="right">&yen;${cartItem.flower.currPrice }</td> 
                <td align="right">&yen;<span class="subTotal" id="${cartItem.cartItemId }Subtotal">${cartItem.subtotal }</span></td>
                <td align="center"> <a href="<c:url value='/CartItemServlet?method=batchDelete&cartItemIds=${cartItem.cartItemId }' />" onclick="return confirm('您确定要删除吗')"><img src="images/remove.png" alt="remove" /><br />Remove</a> </td>
            </tr>
            </c:forEach>
			<tr bgcolor="#41581B">
                <td colspan="5"><a href="javascript:batchDelete();" onclick="return confirm('您确定要执行批量删除吗')">批量删除</a></td>
                <td align="right"><h4>总计:</h4></td>
                <td><h4>&yen;<span id="total"></span></h4></td>
            </tr>
        </table>
        <form id="jieSuanForm" action="<c:url value='/CartItemServlet'/>" method="post">
			<input type="hidden" name="cartItemIds" id="cartItemIds"/>
			<input type="hidden" name="total" id="hiddenTotal"/>
			<input type="hidden" name="method" value="loadCartItems"/>
		</form>
		<div class="cleaner h20"></div>
        <div class="right"><a href="javascript:jiesuan();" id="jiesuan" class="jiesuan"></a></div>
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