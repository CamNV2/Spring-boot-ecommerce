package com.app.ecommerce.repository;

import com.app.ecommerce.entities.ProductEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;


import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<ProductEntity , Integer> {

    @Query("select p from ProductEntity p order by p.id desc ")
    List<ProductEntity> findProductPages(Pageable p) ;

    @Query("select p from ProductEntity p where p.status='ACTIVE' order by p.id asc")
    public List<ProductEntity> getOldProduct(Pageable page) ;
    @Query("select p from ProductEntity p where p.status='ACTIVE' order by p.id desc ")
    public List<ProductEntity> getNewProduct(Pageable page) ;

    @Query("select p from ProductEntity p where p.status='ACTIVE'")
    public List<ProductEntity> findProductActives();

    @Query("select p from ProductEntity p where p.category.id = ?1")
    public List<ProductEntity> findProductByCategory(int id) ;
    @Query("select p from ProductEntity p where p.category.id = ?1 and p.category.status='ACTIVE'")
    public List<ProductEntity> findProductByCategoryPageable(int id , Pageable page) ;

    public List<ProductEntity> findByProductNameContaining(String name);

    @Query("select p from ProductEntity p where p.status= 'ACTIVE' order by p.price desc ")
    public List<ProductEntity> getProductByPriceDESC(Pageable page) ;

    @Query("select p from ProductEntity p where p.status = 'ACTIVE' order by p.price ASC  ")
    public List<ProductEntity> getProductByPriceAsc (Pageable page) ;

    @Query("select count(p.id) from CategoryEntity c left join ProductEntity p on c.id = p.category.id group by c.id")
    public List<Integer> countProductByCategory() ;
    @Query("select count(p.id) from CategoryEntity c left join ProductEntity p on c.id = p.category.id group by c.id order by c.id desc")
    public List<Integer> countProductByCategoryDESC() ;

    @Query("select p from ProductEntity p where p.productName like ?1 and p.category.id = ?2")
    public List<ProductEntity> getProductByNameAndCategories(String name , int id);

    @Query("select p from ProductEntity p where p.id = ?1")
    public ProductEntity getProductById(int id);
    @Query("select p from ProductEntity p where p.sales.salePercent > 10")
    public List<ProductEntity> getProductSale(Pageable page) ;

    @Query("select p from ProductEntity p where p.category.id = ?1")
    public List<ProductEntity> getProductByCate(int id) ;



}
