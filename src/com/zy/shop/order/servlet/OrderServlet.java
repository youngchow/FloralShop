package com.zy.shop.order.servlet;


import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zy.shop.cart.domain.CartItem;
import com.zy.shop.cart.service.CartItemService;
import com.zy.shop.order.domain.Order;
import com.zy.shop.order.domain.OrderItem;
import com.zy.shop.order.service.OrderService;
import com.zy.shop.pager.PageBean;
import com.zy.shop.user.Domain.User;

import cn.itcast.commons.CommonUtils;
import cn.itcast.servlet.BaseServlet;

public class OrderServlet extends BaseServlet {

	private OrderService orderService = new OrderService();
	private CartItemService cartItemService = new CartItemService();
	private static final long serialVersionUID = 3599899617665007689L;

	/**
	 * 生成订单
	 * @param req
	 * @param resp
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String createOrder(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		/*
		 * 1. 获取所有购物车条目的id，查询之
		 */
		String cartItemIds = req.getParameter("cartItemIds");
		List<CartItem> cartItemList = cartItemService.loadCartItems(cartItemIds);
		if(cartItemList.size() == 0) {
			req.setAttribute("code", "error");
			req.setAttribute("msg", "您没有选择要购买的图书，不能下单！");
			return "f:/font/msg.jsp";
		}
		/*
		 * 2. 创建Order
		 */
		Order order = new Order();
		order.setOid(CommonUtils.uuid());//设置主键
		order.setOrdertime(String.format("%tF %<tT", new Date()));//下单时间
		order.setStatus(1);//设置状态，1表示未付款
		order.setAddress(req.getParameter("address"));//设置收货地址
		User owner = (User)req.getSession().getAttribute("sessionUser");
		order.setOwner(owner);//设置订单所有者
		
		BigDecimal total = new BigDecimal("0");
		for(CartItem cartItem : cartItemList) {
			total = total.add(new BigDecimal(cartItem.getSubtotal() + ""));
		}
		order.setTotal(total.doubleValue());//设置总计
		
		/*
		 * 3. 创建List<OrderItem>
		 * 一个CartItem对应一个OrderItem
		 */
		List<OrderItem> orderItemList = new ArrayList<OrderItem>();
		for(CartItem cartItem : cartItemList) {
			OrderItem orderItem = new OrderItem();
			orderItem.setOrderItemId(CommonUtils.uuid());//设置主键
			orderItem.setQuantity(cartItem.getQuantity());
			orderItem.setSubtotal(cartItem.getSubtotal());
			orderItem.setFlower(cartItem.getFlower());
			orderItem.setOrder(order);
			orderItemList.add(orderItem);
		}
		order.setOrderItemList(orderItemList);
		
		/*
		 * 4. 调用service完成添加
		 */
		orderService.createOrder(order);
		
		// 删除购物车条目
		cartItemService.batchDelete(cartItemIds);
		/*
		 * 5. 保存订单，转发到ordersucc.jsp
		 */
		req.setAttribute("order", order);
		return "f:/font/order/ordersucc.jsp";
	}
	private int getPc(HttpServletRequest req) {
		int pc = 1;
		String param = req.getParameter("pc");
		if(param != null && !param.trim().isEmpty()) {
			try {
				pc = Integer.parseInt(param);
			} catch(RuntimeException e) {}
		}
		return pc;
	}
	private String getUrl(HttpServletRequest req) {
		String url = req.getRequestURI() + "?" + req.getQueryString();
		/*
		 * 如果url中存在pc参数，截取掉，如果不存在那就不用截取。
		 */
		int index = url.lastIndexOf("&pc=");
		if(index != -1) {
			url = url.substring(0, index);
		}
		return url;
	}
	/**
	 * 我的订单
	 * @param req
	 * @param resp
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String myOrders(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		/*
		 * 1. 得到pc：如果页面传递，使用页面的，如果没传，pc=1
		 */
		int pc = getPc(req);
		/*
		 * 2. 得到url：...
		 */
		String url = getUrl(req);
		/*
		 * 3. 从当前session中获取User
		 */
		User user = (User)req.getSession().getAttribute("sessionUser");
		
		/*
		 * 4. 使用pc和cid调用service#findByCategory得到PageBean
		 */
		PageBean<Order> pb = orderService.myOrders(user.getUid(), pc);
		/*
		 * 5. 给PageBean设置url，保存PageBean，转发到/jsps/book/list.jsp
		 */
		pb.setUrl(url);
		req.setAttribute("pb", pb);
		return "f:/font/order/list.jsp";
	}
	/**
	 * 加载订单
	 * @param req
	 * @param resp
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String load(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String oid = req.getParameter("oid");
		Order order = orderService.load(oid);
		req.setAttribute("order", order);
		String btn = req.getParameter("btn");//btn说明了用户点击哪个超链接来访问本方法的
		req.setAttribute("btn", btn);
		return "/font/order/desc.jsp";
	}
	/**
	 * 支付
	 * @param req
	 * @param resp
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String payment(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String oid = req.getParameter("oid");
		if(orderService.updateStatus(oid, 2)){
			req.setAttribute("code", "success");
			req.setAttribute("msg", "恭喜，支付成功！");
			return "f:/font/order/msg.jsp";
		}else{
			req.setAttribute("code", "error");
			req.setAttribute("msg", "很抱歉，支付失败！");
			return "f:/font/order/msg.jsp";
		}
	}
	/**
	 * 取消订单
	 * @param req
	 * @param resp
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String cancel(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String oid = req.getParameter("oid");
		/*
		 * 校验订单状态
		 */
		int status = orderService.findStatus(oid);
		if(status != 1) {//已经付款的订单不能取消
			req.setAttribute("code", "error");
			req.setAttribute("msg", "状态不对，不能取消！");
			return "f:/font/order/msg.jsp";
		}
		orderService.updateStatus(oid, 5);//设置状态为取消！
		req.setAttribute("code", "success");
		req.setAttribute("msg", "您的订单已取消，您不后悔吗！");
		return "f:/font/order/msg.jsp";		
	}
	/**
	 * 确认收货
	 * @param req
	 * @param resp
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String confirm(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String oid = req.getParameter("oid");
		/*
		 * 校验订单状态
		 */
		int status = orderService.findStatus(oid);
		if(status != 3) {
			req.setAttribute("code", "error");
			req.setAttribute("msg", "状态不对，不能确认收货！");
			return "f:/font/order/msg.jsp";
		}
		orderService.updateStatus(oid, 4);//设置状态为交易成功！
		req.setAttribute("code", "success");
		req.setAttribute("msg", "恭喜，交易成功！");
		return "f:/font/order/msg.jsp";		
	}
}
