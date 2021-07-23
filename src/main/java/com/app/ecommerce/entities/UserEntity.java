package com.app.ecommerce.entities;

import com.app.ecommerce.enums.UserStatus;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "user" )
public class UserEntity extends CustomerInfo implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id ;
    private String password ;


    @Enumerated(EnumType.STRING)
    private UserStatus status = UserStatus.INACTIVE ;

    @OneToMany(mappedBy = "userEntity" , fetch = FetchType.LAZY , cascade = CascadeType.ALL)
    private List<OrderEntity> orders ;

    @ManyToMany(cascade = {CascadeType.MERGE,CascadeType.REMOVE} , fetch = FetchType.LAZY)
    @JoinTable(name = "user_role",
               joinColumns = @JoinColumn(name = "user_id" , referencedColumnName = "id"),
               inverseJoinColumns = @JoinColumn(name = "role_id" , referencedColumnName = "id"))
    private Set<UserRoleEntity> userRoles ;

    public List<OrderEntity> getOrders() {
        return orders;
    }

    public void setOrders(List<OrderEntity> orders) {
        this.orders = orders;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public UserStatus getStatus() {
        return status;
    }

    public void setStatus(UserStatus status) {
        this.status = status;
    }

    public Set<UserRoleEntity> getUserRoles() {
        return userRoles;
    }

    public void setUserRoles(Set<UserRoleEntity> userRoles) {
        this.userRoles = userRoles;
    }


}
