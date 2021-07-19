package com.app.ecommerce.services;

import com.app.ecommerce.entities.UserEntity;
import com.app.ecommerce.repository.UserRepository;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserService {

    @Autowired
    UserRepository userRepository ;

    @Transactional
    public List<UserEntity> getUsers() {
        List<UserEntity> users = (List<UserEntity>) userRepository.findAll();
        for (UserEntity user : users) {
            Hibernate.initialize(user.getUserRoles());
        }
        return (List<UserEntity>) users;
    }
    public List<UserEntity> getUserPages(Pageable pageable ) {
        return (List<UserEntity>) userRepository.getUserPage(pageable) ;
    }
    public List<UserEntity> findUserByEmailAndName(String key1 , String key2) {
        return (List<UserEntity>) userRepository.searchUserByEmail(key1 , key2) ;
     }
    public void save(UserEntity userEntity) {
        userRepository.save(userEntity);
    }
    public UserEntity findUserById (int id) {
        return (UserEntity) userRepository.findUserById(id) ;
    }
    public UserEntity findByEmail(String email) {
        return (UserEntity) userRepository.findByEmailContaining(email) ;
    }
}
