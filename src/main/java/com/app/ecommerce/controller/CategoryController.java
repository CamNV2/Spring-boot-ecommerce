package com.app.ecommerce.controller;

import com.app.ecommerce.entities.CategoryEntity;
import com.app.ecommerce.enums.CategoryStatus;
import com.app.ecommerce.services.CategoryService;
import com.app.ecommerce.services.ProductService;
import com.app.ecommerce.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class CategoryController {

    @Autowired
    ProductService productService ;

    @Autowired
    CategoryService categoryService ;

    @Autowired
    UserService userService ;

    @RequestMapping("/category-list")
    public String viewListCategory(Model model ,
                                   @RequestParam(value = "page" , required = false , defaultValue = "0") int page,
                                   @RequestParam(value = "size", required = false , defaultValue = "6") int size,
                                   @RequestParam(value = "start",required = false , defaultValue = "0") int start) {
        Pageable pageable = PageRequest.of(page, size);
        int n = categoryService.getCategories().size() ;
        if( n % size == 0) {
            model.addAttribute("numberPages" , (n /size));
        }else  {
            model.addAttribute("numberPages" , (n/size) + 1);
        }
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal() ;
        String username = principal.toString() ;
        if(principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername() ;
        }
        model.addAttribute("admin" , userService.findByEmail(username)) ;
        model.addAttribute("categories" , categoryService.getCategoryList(pageable));
        model.addAttribute("countProduct" , productService.countProductByCategoryDESC());
        model.addAttribute("status" , CategoryStatus.values()) ;
        model.addAttribute("start", start) ;
        model.addAttribute("page" ,page) ;
        model.addAttribute("size" , size);

        return "admin/category-list";
    }

    @RequestMapping("/category/add-category")
    public String viewForm(Model model ) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal() ;
        String username = principal.toString() ;
        if(principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername() ;
        }
        model.addAttribute("admin" , userService.findByEmail(username)) ;
        model.addAttribute("category" , new CategoryEntity());
        model.addAttribute("action" , "add") ;
        return "admin/category" ;
    }
    @RequestMapping(value = "/category/result" , method = RequestMethod.POST)
    public String saveCategory(Model model ,
                                @ModelAttribute("category") CategoryEntity category) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal() ;
        String username = principal.toString() ;
        if(principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername() ;
        }
        List<CategoryEntity> categories = categoryService.getCategories();
        for(CategoryEntity c : categories) {
            if(category.getCategoryName().equals(c.getCategoryName())){
                model.addAttribute("admin" , userService.findByEmail(username)) ;
                model.addAttribute("type" , "fail");
                model.addAttribute("message" , "Category has been exist! ");
                model.addAttribute("action" , "add") ;
                return "admin/category" ;
            }
        }
        model.addAttribute("admin" , userService.findByEmail(username)) ;
        categoryService.save(category);
        return "redirect:/admin/category-list" ;
    }
    @RequestMapping("/category/update-category/{id}")
    public String updateForm(Model model ,
                             @PathVariable("id") int id) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal() ;
        String username = principal.toString() ;
        if(principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername() ;
        }
        CategoryEntity categoryEntity = categoryService.getCategoryById(id);
        model.addAttribute("admin" , userService.findByEmail(username)) ;
        model.addAttribute("category" , categoryEntity) ;
        model.addAttribute("action" , "update") ;
        return "admin/category" ;
    }
    @RequestMapping("/category/change-status/{id}")
    public String changeStatus(Model model ,
                               HttpServletRequest request,
                               @PathVariable("id") int id) {
        String url = request.getHeader("referer") ;
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal() ;
        String username = principal.toString() ;
        if(principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername() ;
        }
        model.addAttribute("admin" , userService.findByEmail(username)) ;
        CategoryEntity categoryEntity = categoryService.getCategoryById(id);
        if (categoryEntity.getStatus() == CategoryStatus.ACTIVE) {
            categoryEntity.setStatus(CategoryStatus.DISABLED);
        }else{
            categoryEntity.setStatus(CategoryStatus.ACTIVE);
        }
        categoryService.save(categoryEntity);
        return "redirect:" + url ;
    }
}
