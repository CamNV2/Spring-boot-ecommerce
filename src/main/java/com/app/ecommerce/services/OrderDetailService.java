package com.app.ecommerce.services;


import com.app.ecommerce.entities.OrderDetailEntity;
import com.app.ecommerce.repository.OrderDetailRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class OrderDetailService {

    @Autowired
    OrderDetailRepository orderDetailRepository ;

    public double totalPrice(HashMap<Integer , OrderDetailEntity> cartItems) {
        double total = 0 ;
        for(Map.Entry<Integer , OrderDetailEntity> entry : cartItems.entrySet()) {
            total += entry.getValue().getQuantity() * entry.getValue().getProducts().getPriceSale();
        }
        return total ;
    }
    public void save (OrderDetailEntity orderDetailEntity) {
        orderDetailRepository.save(orderDetailEntity);
    }
}
