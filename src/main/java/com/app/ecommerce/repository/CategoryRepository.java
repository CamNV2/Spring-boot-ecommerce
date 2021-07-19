package com.app.ecommerce.repository;

import com.app.ecommerce.entities.CategoryEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CategoryRepository extends JpaRepository<CategoryEntity , Integer> {

    @Query("select c from CategoryEntity c where c.status = 'ACTIVE'")
    public List<CategoryEntity> getCategoryPage (Pageable page) ;
}
