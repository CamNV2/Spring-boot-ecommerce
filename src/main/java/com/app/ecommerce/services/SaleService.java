package com.app.ecommerce.services;

import com.app.ecommerce.entities.SaleEntity;
import com.app.ecommerce.repository.SaleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SaleService {

    @Autowired
    SaleRepository saleRepository ;

    public List<SaleEntity> getAllSales(){
        return (List<SaleEntity>) saleRepository.findAll();
    }
}
