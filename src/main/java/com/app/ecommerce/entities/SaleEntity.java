package com.app.ecommerce.entities;

import javax.persistence.*;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "sale")
public class SaleEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "sale_id")
    private String saleId ;

    @Column(name = "sale_percent")
    private int salePercent ;


    @OneToMany(mappedBy = "sales" , fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private Set<ProductEntity> products ;

    public Set<ProductEntity> getProducts() {
        return products;
    }
    public void setProducts(Set<ProductEntity> products) {
        this.products = products;
    }
    public String getSaleId() {
        return saleId;
    }
    public void setSaleId(String saleId) {
        this.saleId = saleId;
    }
    public int getSalePercent() {
        return salePercent;
    }
    public void setSalePercent(int salePercent) {
        this.salePercent = salePercent;
    }

}
