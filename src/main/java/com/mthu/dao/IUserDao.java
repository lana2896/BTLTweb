package com.mthu.dao;

import java.util.List;
import com.mthu.entity.User;

public interface IUserDao {
	List<User> findAll();
	User findById(int id);
	void insert(User user);
	User findByUserName(String username);
	boolean checkExistUsername(String username);
	boolean checkExistEmail(String email);
	void update(User user);
	User findByEmail(String email);
}