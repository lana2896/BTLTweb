package com.mthu.services.impl;

import java.util.List;


import com.mthu.entity.Category;

import com.mthu.dao.ICategoryDao;
import com.mthu.dao.impl.CategoryImpl;
import com.mthu.services.ICategoryService;

public class CategoryService implements ICategoryService {
		ICategoryDao categoryDAO = new CategoryImpl();

		public void insert(Category category) {
			categoryDAO.insert(category);
		}

		public void edit(Category category) {
			categoryDAO.edit(category);
		}

		public void delete(int id) {
			categoryDAO.delete(id);
		}

		public Category get(int id) {
			return categoryDAO.get(id);
		}

		public Category get(String name) {
			return categoryDAO.get(name);
		}

		public List<Category> getAll() {
			return categoryDAO.getAll();
		}

		public List<Category> search(String keyword) {
			return categoryDAO.search(keyword);
		}


}
