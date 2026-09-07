package com.mthu.services;

import com.mthu.entity.User;

public interface IUserService {
	User login(String username, String password);
	User FindByUserName(String username);
	User findByEmail(String email);
	boolean register(String username, String password, String email, String fullname);
	boolean checkExistUsername(String username);
	boolean checkExistEmail(String email);
	boolean verifyOtp(String email, String otp);
	void resendOtp(String email) throws Exception;
	void sendForgotPasswordOtp(String email) throws Exception;
	boolean resetPassword(String email, String otp, String newPassword);

	/** Lay thong tin user theo id (dung cho trang profile) */
	User findById(int id);

	/**
	 * Cap nhat ho ten, so dien thoai va (tuy chon) anh dai dien cua user.
	 * @param newImagePath duong dan anh moi (null neu nguoi dung khong doi anh)
	 * @return User da duoc cap nhat, hoac null neu khong tim thay user
	 */
	User updateProfile(int userId, String fullname, String phone, String newImagePath);
}