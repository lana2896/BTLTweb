package com.mthu.services;

import java.util.Map;

import com.mthu.entity.Cart;

public interface ICartService {
    Cart getCart(int userId);
    void addItem(int userId, int productId, int quantity);
    void updateItem(int userId, int itemId, int quantity);
    // Cập nhật số lượng nhiều sản phẩm cùng lúc (nút "Cập nhật giỏ hàng")
    void updateItems(int userId, Map<Integer, Integer> itemQuantities);
    void removeItem(int userId, int itemId);
    // Xóa toàn bộ sản phẩm trong giỏ hàng
    void clearCart(int userId);
    // Chọn / bỏ chọn 1 sản phẩm để thanh toán
    void selectItem(int userId, int itemId);
    void unselectItem(int userId, int itemId);
    // Chọn / bỏ chọn tất cả sản phẩm trong giỏ
    void selectAll(int userId, boolean selected);
}