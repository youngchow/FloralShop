package com.zy.shop.flower.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import com.zy.shop.category.domain.Category;
import com.zy.shop.flower.domain.Flower;
import com.zy.shop.pager.Expression;
import com.zy.shop.pager.PageBean;
import com.zy.shop.pager.PageConstants;

import cn.itcast.commons.CommonUtils;
import cn.itcast.jdbc.TxQueryRunner;

public class FlowerDao {

	private QueryRunner qr = new TxQueryRunner();
	/**
	 * 查询指定分类下鲜花的个数
	 * @param cid
	 * @return
	 * @throws SQLException 
	 */
	public int findBookCountByCategory(String cid) throws SQLException {
		String sql = "select count(*) from t_flower where cid=?";
		Number cnt = (Number)qr.query(sql, new ScalarHandler(), cid);
		return cnt == null ? 0 : cnt.intValue();
	}
	/**
	 * 按分类查询
	 * @param cid
	 * @param pc
	 * @return
	 * @throws SQLException 
	 */
	public PageBean<Flower> findByCategory(String cid, int pc) throws SQLException {
		List<Expression> exprList = new ArrayList<Expression>();
		exprList.add(new Expression("cid", "=", cid));
		return findByCriteria(exprList, pc);
	}

	/**
	 * 通用的查询方法
	 * @param exprList
	 * @param pc
	 * @return
	 * @throws SQLException 
	 */
	private PageBean<Flower> findByCriteria(List<Expression> exprList, int pc) throws SQLException {
		/*
		 * 1. 得到ps
		 * 2. 得到tr
		 * 3. 得到beanList
		 * 4. 创建PageBean，返回
		 */
		/*
		 * 1. 得到ps
		 */
		int ps = PageConstants.Flower_PAGE_SIZE;//每页记录数
		/*
		 * 2. 通过exprList来生成where子句
		 */
		StringBuilder whereSql = new StringBuilder(" where 1=1"); 
		List<Object> params = new ArrayList<Object>();//SQL中有问号，它是对应问号的值
		for(Expression expr : exprList) {
			/*
			 * 添加一个条件上，
			 * 1) 以and开头
			 * 2) 条件的名称
			 * 3) 条件的运算符，可以是=、!=、>、< ... is null，is null没有值
			 * 4) 如果条件不是is null，再追加问号，然后再向params中添加一与问号对应的值
			 */
			whereSql.append(" and ").append(expr.getName())
				.append(" ").append(expr.getOperator()).append(" ");
			// where 1=1 and bid = ?
			if(!expr.getOperator().equals("is null")) {
				whereSql.append("?");
				params.add(expr.getValue());
			}
		}

		/*
		 * 3. 总记录数 
		 */
		String sql = "select count(*) from t_flower" + whereSql;
		Number number = (Number)qr.query(sql, new ScalarHandler(), params.toArray());
		int tr = number.intValue();//得到了总记录数
		/*
		 * 4. 得到beanList，即当前页记录
		 */
		sql = "select * from t_flower" + whereSql + " order by orderBy limit ?,?";
		params.add((pc-1) * ps);//当前页首行记录的下标
		params.add(ps);//一共查询几行，就是每页记录数
		
		List<Flower> beanList = qr.query(sql, new BeanListHandler<Flower>(Flower.class), 
				params.toArray());
		
		/*
		 * 5. 创建PageBean，设置参数
		 */
		PageBean<Flower> pb = new PageBean<Flower>();
		/*
		 * 其中PageBean没有url，这个任务由Servlet完成
		 */
		pb.setBeanList(beanList);
		pb.setPc(pc);
		pb.setPs(ps);
		pb.setTr(tr);
		
		return pb;
	}
	/**
	 * 添加鲜花
	 * @param book
	 * @throws SQLException 
	 */
	public void add(Flower flower) throws SQLException {
		String sql = "insert into t_flower(fid,fname,price,currPrice," +
				"discount,cid,image_w,image_b)" +
				" values(?,?,?,?,?,?,?,?)";
		Object[] params = {flower.getFid(),flower.getFname(),
				flower.getPrice(),flower.getCurrPrice(),flower.getDiscount(),
				flower.getCategory().getCid(),
				flower.getImage_w(),flower.getImage_b()};
		qr.update(sql, params);
	}
	/**
	 * 按bid查询
	 * @param fid
	 * @return
	 * @throws SQLException
	 */
	public Flower findByBid(String fid) throws SQLException {
		String sql = "SELECT * FROM t_flower f, t_category c WHERE f.cid=c.cid AND f.fid=?";
		// 一行记录中，包含了很多的flower的属性，还有一个cid属性
		Map<String,Object> map = qr.query(sql, new MapHandler(), fid);
		// 把Map中除了cid以外的其他属性映射到Flower对象中
		Flower flower = CommonUtils.toBean(map, Flower.class);
		// 把Map中cid属性映射到Category中，即这个Category只有cid
		Category category = CommonUtils.toBean(map, Category.class);
		// 两者建立关系
		flower.setCategory(category);
		
		// 把pid获取出来，创建一个Category parnet，把pid赋给它，然后再把parent赋给category
		if(map.get("pid") != null) {
			Category parent = new Category();
			parent.setCid((String)map.get("pid"));
			category.setParent(parent);
		}
		return flower;
	}
	/**
	 * 修改鲜花
	 * @param flower
	 * @throws SQLException 
	 */
	public void edit(Flower flower) throws SQLException {
		String sql = "update t_flower set fname=?,price=?,currPrice=?," +
				"discount=?,cid=? where fid=?";
		Object[] params = {flower.getFname(),
				flower.getPrice(),flower.getCurrPrice(),flower.getDiscount(),
				flower.getCategory().getCid(),flower.getFid()};
		qr.update(sql, params);
	}
	/**
	 * 删除鲜花
	 * @param fid
	 * @throws SQLException 
	 */
	public void delete(String fid) throws SQLException {
		String sql = "delete from t_flower where fid=?";
		qr.update(sql, fid);
	}
	/**
	 * 查询所有鲜花，显示到首页
	 * @param pc
	 * @return
	 * @throws SQLException
	 */
	public PageBean<Flower> getAllFlowers(int pc) throws SQLException{
		return findByCriteria(pc);
	}
	private PageBean<Flower> findByCriteria(int pc) throws SQLException {
		int ps = PageConstants.Flower_PAGE_SIZE;//每页记录数
		/*
		 * 2. 通过exprList来生成where子句
		 */
		StringBuilder whereSql = new StringBuilder(" where 1=1"); 
		List<Object> params = new ArrayList<Object>();//SQL中有问号，它是对应问号的值
		/*
		 * 3. 总记录数 
		 */
		String sql = "select count(*) from t_flower" + whereSql;
		Number number = (Number)qr.query(sql, new ScalarHandler(), params.toArray());
		int tr = number.intValue();//得到了总记录数
		/*
		 * 4. 得到beanList，即当前页记录
		 */
		sql = "select * from t_flower" + whereSql + " order by orderBy limit ?,?";
		params.add((pc-1) * ps);//当前页首行记录的下标
		params.add(ps);//一共查询几行，就是每页记录数
		
		List<Flower> beanList = qr.query(sql, new BeanListHandler<Flower>(Flower.class), 
				params.toArray());
		
		/*
		 * 5. 创建PageBean，设置参数
		 */
		PageBean<Flower> pb = new PageBean<Flower>();
		/*
		 * 其中PageBean没有url，这个任务由Servlet完成
		 */
		pb.setBeanList(beanList);
		pb.setPc(pc);
		pb.setPs(ps);
		pb.setTr(tr);
		
		return pb;
	}
	public PageBean<Flower> findByCname(String cname, int pc) throws SQLException {
		List<Expression> exprList = new ArrayList<Expression>();
		exprList.add(new Expression("cname", "like", "%" + cname + "%"));
		return findFlowersByCname(exprList, pc);
	}
	private PageBean<Flower> findFlowersByCname(List<Expression> exprList, int pc) throws SQLException {
		
		int ps = PageConstants.Flower_PAGE_SIZE;//每页记录数
		/*
		 * 通过exprList来生成where子句
		 */
		StringBuilder whereSql = new StringBuilder(" where 1=1"); 
		List<Object> params = new ArrayList<Object>();//SQL中有问号，它是对应问号的值
		for(Expression expr : exprList) {
			whereSql.append(" and ").append(expr.getName())
				.append(" ").append(expr.getOperator()).append(" ");
			if(!expr.getOperator().equals("is null")) {
				whereSql.append("?");
				params.add(expr.getValue());
			}
		}
		/*
		 * 3. 总记录数 
		 */
		String sql = "select count(*) from t_category t,t_flower f" + whereSql + " and t.cid = f.cid";
		Number number = (Number)qr.query(sql, new ScalarHandler(), params.toArray());
		int tr = number.intValue();//得到了总记录数
		/*
		 * 得到beanList，即当前页记录
		 */
		sql = "select f.* from t_flower f, t_category t " + whereSql + " and t.cid = f.cid " + " order by orderBy limit ?,?";
		params.add((pc-1) * ps);//当前页首行记录的下标
		params.add(ps);//一共查询几行，就是每页记录数
		
		List<Flower> beanList = qr.query(sql, new BeanListHandler<Flower>(Flower.class), 
				params.toArray());
		
		PageBean<Flower> pb = new PageBean<Flower>();
		/*
		 * 其中PageBean没有url，这个任务由Servlet完成
		 */
		pb.setBeanList(beanList);
		pb.setPc(pc);
		pb.setPs(ps);
		pb.setTr(tr);
		
		return pb;
	}
}
