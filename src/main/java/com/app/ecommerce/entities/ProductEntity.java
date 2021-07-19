package com.app.ecommerce.entities;

import com.app.ecommerce.enums.ProductStatus;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;
import java.util.List;
import java.util.Set;


@Entity
@Table(name = "product")
public class ProductEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id ;

    @Column(name = "product_name")
    private String productName ;

    private double price ;
    private int quantity ;
    private String image ;
    private String description ;

    @Enumerated(EnumType.STRING)
    private ProductStatus status = ProductStatus.ACTIVE ;

    private String warranty ;

    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @Column(name = "create_date")
    private Date createDate = new Date() ;




    @ManyToOne
    @JoinColumn(name = "category_id")
    private CategoryEntity category ;

    @ManyToOne
    @JoinColumn(name = "sale_id")
    private SaleEntity sales ;

    @OneToMany(mappedBy = "products" , fetch = FetchType.LAZY , cascade = CascadeType.ALL)
    private Set<OrderDetailEntity> orderDetails ;

    public Set<OrderDetailEntity> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(Set<OrderDetailEntity> orderDetails) {
        this.orderDetails = orderDetails;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public ProductStatus getStatus() {
        return status;
    }

    public void setStatus(ProductStatus status) {
        this.status = status;
    }

    public String getWarranty() {
        return warranty;
    }

    public void setWarranty(String warranty) {
        this.warranty = warranty;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public SaleEntity getSales() {
        return sales;
    }

    public void setSales(SaleEntity sales) {
        this.sales = sales;
    }
    public double getPriceSale (){
       return this.price - (this.price*this.sales.getSalePercent()/100) ;
    }
    public int getId() {
        return id;
    }

    public CategoryEntity getCategory() {
        return category;
    }

    public void setCategory(CategoryEntity category) {
        this.category = category;
    }
}
