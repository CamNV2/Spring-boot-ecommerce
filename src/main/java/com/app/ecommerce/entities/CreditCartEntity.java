package com.app.ecommerce.entities;

import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "cart_credit")
public class CreditCartEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id ;

    private double balance ;

    @Column(name = "cart_exday")
    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date cartExdate;

    @Column(name = "cart_name")
    private String cartName ;
    @Column(name = "cartNumber")
    private String cartNumber ;

    private String code ;

    @OneToMany(mappedBy = "creditCart", fetch = FetchType.LAZY , cascade = CascadeType.ALL)
    private List<PaymentEntity> payments ;

    public List<PaymentEntity> getPayments() {
        return payments;
    }

    public void setPayments(List<PaymentEntity> payments) {
        this.payments = payments;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public Date getCartExdate() {
        return cartExdate;
    }

    public void setCartExdate(Date cartExdate) {
        this.cartExdate = cartExdate;
    }

    public String getCartName() {
        return cartName;
    }

    public void setCartName(String cartName) {
        this.cartName = cartName;
    }

    public String getCartNumber() {
        return cartNumber;
    }

    public void setCartNumber(String cartNumber) {
        this.cartNumber = cartNumber;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }


}
