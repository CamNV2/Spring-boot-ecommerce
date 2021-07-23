package com.app.ecommerce.entities;

import com.app.ecommerce.enums.PaymentMethod;
import com.app.ecommerce.enums.PaymentStatus;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "payment")
public class PaymentEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Enumerated(EnumType.STRING)
    private PaymentStatus status ;
    @Enumerated(EnumType.STRING)
    private PaymentMethod method ;

    private double amount ;

    @Column(name = "payment_date")
    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date paymentDate ;

    @ManyToOne
    @JoinColumn(name = "order_id")
    private OrderEntity orders;

    @ManyToOne
    @JoinColumn(name = "credit_cart_id")
    private CreditCartEntity creditCart ;

    public OrderEntity getOrders() {
        return orders;
    }

    public void setOrders(OrderEntity orders) {
        this.orders = orders;
    }

    public CreditCartEntity getCreditCart() {
        return creditCart;
    }

    public void setCreditCart(CreditCartEntity creditCart) {
        this.creditCart = creditCart;
    }

    public OrderEntity getOrder() {
        return orders;
    }

    public void setOrder(OrderEntity order) {
        this.orders = order;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public PaymentStatus getStatus() {
        return status;
    }

    public void setStatus(PaymentStatus status) {
        this.status = status;
    }

    public PaymentMethod getMethod() {
        return method;
    }

    public void setMethod(PaymentMethod method) {
        this.method = method;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }



}
