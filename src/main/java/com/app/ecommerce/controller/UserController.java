package com.app.ecommerce.controller;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/user")
public class UserController {

    @RequestMapping(value = "/home" , method = RequestMethod.GET)
    public String userHome(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username  = principal.toString();
        if(principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername() ;
        }
        model.addAttribute("message" , username) ;
        return "redirect:/home" ;
    }
}
