package com.app.ecommerce.repository;

import com.app.ecommerce.entities.OrderEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<OrderEntity , Integer> {

    @Query("select o from OrderEntity o where o.email like ?1 order by o.id desc ")
    public List<OrderEntity> findByAccount(String email);

    @Query("select o from OrderEntity o where o.id = ?1")
    public OrderEntity findByOrderId(int id) ;

    @Query("select o from OrderEntity o order by o.id desc ")
    public List<OrderEntity> getOrderPageable(Pageable page) ;

    @Query("select o from OrderEntity o where o.orderDate between ?1 and ?2 ")
    public List<OrderEntity> findOrderByDate(Date d1 , Date d2) ;

    @Query("select o from OrderEntity o where  o.email = ?1 or o.fullName = ?2")
    public List<OrderEntity> findOrderByNameAndId( String email , String name ) ;
}
