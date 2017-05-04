package com.zy.shop.flower.servlet;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zy.shop.flower.domain.Flower;
import com.zy.shop.flower.service.FlowerService;
import com.zy.shop.pager.PageBean;

import cn.itcast.servlet.BaseServlet;

public class FlowerServlet extends BaseServlet {

	private static final long serialVersionUID = 240047412841128625L;
	private FlowerService flowerService = new FlowerService();
	
	/**
	 * 按分类查
	 * @param req
	 * @param resp
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String findByCategory(HttpServletRequest req, HttpServletResponse resp)
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
		 * 3. 获取查询条件，本方法就是cid，即分类的id
		 */
		String cid = req.getParameter("cid");
		/*
		 * 4. 使用pc和cid调用service#findByCategory得到PageBean
		 */
		PageBean<Flower> pb = flowerService.findByCategory(cid, pc);
		/*
		 * 5. 给PageBean设置url，保存PageBean，转发到/font/flower/list.jsp
		 */
		pb.setUrl(url);
		req.setAttribute("pb", pb);
		return "f:/index.jsp";
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
	/**
	 * 截取url，页面中的分页导航中需要使用它做为超链接的目标！
	 * @param req
	 * @return
	 */
	/*
	 * http://localhost:8080/FloralShop/FlowerServlet?methed=findByCategory&cid=xxx&pc=3
	 * /FloralShop/FlowerServlet + methed=findByCategory&cid=xxx&pc=3
	 */
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
	 * 按分类名查，对应页面上的搜索框
	 * @param req
	 * @param resp
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String findByCname(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		/*
		 * 1. 得到pc：如果页面传递，使用页面的，如果没传，pc=1
		 */
		int pc = getPc(req);
		String cname = req.getParameter("cname");
		String url = req.getRequestURI()+"?method=findByCname&cname="+cname;
		/*
		 * 4. 使用pc和cid调用service#findByCategory得到PageBean
		 */
		PageBean<Flower> pb = flowerService.findByCname(cname, pc);
		/*
		 * 5. 给PageBean设置url，保存PageBean，转发到/index.jsp
		 */
		pb.setUrl(url);
		req.setAttribute("pb", pb);
		return "f:/index.jsp";
	}
	/**
	 * 按fid查询
	 * @param req
	 * @param resp
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String load(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String fid = req.getParameter("fid");//获取链接的参数bid
		Flower flower = flowerService.load(fid);//通过bid得到book对象
		req.setAttribute("flower", flower);//保存到req中
		return "f:/font/flower/desc.jsp";//转发到desc.jsp
	}
}
