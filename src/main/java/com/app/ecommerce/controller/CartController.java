package com.app.ecommerce.controller;

import com.app.ecommerce.entities.OrderDetailEntity;
import com.app.ecommerce.entities.ProductEntity;
import com.app.ecommerce.entities.UserEntity;
import com.app.ecommerce.services.OrderDetailService;
import com.app.ecommerce.services.ProductService;
import com.app.ecommerce.services.UserService;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
public class CartController {

    @Autowired
    ProductService productService ;

    @Autowired
    UserService userService ;
    @Autowired
    OrderDetailService orderDetailService ;

    @RequestMapping("/cart/{id}")
    public String addCart(Model model,
                          HttpSession session ,
                          HttpServletRequest request ,
                          @PathVariable("id") int id ) {

        HashMap<Integer , OrderDetailEntity> cartItems = (HashMap<Integer, OrderDetailEntity>) session.getAttribute("cartItems" );
        String url = request.getHeader("referer");
        if(cartItems == null) {
            cartItems = new HashMap<>();
        }
        ProductEntity productEntity = productService.findById(id) ;
        OrderDetailEntity orderDetail = new OrderDetailEntity() ;

        if(productEntity.getId() != 0) {
           if(cartItems.containsKey(id)) {
                System.out.println("product was in cart");
                orderDetail = cartItems.get(id) ;
                orderDetail.setQuantity(orderDetail.getQuantity() + 1);
                orderDetail.setPrice(productEntity.getPrice());
            }else {
                System.out.println("product in new cart");
                orderDetail.setProducts(productEntity);
                orderDetail.setQuantity(1);
                orderDetail.setPrice(productEntity.getPrice());
            }
            cartItems.put(id , orderDetail) ;
        }
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString() ;
        if(principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername() ;
        }
        UserEntity userEntity = userService.findByEmail(username) ;
        model.addAttribute("customer" , userEntity) ;
        model.addAttribute("cartItem" , orderDetail);
        session.setAttribute("cartItems" , cartItems);
        session.setAttribute("date" , new Date());
        session.setAttribute("sizeCart" , cartItems.size());
        session.setAttribute("totalPrice" , orderDetailService.totalPrice(cartItems));
        return "redirect:" + url ;
    }

    @RequestMapping("/view-cart")
    public String viewCart(Model model,
                           HttpSession session
                           ){
        Object principal  = SecurityContextHolder.getContext().getAuthentication().getPrincipal() ;
        String username = principal.toString() ;
        if(principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        UserEntity userEntity = userService.findByEmail(username) ;
        model.addAttribute("customer" , userEntity) ;

        HashMap<Integer , OrderDetailEntity> cartItems = (HashMap<Integer, OrderDetailEntity>) session.getAttribute("cartItems");

            for(Map.Entry<Integer , OrderDetailEntity> entry : cartItems.entrySet()){
                System.out.println("This is product cart");
                entry.getValue().setProducts(productService.findById(entry.getValue().getProducts().getId()));
                System.out.println(entry.getKey() + " -> " + entry.getValue().getProducts().getProductName());
            }

        if(cartItems != null){
            session.setAttribute("totalPrice" , orderDetailService.totalPrice(cartItems));
        }
        session.setAttribute("cartItems" , cartItems);
        session.setAttribute("sizeCart" , cartItems.size());
        return "user/cart" ;
    }

    @RequestMapping("/cart/delete/{id}")
    public String deleteCartId(HttpSession session,
                               HttpServletRequest request,
                               @PathVariable("id") int id) {
        String url = request.getHeader("referer") ;
        HashMap<Integer ,OrderDetailEntity> cartItems = (HashMap<Integer, OrderDetailEntity>) session.getAttribute("cartItems");
        System.out.println(cartItems);
        if(cartItems != null) {
            if(cartItems.containsKey(id)){
                cartItems.remove(id) ;
            }
        }
        session.setAttribute("sizeCart" , cartItems.size());
        return "redirect:" + url ;
    }

    @RequestMapping("/cart/clear")
    public String clearCart(HttpSession session ){
        HashMap<Integer , OrderDetailEntity> cartItems = (HashMap<Integer, OrderDetailEntity>) session.getAttribute("cartItems");
        if(cartItems.size() > 0) {
            cartItems.clear();
        }
        return "redirect:/view-cart" ;
    }

    @RequestMapping("/cart/update-plus/{id}")
    public String updateCartPlus(HttpServletRequest request,
                             HttpSession session,
                             @PathVariable("id") int id) {
        HashMap<Integer,OrderDetailEntity> cartItems = (HashMap<Integer, OrderDetailEntity>) session.getAttribute("cartItems");
        ProductEntity productEntity = productService.findById(id) ;
        OrderDetailEntity orderDetail = new OrderDetailEntity() ;

        if(cartItems != null ){
            if(cartItems.containsKey(id)){
                orderDetail = cartItems.get(id);
                orderDetail.setQuantity(orderDetail.getQuantity() + 1);
                orderDetail.setPrice(productEntity.getPrice());
            }
        }
        return "redirect:/view-cart" ;
    }
    @RequestMapping("/cart/update-minus/{id}")
    public String updateCartMinus(HttpServletRequest request,
                             HttpSession session,
                             @PathVariable("id") int id) {
        HashMap<Integer,OrderDetailEntity> cartItems = (HashMap<Integer, OrderDetailEntity>) session.getAttribute("cartItems");
        ProductEntity productEntity = productService.findById(id) ;
        OrderDetailEntity orderDetail = new OrderDetailEntity() ;

        if(cartItems != null ){
            if(cartItems.containsKey(id) ){
                orderDetail = cartItems.get(id);
                orderDetail.setQuantity(orderDetail.getQuantity() - 1);
                orderDetail.setPrice(productEntity.getPrice());
            }
            if(orderDetail.getQuantity() < 1 ) {
                orderDetail.setQuantity(orderDetail.getQuantity() * 0 + 1);
            }
        }
        return "redirect:/view-cart" ;
    }
}
