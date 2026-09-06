package com.mthu.services.impl;

import java.util.Date;

import com.mthu.dao.IUserDao;

import com.mthu.dao.impl.UserDaoImpl;
import com.mthu.entity.User;
import com.mthu.services.IUserService;
import com.mthu.utils.*;

public class UserService implements IUserService {

	IUserDao userDao = new UserDaoImpl();

	@Override
	public User login(String username, String password) {
	    User user = this.FindByUserName(username);
	    if (user != null && password.equals(user.getPassword()) && user.isActive()) {
	        return user;
	    }
	    return null;
	}

	@Override
	public User FindByUserName(String username) {
		return userDao.findByUserName(username);
	}

	// UserService.java
	@Override
	public User findByEmail(String email) {
	    return userDao.findByEmail(email);
	}
	
	@Override
	public boolean checkExistUsername(String username) {
		return userDao.checkExistUsername(username);
	}

	@Override
	public boolean checkExistEmail(String email) {
		return userDao.checkExistEmail(email);
	}
	
	@Override
	public boolean register(String username, String password, String email, String fullname) {
	    if (userDao.checkExistUsername(username)) return false;

	    User u = new User();
	    u.setUsername(username);
	    u.setPassword(password); // nên đổi sang BCrypt.hashpw(password, BCrypt.gensalt())
	    u.setEmail(email);
	    u.setFullname(fullname);
	    u.setRoleid(3);
	    u.setActive(false);

	    String otp = OtpUtil.generateOtp();
	    u.setOtpCode(otp);
	    u.setOtpExpiry(new Date(System.currentTimeMillis() + Constant.OTP_EXPIRE_MINUTES * 60 * 1000));
	    userDao.insert(u);

	    try {
	        MailUtil.sendOtpMail(email, otp, "Kích hoạt tài khoản");
	    } catch (Exception e) { e.printStackTrace(); }

	    return true;
	}

	@Override
	public boolean verifyOtp(String email, String otp) {
	    User u = userDao.checkExistEmail(email) ? findByEmail(email) : null; // hoặc viết findByEmail riêng trong DAO
	    if (u == null || u.getOtpCode() == null) return false;
	    if (!u.getOtpCode().equals(otp)) return false;
	    if (u.getOtpExpiry().before(new Date())) return false;

	    u.setActive(true);
	    u.setOtpCode(null);
	    userDao.update(u);
	    return true;
	}

	@Override
	public void resendOtp(String email) throws Exception {
	    User u = findByEmail(email);
	    if (u == null || u.isActive()) return;
	    String otp = OtpUtil.generateOtp();
	    u.setOtpCode(otp);
	    u.setOtpExpiry(new Date(System.currentTimeMillis() + Constant.OTP_EXPIRE_MINUTES * 60 * 1000));
	    userDao.update(u);
	    MailUtil.sendOtpMail(email, otp, "Kích hoạt tài khoản");
	}
	
	@Override
	public void sendForgotPasswordOtp(String email) throws Exception {
	    User u = findByEmail(email);
	    if (u == null) return;
	    String otp = OtpUtil.generateOtp();
	    u.setOtpCode(otp);
	    u.setOtpExpiry(new Date(System.currentTimeMillis() + Constant.OTP_EXPIRE_MINUTES * 60 * 1000));
	    userDao.update(u);
	    MailUtil.sendOtpMail(email, otp, "Đặt lại mật khẩu");
	}

	@Override
	public boolean resetPassword(String email, String otp, String newPassword) {
	    User u = findByEmail(email);
	    if (u == null || u.getOtpCode() == null || !u.getOtpCode().equals(otp)) return false;
	    if (u.getOtpExpiry().before(new Date())) return false;
	    u.setPassword(newPassword); // nên hash bằng BCrypt
	    u.setOtpCode(null);
	    userDao.update(u);
	    return true;
	}
}