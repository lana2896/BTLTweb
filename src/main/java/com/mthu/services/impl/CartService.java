package com.mthu.services.impl;

import java.util.Map;

import com.mthu.connection.JPAConfig;
import com.mthu.dao.impl.CartImpl;
import com.mthu.entity.Cart;
import com.mthu.entity.CartItem;
import com.mthu.entity.Product;
import com.mthu.services.ICartService;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

public class CartService implements ICartService {
    private final CartImpl cartDao = new CartImpl();

    @Override
    public Cart getCart(int userId) {
        Cart cart = cartDao.findByUserId(userId);
        return cart != null ? cart : new Cart();
    }

    @Override
    public void addItem(int userId, int productId, int quantity) {
        if (quantity < 1) {
            throw new IllegalArgumentException("Số lượng phải lớn hơn 0");
        }
        updateCart(userId, productId, quantity);
    }

    @Override
    public void updateItem(int userId, int itemId, int quantity) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            CartItem item = findItem(em, userId, itemId);
            if (item == null) {
                throw new IllegalArgumentException("Sản phẩm không tồn tại trong giỏ hàng");
            }
            if (quantity <= 0) {
                em.remove(item);
            } else {
                validateStock(item.getProduct(), quantity);
                item.setQuantity(quantity);
            }
            transaction.commit();
        } catch (RuntimeException e) {
            rollback(transaction);
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void updateItems(int userId, Map<Integer, Integer> itemQuantities) {
        if (itemQuantities == null || itemQuantities.isEmpty()) {
            return;
        }
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            for (Map.Entry<Integer, Integer> entry : itemQuantities.entrySet()) {
                CartItem item = findItem(em, userId, entry.getKey());
                if (item == null) {
                    continue;
                }
                int quantity = entry.getValue();
                if (quantity <= 0) {
                    em.remove(item);
                } else {
                    validateStock(item.getProduct(), quantity);
                    item.setQuantity(quantity);
                }
            }
            transaction.commit();
        } catch (RuntimeException e) {
            rollback(transaction);
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void removeItem(int userId, int itemId) {
        updateItem(userId, itemId, 0);
    }

    @Override
    public void clearCart(int userId) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.createQuery("DELETE FROM CartItem i WHERE i.cart.id IN "
                    + "(SELECT c.id FROM Cart c WHERE c.user.id = :userId)")
                    .setParameter("userId", userId)
                    .executeUpdate();
            transaction.commit();
        } catch (RuntimeException e) {
            rollback(transaction);
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void selectItem(int userId, int itemId) {
        setSelected(userId, itemId, true);
    }

    @Override
    public void unselectItem(int userId, int itemId) {
        setSelected(userId, itemId, false);
    }

    @Override
    public void selectAll(int userId, boolean selected) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.createQuery("UPDATE CartItem i SET i.selected = :selected WHERE i.cart.id IN "
                    + "(SELECT c.id FROM Cart c WHERE c.user.id = :userId)")
                    .setParameter("selected", selected)
                    .setParameter("userId", userId)
                    .executeUpdate();
            transaction.commit();
        } catch (RuntimeException e) {
            rollback(transaction);
            throw e;
        } finally {
            em.close();
        }
    }

    private void setSelected(int userId, int itemId, boolean selected) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            CartItem item = findItem(em, userId, itemId);
            if (item == null) {
                throw new IllegalArgumentException("Sản phẩm không tồn tại trong giỏ hàng");
            }
            item.setSelected(selected);
            transaction.commit();
        } catch (RuntimeException e) {
            rollback(transaction);
            throw e;
        } finally {
            em.close();
        }
    }

    private void updateCart(int userId, int productId, int quantity) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            Product product = em.find(Product.class, productId);
            if (product == null) {
                throw new IllegalArgumentException("Sản phẩm không tồn tại");
            }
            Cart cart = findOrCreateCart(em, userId);
            CartItem existing = cart.getItems().stream()
                    .filter(item -> item.getProduct().getId() == productId)
                    .findFirst()
                    .orElse(null);
            int newQuantity = existing == null ? quantity : existing.getQuantity() + quantity;
            validateStock(product, newQuantity);
            if (existing == null) {
                CartItem item = new CartItem();
                item.setProduct(product);
                item.setQuantity(quantity);
                item.setPrice(product.getPrice()); // lưu giá tại thời điểm thêm vào giỏ
                item.setSelected(true); // mặc định chọn khi thêm
                cart.addItem(item);
            } else {
                existing.setQuantity(newQuantity);
            }
            transaction.commit();
        } catch (RuntimeException e) {
            rollback(transaction);
            throw e;
        } finally {
            em.close();
        }
    }

    private Cart findOrCreateCart(EntityManager em, int userId) {
        Cart cart = em.createQuery("SELECT DISTINCT c FROM Cart c LEFT JOIN FETCH c.items i "
                + "WHERE c.user.id = :userId", Cart.class)
                .setParameter("userId", userId)
                .getResultStream()
                .findFirst()
                .orElse(null);
        if (cart == null) {
            cart = new Cart();
            cart.setUser(em.getReference(com.mthu.entity.User.class, userId));
            em.persist(cart);
        }
        return cart;
    }

    private CartItem findItem(EntityManager em, int userId, int itemId) {
        return em.createQuery("SELECT i FROM CartItem i JOIN i.cart c WHERE i.id = :itemId "
                + "AND c.user.id = :userId", CartItem.class)
                .setParameter("itemId", itemId)
                .setParameter("userId", userId)
                .getResultStream()
                .findFirst()
                .orElse(null);
    }

    private void validateStock(Product product, int quantity) {
        if (quantity > product.getQuantity()) {
            throw new IllegalArgumentException("Số lượng vượt quá tồn kho của sản phẩm");
        }
    }

    private void rollback(EntityTransaction transaction) {
        if (transaction.isActive()) {
            transaction.rollback();
        }
    }
}