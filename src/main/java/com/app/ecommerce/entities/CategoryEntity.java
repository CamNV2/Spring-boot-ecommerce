package com.app.ecommerce.entities;

import com.app.ecommerce.enums.CategoryStatus;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "category")
public class CategoryEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id ;

    @Column(name = "category_name")
    private String categoryName ;

    private String description;

    @Enumerated(EnumType.STRING)
    private CategoryStatus status = CategoryStatus.ACTIVE ;

    @OneToMany(mappedBy = "category" , fetch = FetchType.LAZY , cascade = CascadeType.ALL)
    private Set<ProductEntity> products ;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public CategoryStatus getStatus() {
        return status;
    }

    public void setStatus(CategoryStatus status) {
        this.status = status;
    }

    public Set<ProductEntity> getProducts() {
        return products;
    }

    public void setProducts(Set<ProductEntity> products) {
        this.products = products;
    }
}
