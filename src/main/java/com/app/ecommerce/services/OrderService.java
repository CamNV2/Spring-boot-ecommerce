package com.app.ecommerce.services;

import com.app.ecommerce.entities.OrderEntity;
import com.app.ecommerce.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrderService {

    @Autowired
    OrderRepository orderRepository ;

    public void  save(OrderEntity orderEntity) {
        orderRepository.save(orderEntity);
    }
}
