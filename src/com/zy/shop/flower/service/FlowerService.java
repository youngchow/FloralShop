package com.zy.shop.flower.service;

import java.sql.SQLException;

import com.zy.shop.flower.dao.FlowerDao;
import com.zy.shop.flower.domain.Flower;
import com.zy.shop.pager.PageBean;

public class FlowerService {

	private FlowerDao flowerDao = new FlowerDao();
	/**
	 * 返回当前分类下鲜花的个数
	 * @param cid
	 * @return
	 */
	public int findFlowerCountByCategory(String cid) {
		try {
			return flowerDao.findBookCountByCategory(cid);
		} catch(SQLException e) {
			throw new RuntimeException(e);
		}
	}
	/**
	 * 按分类查
	 * @param cid
	 * @param pc
	 * @return
	 */
	public PageBean<Flower> findByCategory(String cid, int pc) {
		try {
			return flowerDao.findByCategory(cid, pc);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	/**
	 * 添加鲜花
	 * @param book
	 */
	public void add(Flower flower) {
		try {
			flowerDao.add(flower);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	/**
	 * 加载鲜花
	 * @param fid
	 * @return
	 */
	public Flower load(String fid) {
		try {
			return flowerDao.findByBid(fid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	/**
	 * 修改鲜花
	 * @param flower
	 */
	public void edit(Flower flower) {
		try {
			flowerDao.edit(flower);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	/**
	 * 删除鲜花
	 * @param fid
	 */
	public void delete(String fid) {
		try {
			flowerDao.delete(fid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	public PageBean<Flower> findAllFlowers(int pc) {
		try {
			return flowerDao.getAllFlowers(pc);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	/**
	 * 按分类名进行模糊查询
	 * @param cname
	 * @param pc
	 * @return
	 */
	public PageBean<Flower> findByCname(String cname, int pc) {
		try {
			return flowerDao.findByCname(cname, pc);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

}
