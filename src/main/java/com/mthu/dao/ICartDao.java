package com.mthu.dao;

import com.mthu.entity.Cart;

public interface ICartDao {
    Cart findByUserId(int userId);
}