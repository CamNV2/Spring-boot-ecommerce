package com.app.ecommerce.services;

import com.app.ecommerce.entities.ProductEntity;
import com.app.ecommerce.repository.ProductRepository;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class ProductService {
    @Autowired
    ProductRepository productRepository ;


    public List<ProductEntity> getProducts() {
        List<ProductEntity> products = productRepository.findAll() ;
        return (List<ProductEntity>) products ;
    }
    public List<ProductEntity> getProductActives(){
        List<ProductEntity> products = productRepository.findProductActives() ;
        return (List<ProductEntity>) products ;
    }
    public List<ProductEntity> getProductPages(Pageable pageable) {
        List<ProductEntity> products = productRepository.findProductPages(pageable) ;
        return (List<ProductEntity>) products ;
    }
    @Transactional
    public ProductEntity findById(int id) {
        Optional<ProductEntity> productEntity = productRepository.findById(id) ;
        if(productEntity.isPresent()){
            ProductEntity product = productEntity.get() ;
            return product ;
        }
        else {
            return  new ProductEntity() ;
        }
    }
    public ProductEntity getProductById (int id) {
        return (ProductEntity) productRepository.getProductById(id) ;
    }
    public List<ProductEntity> getProductByCategoryPageable(int id , Pageable pageable) {
        return (List<ProductEntity>) productRepository.findProductByCategoryPageable(id , pageable) ;
    }


    public List<ProductEntity> searchProductByCate(int id){
        List<ProductEntity> productEntities = productRepository.findProductByCategory(id) ;
        return productEntities ;
    }
    public List<Integer> countProductByCategory(){
        return productRepository.countProductByCategory();
    }
    public List<Integer> countProductByCategoryDESC(){
        return productRepository.countProductByCategoryDESC();
    }
    public List<ProductEntity> getProductByCateId(int id) {
        return (List<ProductEntity>) productRepository.getProductByCate(id) ;
    }
    public List<ProductEntity> searchProduct(String key) {
        List<ProductEntity> productEntities = productRepository.findByProductNameContaining(key) ;

        return productEntities ;
    }
    public List<ProductEntity> getProductSale(Pageable pageable) {
        return (List<ProductEntity>) productRepository.getProductSale(pageable) ;
    }
    public List<ProductEntity> getProductByPriceASC(Pageable pageable) {
        return (List<ProductEntity>) productRepository.getProductByPriceAsc(pageable) ;
    }
    public List<ProductEntity> getProductPriceDESC(Pageable pageable) {
        return (List<ProductEntity>) productRepository.getProductByPriceDESC(pageable) ;
    }
    public void save (ProductEntity productEntity) {
        productRepository.save(productEntity) ;
    }
    public List<ProductEntity> getOldProduct(Pageable pageable) {
        List<ProductEntity> productEntities = productRepository.getOldProduct(pageable);
        return productEntities ;
    }
    public List<ProductEntity> getNewProduct(Pageable pageable) {
        List<ProductEntity> productEntities = productRepository.getNewProduct(pageable);
        return productEntities ;
    }

}
