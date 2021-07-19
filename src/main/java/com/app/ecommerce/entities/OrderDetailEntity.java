package com.app.ecommerce.entities;

import javax.persistence.*;
import java.io.Serializable;


@Entity
@Table(name = "order_detail")
public class OrderDetailEntity implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id" , nullable = false)
    private int id ;
    private double discount ;
    private double price ;
    private int quantity ;


    @ManyToOne
    @JoinColumn(name = "product_id")
    private ProductEntity products ;



    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public ProductEntity getProducts() {
        return products;
    }

    public void setProducts(ProductEntity products) {
        this.products = products;
    }
}
