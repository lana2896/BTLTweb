package com.mthu.dao.impl;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import com.mthu.connection.JPAConfig;
import com.mthu.dao.IProductDao;
import com.mthu.entity.Product;

public class ProductImpl implements IProductDao {

    @Override
    public List<Product> findAll() {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            return em.createQuery("SELECT p FROM Product p", Product.class).getResultList();
        } finally { em.close(); }
    }

    @Override
    public Product findById(int id) {
        EntityManager em = JPAConfig.getEntityManager();
        try { return em.find(Product.class, id); } finally { em.close(); }
    }

    @Override
    public void insert(Product p) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try { tx.begin(); em.persist(p); tx.commit(); }
        catch (Exception e) { e.printStackTrace(); tx.rollback(); }
        finally { em.close(); }
    }

    @Override
    public void update(Product p) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try { tx.begin(); em.merge(p); tx.commit(); }
        catch (Exception e) { e.printStackTrace(); tx.rollback(); }
        finally { em.close(); }
    }

    @Override
    public void delete(int id) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Product p = em.find(Product.class, id);
            if (p != null) em.remove(p);
            tx.commit();
        } catch (Exception e) { e.printStackTrace(); tx.rollback(); }
        finally { em.close(); }
    }

    @Override
    public List<Product> findLatest(int limit) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Product> q = em.createNamedQuery("Product.findLatest", Product.class);
            q.setMaxResults(limit);
            return q.getResultList();
        } finally { em.close(); }
    }

    @Override
    public List<Product> findPaged(int page, int pageSize) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Product> q = em.createQuery(
                "SELECT p FROM Product p ORDER BY p.createdAt DESC", Product.class);
            q.setFirstResult((page - 1) * pageSize);
            q.setMaxResults(pageSize);
            return q.getResultList();
        } finally { em.close(); }
    }

    @Override
    public long countAll() {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(p) FROM Product p", Long.class).getSingleResult();
        } finally { em.close(); }
    }
}