package com.zy.shop.admin.service;

import java.sql.SQLException;

import com.zy.shop.admin.dao.AdminDao;
import com.zy.shop.admin.domain.Admin;

public class AdminService {

	private AdminDao adminDao = new AdminDao();
	/**
	 * 登录功能
	 * @param admin
	 * @return
	 */
	public Admin login(Admin admin) {
		try {
			return adminDao.find(admin.getAdminname(), admin.getAdminpwd());
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	
}
