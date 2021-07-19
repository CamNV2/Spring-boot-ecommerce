package com.app.ecommerce.controller;

import com.app.ecommerce.entities.ProductEntity;
import com.app.ecommerce.entities.UserEntity;
import com.app.ecommerce.enums.ProductStatus;
import com.app.ecommerce.services.CategoryService;
import com.app.ecommerce.services.ProductService;
import com.app.ecommerce.services.SaleService;
import com.app.ecommerce.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

@Controller
@RequestMapping("/admin")
public class ProductController {

    @Autowired
    ProductService productService ;

    @Autowired
    CategoryService categoryService ;


    @Autowired
    UserService userService ;

    @Autowired
    SaleService saleService ;

    @Autowired
    ServletContext context ;

    @RequestMapping(value = "/product-list" , method = RequestMethod.GET)
    public String viewProducts(Model model,
                               @RequestParam(name = "type" , required = false) String type,
                               @RequestParam(name = "message" , required = false) String message,
                               @RequestParam(name = "page" , required = false, defaultValue = "0") int page,
                               @RequestParam(name = "size" , required = false , defaultValue = "5") int size,
                               @RequestParam(name = "start" , required = false ,defaultValue = "0") int start,
                               @RequestParam(name = "sortBy" , required = false , defaultValue = "id") String sortBy){

        Pageable pageable =  PageRequest.of(page, size, Sort.by(sortBy).descending());
        int n = productService.getProductActives().size() ;
//      Setting number pages
        if(n % size != 0) {
            model.addAttribute("numberPages" , (n/size) + 1) ;
        }
        else {
            model.addAttribute("numberPages" , (n/size)) ;
        }

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal() ;
        String username = principal.toString() ;
        if(principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
            UserEntity userEntity = userService.findByEmail(username);
            model.addAttribute("admin" , userEntity) ;
        }
        model.addAttribute("products" , productService.getProductPages(pageable)) ;
        model.addAttribute("categories" , categoryService.getCategories()) ;
        model.addAttribute("page" , page) ;
        model.addAttribute("size" , size) ;
        model.addAttribute("start" , start) ;
        model.addAttribute("n" , n) ;
        model.addAttribute("type" , type) ;
        model.addAttribute("message" , message) ;
         return "admin/product_list" ;
    }

    @RequestMapping("/product/change-status/{id}")
    public String changeStatus(Model model, HttpServletRequest request , @PathVariable("id") int id) {
        String url = request.getHeader("referer");
        ProductEntity productEntity = productService.findById(id) ;
        if (productEntity.getStatus() == ProductStatus.ACTIVE) {
            productEntity.setStatus(ProductStatus.DISABLED);
        }
        else if(productEntity.getStatus() == ProductStatus.DISABLED) {
            productEntity.setStatus(ProductStatus.ACTIVE);
        }
        productService.save(productEntity);
        System.out.println(url);
        return "redirect:" + url ;
    }

    @RequestMapping(value = "/search-cate/{id}")
    public String searchCate(Model model , @PathVariable("id") int id){
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal() ;
        String username = principal.toString();
        if(principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
            UserEntity userEntity = userService.findByEmail(username) ;
            model.addAttribute("admin" , userEntity);
        }
        model.addAttribute("products" , productService.searchProductByCate(id)) ;
        model.addAttribute("categories" , categoryService.getCategories()) ;

        return "admin/product_list" ;
    }

    @RequestMapping(value = "/search" , method = RequestMethod.POST)
    public String searchProduct (Model model , @ModelAttribute("key") String key) {
        Object principal = SecurityContextHolder.getContext().getAuthentication() ;
        String username = principal.toString();
        if(principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
            UserEntity userEntity = userService.findByEmail(username) ;
            model.addAttribute("admin" , userEntity);
        }
        model.addAttribute("products" , productService.searchProduct(key)) ;
        model.addAttribute("categories", categoryService.getCategories());
        model.addAttribute("key" , key);
        return "admin/product_list" ;
    }
    @RequestMapping("/add-product")
    public String showFormProduct(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal() ;
        String username = principal.toString() ;
        if(principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername() ;
            UserEntity userEntity = userService.findByEmail(username) ;
            model.addAttribute("admin" , userEntity) ;
        }
        model.addAttribute("product" , new ProductEntity());
        model.addAttribute("categories" , categoryService.getCategories());
        model.addAttribute("sales" , saleService.getAllSales() ) ;
        model.addAttribute("action" , "add") ;
        return "admin/products" ;
    }
    @RequestMapping("/update/{id}")
    public String showFormUpdate(Model model , @PathVariable("id") int id) {
        ProductEntity productEntity = productService.findById(id);
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal() ;
        String username = principal.toString() ;
        if(principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
            UserEntity userEntity = userService.findByEmail(username) ;
            model.addAttribute("admin" , userEntity) ;
        }
            model.addAttribute("product" , productEntity) ;
            model.addAttribute("sales" , saleService.getAllSales());
            model.addAttribute("categories" , categoryService.getCategories());
            model.addAttribute("action" , "update") ;
            return "admin/products" ;
    }

    @RequestMapping(value = "/result" , method = RequestMethod.POST)
    public String product (Model model ,
                           @ModelAttribute("product") ProductEntity product,
                           @RequestParam("file")MultipartFile file
                          ) throws IOException {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal() ;
        String username = principal.toString() ;
        if(principal instanceof  UserDetails) {
            username = ((UserDetails) principal).getUsername();
            UserEntity userEntity = userService.findByEmail(username) ;
            model.addAttribute("admin" , userEntity) ;
        }
        if(file != null  && file.getSize() > 1) {
            String photoPath = context.getRealPath("\\resources\\images\\product\\" + file.getOriginalFilename());
            file.transferTo(new File(photoPath));
            product.setImage(file.getOriginalFilename());
        }

        productService.save(product);

        return  "redirect:/admin/product-list" ;
    }

}
