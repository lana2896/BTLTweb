package com.mthu.dao.impl;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import com.mthu.connection.JPAConfig;
import com.mthu.dao.ICategoryDao;
import com.mthu.entity.Category;

public class CategoryImpl implements ICategoryDao {

    @Override
    public void insert(Category category) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(category);
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            tx.rollback();
        } finally {
            em.close();
        }
    }

    @Override
    public void edit(Category category) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(category);
            tx.commit();
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(int id) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Category c = em.find(Category.class, id);
            if (c != null) em.remove(c);
            tx.commit();
        } finally {
            em.close();
        }
    }

    @Override
    public Category get(int id) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            return em.find(Category.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public Category get(String name) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Category> q = em.createQuery(
                "SELECT c FROM Category c WHERE c.catename = :name", Category.class);
            q.setParameter("name", name);
            return q.getResultList().stream().findFirst().orElse(null);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Category> getAll() {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            return em.createQuery("SELECT c FROM Category c", Category.class).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Category> search(String keyword) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Category> q = em.createQuery(
                "SELECT c FROM Category c WHERE c.catename LIKE :kw", Category.class);
            q.setParameter("kw", "%" + keyword + "%");
            return q.getResultList();
        } finally {
            em.close();
        }
    }
}