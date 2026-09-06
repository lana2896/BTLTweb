package com.mthu.services;

import java.util.List;

import com.mthu.entity.Category;

public interface ICategoryService {
	void insert(Category category);

	void edit(Category category);

	void delete(int id);

	Category get(int id);

	Category get(String name);

	List<Category> getAll();

	List<Category> search(String keyword);
}
