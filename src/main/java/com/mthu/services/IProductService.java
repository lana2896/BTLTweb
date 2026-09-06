package com.mthu.services;

import java.util.List;
import com.mthu.entity.Product;

public interface IProductService {
    void insert(Product product);
    void edit(Product product);
    void delete(int id);
    Product get(int id);
    List<Product> getAll();
    List<Product> getLatest(int limit);
    List<Product> getPaged(int page, int pageSize);
    int getTotalPages(int pageSize);
}