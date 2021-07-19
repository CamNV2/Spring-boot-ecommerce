package com.app.ecommerce.enums;

public enum  Role {
    ROLE_USER , ROLE_ADMIN ;
    public static Role[] getManagementRole() {
        return new Role[] {ROLE_ADMIN , ROLE_USER} ;
    }
}
