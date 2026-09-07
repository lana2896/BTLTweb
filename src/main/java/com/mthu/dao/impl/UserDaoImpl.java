package com.mthu.dao.impl;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import com.mthu.connection.JPAConfig;
import com.mthu.dao.IUserDao;
import com.mthu.entity.User;

public class UserDaoImpl implements IUserDao {

	@Override
	public List<User> findAll() {
		EntityManager em = JPAConfig.getEntityManager();
		try {
			return em.createQuery("SELECT u FROM User u", User.class).getResultList();
		} finally {
			em.close();
		}
	}

	@Override
	public User findById(int id) {
		EntityManager em = JPAConfig.getEntityManager();
		try {
			return em.find(User.class, id);
		} finally {
			em.close();
		}
	}

	@Override
	public void insert(User user) {
		EntityManager em = JPAConfig.getEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			em.persist(user);
			tx.commit();
		} catch (Exception e) {
			e.printStackTrace();
			tx.rollback();
		} finally {
			em.close();
		}
	}

	@Override
	public User findByUserName(String username) {
		EntityManager em = JPAConfig.getEntityManager();
		try {
			TypedQuery<User> q = em.createQuery(
					"SELECT u FROM User u WHERE u.username = :username", User.class);
			q.setParameter("username", username);
			return q.getResultList().stream().findFirst().orElse(null);
		} finally {
			em.close();
		}
	}

	@Override
	public boolean checkExistUsername(String username) {
		return findByUserName(username) != null;
	}

	@Override
	public boolean checkExistEmail(String email) {
		EntityManager em = JPAConfig.getEntityManager();
		try {
			TypedQuery<User> q = em.createQuery(
					"SELECT u FROM User u WHERE u.email = :email", User.class);
			q.setParameter("email", email);
			return !q.getResultList().isEmpty();
		} finally {
			em.close();
		}
	}
	
	@Override
	public User findByEmail(String email) {
	    EntityManager em = JPAConfig.getEntityManager();
	    try {
	        TypedQuery<User> q = em.createQuery(
	                "SELECT u FROM User u WHERE u.email = :email", User.class);
	        q.setParameter("email", email);
	        return q.getResultList().stream().findFirst().orElse(null);
	    } finally {
	        em.close();
	    }
	}
	
	@Override
	public void update(User user) {
	    EntityManager em = JPAConfig.getEntityManager();
	    EntityTransaction tx = em.getTransaction();
	    try {
	        tx.begin();
	        em.merge(user);
	        tx.commit();
	    } catch (Exception e) {
	        e.printStackTrace();
	        tx.rollback();
	    } finally {
	        em.close();
	    }
	}
}