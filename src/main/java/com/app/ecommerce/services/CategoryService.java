package com.app.ecommerce.services;

import com.app.ecommerce.entities.CategoryEntity;
import com.app.ecommerce.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryService {

    @Autowired
    CategoryRepository categoryRepository ;

    public List<CategoryEntity> getCategories() {return (List<CategoryEntity>) categoryRepository.findAll() ;}

    public List<CategoryEntity> getCategoryPage(Pageable pageable) {
        return (List<CategoryEntity>) categoryRepository.getCategoryPage(pageable) ;
    }
    public void save(CategoryEntity entity) {
        categoryRepository.save(entity);
    }
    public CategoryEntity getCategoryById(int id) {
        CategoryEntity categoryEntity = categoryRepository.findCategoryById(id);
        if(categoryEntity == null) {
            System.out.println("Category Not Found!");
        }
        return categoryEntity ;
    }
    public List<CategoryEntity> getCategoryList(Pageable pageable){
        return (List<CategoryEntity>) categoryRepository.getCategoryList(pageable) ;
    }
}
