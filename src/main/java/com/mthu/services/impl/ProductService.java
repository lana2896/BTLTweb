package com.mthu.services.impl;

import java.util.List;

import com.mthu.dao.IProductDao;
import com.mthu.dao.impl.ProductImpl;
import com.mthu.entity.Product;
import com.mthu.services.IProductService;

public class ProductService implements IProductService {

    IProductDao productDao = new ProductImpl();

    @Override
    public void insert(Product product) {
        productDao.insert(product);
    }

    @Override
    public void edit(Product product) {
        productDao.update(product);
    }

    @Override
    public void delete(int id) {
        productDao.delete(id);
    }

    @Override
    public Product get(int id) {
        return productDao.findById(id);
    }

    @Override
    public List<Product> getAll() {
        return productDao.findAll();
    }

    @Override
   public List<Product> getLatest(int limit) {
        return productDao.findLatest(limit);
    }

    @Override
    public List<Product> getPaged(int page, int pageSize) {
        return productDao.findPaged(page, pageSize);
    }

    @Override
    public int getTotalPages(int pageSize) {
        long total = productDao.countAll();
        return (int) Math.ceil(total / (double) pageSize);
    }
}