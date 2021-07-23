package com.app.ecommerce.controller;

import com.app.ecommerce.entities.*;
import com.app.ecommerce.enums.PaymentMethod;
import com.app.ecommerce.services.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;

@Controller
public class CheckoutController {
    private static final AtomicInteger count = new AtomicInteger();
    @Autowired
    UserService userService ;
    @Autowired
    ProductService productService ;
    @Autowired
    OrderDetailService orderDetailService ;
    @Autowired
    OrderService orderService ;
    @Autowired
    PaymentService paymentService ;
    @Autowired
    JavaMailSender mailSender ;

    @RequestMapping("/checkout")
    public String checkoutForm(Model model,
                               HttpSession session){
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString() ;
        if(principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername() ;
        }
        HashMap<Integer , OrderDetailEntity> cartItems = (HashMap<Integer, OrderDetailEntity>) session.getAttribute("cartItems");
        for (Map.Entry<Integer , OrderDetailEntity> entry : cartItems.entrySet()) {
            entry.getValue().setProducts(productService.findById(entry.getValue().getProducts().getId()));
        }
        if(cartItems == null) {
            cartItems = new HashMap<>();
        }
        if(cartItems != null) {
            session.setAttribute("totalPrice" ,orderDetailService.totalPrice(cartItems) );
        }
        UserEntity userEntity = userService.findByEmail(username);
        model.addAttribute("customer" , userEntity) ;
        session.setAttribute("sizeCart" , cartItems.size());
        session.setAttribute("cartItems" , cartItems);
        return "user/checkout" ;
    }
    @RequestMapping(value = "/checkout" ,method = RequestMethod.POST)
    public String checkout (Model model ,
                            HttpSession session,
                            @RequestParam("paymentMethod")PaymentMethod paymentMethod ,
                            @ModelAttribute("checkout")OrderEntity orderEntity) throws MessagingException {
        HashMap<Integer, OrderDetailEntity> orderItems = (HashMap<Integer, OrderDetailEntity>) session.getAttribute("cartItems");
        for(Map.Entry<Integer, OrderDetailEntity> entry : orderItems.entrySet()) {
            entry.getValue().setProducts(productService.findById(entry.getValue().getProducts().getId())) ;
        }
        HashMap<Integer , OrderEntity> orderHash = (HashMap<Integer, OrderEntity>) session.getAttribute("checkout");
        session.setAttribute("orderHash" , orderHash);
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString() ;
        if(principal instanceof UserDetails){
            username = ((UserDetails) principal).getUsername();
        }
        UserEntity userEntity = userService.findByEmail(username) ;
        model.addAttribute("customer" , userEntity);
        if (paymentMethod.equals(paymentMethod.CASH_ON_DELIVERY)) {
           String uuid = UUID.randomUUID().toString();
            orderEntity.setOrderNumber(uuid);
            orderEntity.setQuantity(getQuantityOrder(orderItems));
            orderEntity.setTotalPrice(orderDetailService.totalPrice(orderItems));
            orderEntity.setOrderDate(new Date());
            orderEntity.setUserEntity(userEntity);
            orderService.save(orderEntity);

            if(orderItems == null) {
                orderItems = new HashMap<>() ;
            }
            for(Map.Entry<Integer, OrderDetailEntity> entry : orderItems.entrySet()){
                OrderDetailEntity orderItem = new OrderDetailEntity();
                for(ProductEntity product : productService.getProducts()){
                    if(product.getId() == entry.getValue().getProducts().getId()){
                        product.setQuantity(product.getQuantity() - entry.getValue().getQuantity());
                    }
                    productService.save(product);
                }
                orderItem.setOrderEntity(orderEntity);
                orderItem.setProducts(productService.findById(entry.getValue().getProducts().getId()));
                orderItem.setPrice(entry.getValue().getProducts().getPrice());
                orderItem.setQuantity(entry.getValue().getQuantity());
                orderItem.setDiscount(entry.getValue().getProducts().getSales().getSalePercent());
                orderDetailService.save(orderItem);
            }
            List<PaymentEntity> payments = new ArrayList<>();
            PaymentEntity payment = new PaymentEntity();
            payment.setMethod(paymentMethod);
            payment.setOrders(orderEntity);
            payment.setPaymentDate(new Date());
            payments.add(payment);
            paymentService.save(payment);

            //send main when checkout success
            MimeMessage mimeMessage = mailSender.createMimeMessage();
            boolean multipart = true ;
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage , multipart , "utf-8") ;
            String htmlMsg = "" ;
            htmlMsg = "<div style:\"font-size: 16px;\">" +
                    "<h3>Order Success!</h3>" + "<p> Hello, " + orderEntity.getUserEntity().getFullName()+ "</p>" + "<br>" + "You successfully ordered your order with your order code: <b>CPORDER000" + orderEntity.getId() + "</b><br><br>"
                    + "Click to view order: "  + "<a style=\"color:#ee4d2d ; font-weight: 600 ;  text-decoration: none;\" " +
                    "href=\"http://localhost:8080/search-order-by-id/" + orderEntity.getId() + "\">" + "CPORDER00" + orderEntity.getId() +"</a>" + "<br><br>"
                    + "Date order: " + orderEntity.getOrderDate() + "<br><br>"
                    + "Payment Status: " + showPaymentMethod(paymentMethod) + "<br><br>"
                    + "Total price for your order: $" + orderDetailService.totalPrice(orderItems) + "<br><br>" + "<table style=\"font-family: arial, sans-serif;font-size: 16px; width: 100%;\n"
                    + "border-collapse: collapse; \"><tr style=\"border: 1px solid #dddddd; text-align: left; padding: 8px; \">"
                    + "<th style=\" text-align: center; padding: 8px; \">Name</th>"
                    + "<th style=\" text-align: center; padding: 8px; \">Price</th>"
                    + "<th style=\" text-align: center; padding: 8px; \">Discount</th>"
                    + "<th style=\" text-align: center; padding: 8px; \">Quantity</th>"
                    + "<th style=\" text-align: center; padding: 8px; \">Sub Total</th></tr>";
            for (Map.Entry<Integer , OrderDetailEntity> entry : orderItems.entrySet()){
                String temp = "<tr style=\"border: 1px solid #dddddd;height:40px;\">"
                        + "<td style=\"border-right: 1px solid #dddddd;padding : 0 8px;\">" + entry.getValue().getProducts().getProductName() + "</td>"
                        + "<td style=\"text-align:center ;border-right: 1px solid #dddddd;padding : 0 8px;\">$" + entry.getValue().getProducts().getPrice() + "</td>"
                        + "<td style=\"text-align:center ;border-right: 1px solid #dddddd;padding : 0 8px;\">" + entry.getValue().getProducts().getSales().getSalePercent()+ "%</td>"
                        + "<td style=\"text-align:center ;border-right: 1px solid #dddddd;padding : 0 8px;\">" + entry.getValue().getQuantity() + "</td>"
                        + "<td style=\"text-align:center ;\"> $" + ((entry.getValue().getProducts().getPrice()  -  entry.getValue().getProducts().getPrice() * entry.getValue().getProducts().getSales().getSalePercent()/100)) * entry.getValue().getQuantity() + "</td>"
                        + "</tr>";
              htmlMsg =  htmlMsg.concat(temp) ;
            }
            String temp1 = "</table></div> ";
            htmlMsg.concat(temp1);
            mimeMessage.setContent(htmlMsg , "text/html");
            helper.setTo(orderEntity.getUserEntity().getEmail());
            helper.setSubject("Order Success!");
            this.mailSender.send(mimeMessage);

            //reset session orderItem
            orderItems = new HashMap<>();

            session.setAttribute("cartItems" , orderItems);
            session.setAttribute("sizeCart" , orderItems.size());
            System.out.println(orderItems.size());
            session.setAttribute("orderEntities" , orderEntity);
            model.addAttribute("orderEntity" , orderEntity) ;
            model.addAttribute("message" , "Success!");
            model.addAttribute("type" , "success") ;
            return "user/buy-success" ;
        }
        else {
            if (principal instanceof UserDetails) {
                username = ((UserDetails) principal).getUsername();
            }
            model.addAttribute("userEntity", userService.findByEmail(username));
            HashMap<Integer, OrderDetailEntity> cartItems = (HashMap<Integer, OrderDetailEntity>) session.getAttribute("cartItems");
            OrderEntity orderSession = (OrderEntity) session.getAttribute("orderEntityss");
            session.setAttribute("orderEntityss", orderSession);
            session.setAttribute("cartItems", cartItems);
            session.setAttribute("orderEntities", orderEntity);
            return "user/payment" ;
        }
    }

    public int getQuantityOrder(HashMap<Integer ,OrderDetailEntity> orderItems) {
        int quantity = 0 ;
        for (Map.Entry<Integer, OrderDetailEntity> entry : orderItems.entrySet()){
            quantity += entry.getValue().getQuantity();
        }
        return quantity ;
    }
    public String showPaymentMethod(PaymentMethod paymentMethod) {
        if (paymentMethod == PaymentMethod.CASH_ON_DELIVERY) {
            return "Unpaid";
        } else {
            return "Paid";
        }
    }
}
