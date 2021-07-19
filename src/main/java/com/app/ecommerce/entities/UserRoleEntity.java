package com.app.ecommerce.entities;

import com.app.ecommerce.enums.Role;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

@Entity
@Table(name = "role")
public class UserRoleEntity implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id ;

    @Enumerated(EnumType.STRING)
    private Role role = Role.ROLE_USER ;

    @ManyToMany(mappedBy = "userRoles")
    private Set<UserEntity> users ;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Set<UserEntity> getUserEntitySet() {
        return users;
    }

    public void setUserEntitySet(Set<UserEntity> userEntitySet) {
        this.users = userEntitySet;
    }
}
