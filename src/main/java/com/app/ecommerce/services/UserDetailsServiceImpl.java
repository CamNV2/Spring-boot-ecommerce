package com.app.ecommerce.services;

import com.app.ecommerce.entities.UserEntity;
import com.app.ecommerce.entities.UserRoleEntity;
import com.app.ecommerce.repository.UserRepository;
import com.app.ecommerce.repository.UserRoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.HashSet;
import java.util.Set;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    private UserRepository userRepository ;

    @Autowired
    private UserRoleRepository userRoleRepository ;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        UserEntity user = userRepository.findByEmailActive(email) ;
        if(user == null) {
            throw new UsernameNotFoundException(email);
        }
        Set<UserRoleEntity> rolesNames = userRoleRepository.findByUsers_Email(email) ;
        Set<GrantedAuthority> grantList = new HashSet<>() ;
        if(!CollectionUtils.isEmpty(rolesNames)) {
            for(UserRoleEntity roleEntity : rolesNames) {
                GrantedAuthority authority = new SimpleGrantedAuthority(roleEntity.getRole().toString()) ;
                grantList.add(authority) ;
            }
        }
        return (UserDetails) new User(user.getEmail() , user.getPassword() , grantList) ;

    }
}
