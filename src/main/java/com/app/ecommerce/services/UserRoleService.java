package com.app.ecommerce.services;

import com.app.ecommerce.entities.UserRoleEntity;
import com.app.ecommerce.repository.UserRoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserRoleService {
    @Autowired
    UserRoleRepository userRoleRepository ;

    public List<UserRoleEntity> getUserRole() {
        return userRoleRepository.findAll() ;
    }

    public UserRoleEntity getUserRoleById(int id) {
        Optional<UserRoleEntity> userRole = userRoleRepository.findById(id);
        if (userRole.isPresent()) {
            UserRoleEntity userRoleEntity = userRole.get();
            return userRoleEntity;
        } else {
            return new UserRoleEntity();
        }
    }
    public void save(UserRoleEntity userRole) {
        userRoleRepository.save(userRole);
    }
}
