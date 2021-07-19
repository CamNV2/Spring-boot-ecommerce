package com.app.ecommerce.services;

import com.app.ecommerce.entities.PaymentEntity;
import com.app.ecommerce.repository.PaymentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PaymentService {

    @Autowired
    PaymentRepository paymentRepository ;

    public void save (PaymentEntity paymentEntity) {
        paymentRepository.save(paymentEntity);
    }
}
