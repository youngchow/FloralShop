package com.zy.shop.user.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zy.shop.flower.domain.Flower;
import com.zy.shop.flower.service.FlowerService;
import com.zy.shop.pager.PageBean;

public class toIndexServlet extends HttpServlet{

	
	private static final long serialVersionUID = 6291726650475536789L;
	private FlowerService flowerService = new FlowerService();
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		res.setContentType("text/html;charset=utf-8");
		/*
		 * 1. 得到pc：如果页面传递，使用页面的，如果没传，pc=1
		 */
		int pc = getPc(req);
		/*
		 * 2. 得到url：...
		 */
		String url = getUrl(req);
		/*
		 * 3. 使用pc和cid调用service#findByCategory得到PageBean
		 */
		PageBean<Flower> pb = flowerService.findAllFlowers(pc);
		/*
		 * 4. 给PageBean设置url，保存PageBean，转发到/index.jsp
		 */
		pb.setUrl(url);
		req.setAttribute("pb", pb);
		req.getRequestDispatcher("index.jsp").forward(req, res);
	}

	/**
	 * 获取当前页码
	 * @param req
	 * @return
	 */
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
}
