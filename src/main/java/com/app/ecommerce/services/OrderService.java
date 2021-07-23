package com.app.ecommerce.services;

import com.app.ecommerce.entities.OrderEntity;
import com.app.ecommerce.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class OrderService {

    @Autowired
    OrderRepository orderRepository ;

    public void  save(OrderEntity orderEntity) {
        orderRepository.save(orderEntity);
    }

    public List<OrderEntity> findOrderByAccount(String email) {
        List<OrderEntity>  orderEntities = orderRepository.findByAccount(email);
        return orderEntities ;
    }
    public OrderEntity findOrderById(int id) {
        return orderRepository.findByOrderId(id) ;
    }

    public List<OrderEntity> getOrders () {
        List<OrderEntity> orders = orderRepository.findAll() ;
        return orders ;
    }
    public List<OrderEntity> getOrderPageable(Pageable pageable) {
        List<OrderEntity> orderPages = orderRepository.getOrderPageable(pageable);
        return orderPages ;
    }
    public List<OrderEntity> findOrderByDate(Date d1 ,Date d2) {
        List<OrderEntity> orderEntities = orderRepository.findOrderByDate(d1, d2) ;
        return orderEntities ;
    }
    public List<OrderEntity> searchOrderByNameAndId( String email, String name) {
        List<OrderEntity> orderEntities = orderRepository.findOrderByNameAndId( email , name);
        return orderEntities;
    }
}
