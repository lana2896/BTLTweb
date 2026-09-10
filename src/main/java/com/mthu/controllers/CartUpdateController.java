package com.mthu.controllers;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import com.mthu.entity.User;
import com.mthu.services.ICartService;
import com.mthu.services.impl.CartService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/cart/update")
public class CartUpdateController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ICartService cartService = new CartService();

    // Hỗ trợ 2 chế độ:
    // 1) Cập nhật 1 sản phẩm: itemId=<id>&quantity=<n>
    // 2) Cập nhật hàng loạt (nút "Cập nhật giỏ hàng"): itemId=<id1>&quantity=<n1>&itemId=<id2>&quantity=<n2>...
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User account = CartController.getAccount(req.getSession(false));
        if (account == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        try {
            String[] itemIds = req.getParameterValues("itemId");
            String[] quantities = req.getParameterValues("quantity");
            if (itemIds == null || quantities == null || itemIds.length != quantities.length) {
                throw new IllegalArgumentException("Dữ liệu cập nhật không hợp lệ");
            }
            if (itemIds.length == 1) {
                cartService.updateItem(account.getId(), Integer.parseInt(itemIds[0]), Integer.parseInt(quantities[0]));
            } else {
                Map<Integer, Integer> itemQuantities = new LinkedHashMap<>();
                for (int i = 0; i < itemIds.length; i++) {
                    itemQuantities.put(Integer.parseInt(itemIds[i]), Integer.parseInt(quantities[i]));
                }
                cartService.updateItems(account.getId(), itemQuantities);
            }
            req.getSession().setAttribute("cartMessage", "Đã cập nhật giỏ hàng.");
        } catch (RuntimeException e) {
            req.getSession().setAttribute("cartMessage", e.getMessage());
        }
        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}