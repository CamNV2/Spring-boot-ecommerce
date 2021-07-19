package com.app.ecommerce.controller;

import com.app.ecommerce.config.SecurityUtils;
import com.app.ecommerce.entities.UserEntity;
import com.app.ecommerce.services.CategoryService;
import com.app.ecommerce.services.ProductService;
import com.app.ecommerce.services.UserRoleService;
import com.app.ecommerce.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class HomeController {

    @Autowired
    public UserService userService;

    @Autowired
    public UserRoleService userRoleService ;

    @Autowired
    public ProductService productService ;

    @Autowired
    public CategoryService categoryService ;

    @RequestMapping(value = {"/" , "/home"} , method = RequestMethod.GET)
    public String home (Model model,
                        @RequestParam(value = "page" , required = false , defaultValue = "0")int page,
                        @RequestParam(name = "size" , required = false , defaultValue = "5") int size,
                        @RequestParam(value = "pageCate" , required = false , defaultValue = "0")int pageCate,
                        @RequestParam(name = "sizeCate" , required = false , defaultValue = "12") int sizeCate){
        List<String> roles = SecurityUtils.getRolesOfUser();
        if(!CollectionUtils.isEmpty(roles) && (roles.contains("ROLE_ADMIN"))){
            return "redirect:/admin/home";
        }
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString() ;
        if(principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
            UserEntity userEntity = userService.findByEmail(username) ;
            model.addAttribute("customer" , userEntity) ;
        }
        Pageable pageable = PageRequest.of(page , size);
        Pageable pageableCate = PageRequest.of(pageCate, sizeCate) ;
        model.addAttribute("products" , productService.getProductActiveSort(pageable));
        model.addAttribute("productSale" , productService.getProductSale(pageable));
        model.addAttribute("productHot" , productService.getProductSortAsc(pageable));
        model.addAttribute("categories" , categoryService.getCategoryPage(pageableCate)) ;

        return "index" ;
    }
    @GetMapping("/login")
    public String loginPages() {
        return "login" ;
    }

    @RequestMapping("/product-detail/{id}/{idCate}")
    public String viewProductDetail(Model model ,
                                    @PathVariable("id") int id,
                                    @PathVariable("idCate") int idCate ,
                                    @RequestParam(name = "sizes" , defaultValue = "5" , required = false) int sizes,
                                    @RequestParam(name = "page" ,defaultValue = "0" , required = false) int page,
                                    @RequestParam(name = "sortBy" , defaultValue = "id" , required = false)String sortBy ){
        Pageable pageable = PageRequest.of(page , sizes , Sort.by(sortBy).descending()) ;
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal() ;
        String username = principal.toString() ;
        if(principal instanceof  UserDetails) {
            username = ((UserDetails) principal).getUsername();
            UserEntity userEntity = userService.findByEmail(username) ;
            model.addAttribute("customer" , userEntity);
        }
        model.addAttribute("product" , productService.getProductById(id));
        model.addAttribute("productCate" , productService.getProductByCategoryPageable(idCate , pageable));
        return "user/product-detail" ;
    }
    @RequestMapping("/view-product")
    public String viewProducts(@RequestParam(name = "page" , required = false , defaultValue = "0")int page ,
                               @RequestParam(name = "start" , required = false ,defaultValue = "0") int start,
                               @RequestParam(name = "size" , required = false , defaultValue = "12") int size,
                               Model model){
        Pageable pageable = PageRequest.of(page , size);
        int n = productService.getProductActives().size();
        if(n % size == 0) {
            model.addAttribute("numberPage" , (n /size)) ;
        }
        else {
            model.addAttribute("numberPage" , (n/size)+ 1) ;
        }
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString() ;
        if(principal instanceof UserDetails){
            username = ((UserDetails) principal).getUsername();
            UserEntity userEntity = userService.findByEmail(username) ;
            model.addAttribute("customer" , userEntity) ;
        }
        model.addAttribute("products" , productService.getProductActiveSort(pageable));
        model.addAttribute("categories" , categoryService.getCategories()) ;
        model.addAttribute("countProduct" , productService.countProductByCategory());
        model.addAttribute("page" , page) ;
        model.addAttribute("start" , start);
        model.addAttribute("size" , size) ;
        return "user/view-product";
    }

    @RequestMapping("/view-product/{id}")
    public String findProductByCate (Model model ,
                                     @RequestParam(name = "page" ,required = false , defaultValue = "0") int page,
                                     @RequestParam(name = "size" , required = false , defaultValue = "12") int size,
                                     @RequestParam(name = "start", required = false, defaultValue = "0") Integer start,
                                     @PathVariable("id") int id ) {
        Pageable pageable = PageRequest.of(page , size) ;
        int n = productService.getProductByCateId(id).size() ;
        if( n % size == 0) {
            model.addAttribute("numberPage" , (n/size)) ;
        } else {
            model.addAttribute("numberPage" , (n/size) + 1) ;
        }
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal() ;
        String username = principal.toString() ;
        if(principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername() ;
            UserEntity userEntity = userService.findByEmail(username) ;
            model.addAttribute("customer" , userEntity) ;
        }
        model.addAttribute("idCate" , id) ;
        model.addAttribute("products" , productService.searchProductByCate(id)) ;
        model.addAttribute("categories" , categoryService.getCategories()) ;
        model.addAttribute("countProduct" , productService.countProductByCategory());
        model.addAttribute("page" , page) ;
        model.addAttribute("start" , start);
        model.addAttribute("size" , size) ;
        return "user/view-product";
    }
    @RequestMapping("/price-sort-asc")
    public String sortPriceAsc(Model model,
                               @RequestParam(name = "page" , defaultValue = "0" , required = false) int page,
                               @RequestParam(name = "size" , defaultValue = "12" , required = false) int size ,
                               @RequestParam(name = "start" ,defaultValue = "0" , required = false) int start) {
        int n = productService.getProductActives().size() ;
        if(n % size == 0 ){
            model.addAttribute("numberPage" , (n / size)) ;
        }else {
            model.addAttribute("numberPage" , (n / size) + 1) ;
        }
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString() ;
        if(principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
            UserEntity userEntity = userService.findByEmail(username) ;
            model.addAttribute("customer" , userEntity);
        }
        Pageable pageable = PageRequest.of(page , size) ;
        model.addAttribute("products" , productService.getProductByPriceASC(pageable));
        model.addAttribute("categories" , categoryService.getCategories()) ;
        model.addAttribute("countProduct" , productService.countProductByCategory());
        model.addAttribute("page", page) ;
        model.addAttribute("size" , size) ;
        model.addAttribute("start" , start) ;
        model.addAttribute("status" , "sort-asc") ;
        return "user/view-product" ;
    }
    @RequestMapping("/price-sort-desc")
    public String sortPriceDesc(Model model,
                               @RequestParam(name = "page" , defaultValue = "0" , required = false) int page,
                               @RequestParam(name = "size" , defaultValue = "12" , required = false) int size ,
                               @RequestParam(name = "start" ,defaultValue = "0" , required = false) int start) {
        int n = productService.getProductActives().size() ;
        if(n % size == 0 ){
            model.addAttribute("numberPage" , (n / size)) ;
        }else {
            model.addAttribute("numberPage" , (n / size) + 1) ;
        }
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString() ;
        if(principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
            UserEntity userEntity = userService.findByEmail(username) ;
            model.addAttribute("customer" , userEntity);
        }
        Pageable pageable = PageRequest.of(page , size) ;
        model.addAttribute("products" , productService.getProductPriceDESC(pageable));
        model.addAttribute("categories" , categoryService.getCategories()) ;
        model.addAttribute("countProduct" , productService.countProductByCategory());
        model.addAttribute("page", page) ;
        model.addAttribute("size" , size) ;
        model.addAttribute("start" , start) ;
        model.addAttribute("status" , "sort-desc") ;
        return "user/view-product" ;
    }
}
