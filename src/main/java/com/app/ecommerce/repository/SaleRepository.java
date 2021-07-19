package com.app.ecommerce.repository;

import com.app.ecommerce.entities.SaleEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SaleRepository  extends JpaRepository<SaleEntity , Integer> {

}
