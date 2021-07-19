package com.app.ecommerce.repository;

import com.app.ecommerce.entities.UserEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<UserEntity , Integer> {

    UserEntity findByEmailContaining(String email) ;

    @Query("select u from UserEntity u where u.email= ?1 and u.status='ACTIVE' ")
    public UserEntity findByEmailActive(String email);
    
    @Query("select u from UserEntity u where u.id = ?1")
    public UserEntity findUserById (int id);

    @Query("select u from UserEntity u")
    public List<UserEntity> getUserPage(Pageable pageable);

    @Query("select u from UserEntity u where u.email like %?1% or u.fullName like %?2%")
    public List<UserEntity> searchUserByEmail(String key1 , String key2) ;
}
