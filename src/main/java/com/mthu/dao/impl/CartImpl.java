package com.mthu.dao.impl;

import com.mthu.connection.JPAConfig;
import com.mthu.dao.ICartDao;
import com.mthu.entity.Cart;

import jakarta.persistence.EntityManager;

public class CartImpl implements ICartDao {
    @Override
    public Cart findByUserId(int userId) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT DISTINCT c FROM Cart c LEFT JOIN FETCH c.items i LEFT JOIN FETCH i.product "
                            + "WHERE c.user.id = :userId",
                    Cart.class)
                    .setParameter("userId", userId)
                    .getResultStream()
                    .findFirst()
                    .orElse(null);
        } finally {
            em.close();
        }
    }
}