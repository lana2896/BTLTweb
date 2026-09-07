package com.mthu.dao;

import java.util.List;
import com.mthu.entity.Product;

public interface IProductDao {
    List<Product> findAll();
    Product findById(int id);
    void insert(Product p);
    void update(Product p);
    void delete(int id);
    List<Product> findLatest(int limit);
    List<Product> findPaged(int page, int pageSize);
    long countAll();
}