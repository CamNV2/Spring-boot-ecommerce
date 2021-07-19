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
}
