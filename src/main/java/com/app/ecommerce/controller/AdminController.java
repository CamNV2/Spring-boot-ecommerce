package com.app.ecommerce.controller;

import com.app.ecommerce.entities.UserEntity;
import com.app.ecommerce.services.CategoryService;
import com.app.ecommerce.services.ProductService;
import com.app.ecommerce.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    UserService userService ;

    @Autowired
    CategoryService categoryService ;

    @Autowired
    ProductService productService ;

    @RequestMapping(value = "/home" , method = RequestMethod.GET)
    public String HomeAdmin(Model model ,
                            @RequestParam(name = "type" , required = false) String type ,
                            @RequestParam(name = "message" , required = false) String message){
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal() ;
        String username = principal.toString() ;
        if(principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
            UserEntity userEntity = userService.findByEmail(username);
            model.addAttribute("admin" , userEntity) ;
        }
        int year = LocalDate.now().getYear();
        model.addAttribute("categories" ,categoryService.getCategories().size() );
        model.addAttribute("sizeProducts" , productService.getProducts().size()) ;
        model.addAttribute("sizeProductActive" , productService.getProductActives().size()) ;
        model.addAttribute("sizeUser" , userService.getUsers().size());
        model.addAttribute("year" , year) ;
        model.addAttribute("month" , LocalDate.now().getMonthValue()) ;
        model.addAttribute("type" , "success") ;
        model.addAttribute("message","Welcome to admin Dashboard");

        return "admin/home" ;
    }
}
