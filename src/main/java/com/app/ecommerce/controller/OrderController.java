package com.app.ecommerce.controller;

import com.app.ecommerce.entities.OrderEntity;
import com.app.ecommerce.enums.OrderStatus;
import com.app.ecommerce.services.OrderDetailService;
import com.app.ecommerce.services.OrderService;
import com.app.ecommerce.services.ProductService;
import com.app.ecommerce.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class OrderController {

    @Autowired
    OrderService orderService ;

    @Autowired
    OrderDetailService orderDetailService ;

    @Autowired
    UserService userService ;

    @Autowired
    ProductService productService ;

    @Autowired
    JavaMailSender mailSender ;
    Date fromDate1 = new Date();
    Date toDate1 = new Date();

    @RequestMapping(value = "/order-list" , method = RequestMethod.GET)
    public String viewListOrder(Model model ,
                                @RequestParam(name = "type" , required = false) String type,
                                @RequestParam(name = "message" , required = false) String message ,
                                @RequestParam(name= "page" , defaultValue = "0" , required = false) int page,
                                @RequestParam(name = "size" , defaultValue = "5" , required =false ) int size,
                                @RequestParam(name = "start", defaultValue = "0" , required = false) int start) {
        Pageable pageable = PageRequest.of(page , size);
        int n = orderService.getOrders().size() ;
        if(n % size == 0) {
            model.addAttribute("numberPages" , (n / size)) ;
        }else {
            model.addAttribute("numberPages" , (n/ size) + 1) ;
        }
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString() ;
        if(principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("admin" , userService.findByEmail(username));
        model.addAttribute("orders" , orderService.getOrderPageable(pageable)) ;
        model.addAttribute("orderStatus" , getOrderStatus()) ;
        model.addAttribute("page" , page);
        model.addAttribute("start" , start);
        model.addAttribute("n" , n);
        model.addAttribute("size" , size) ;
        model.addAttribute("type" , type) ;
        model.addAttribute("message" , message) ;
        return "admin/order_list" ;
    }

    @RequestMapping(value = "/order/change-status", method = RequestMethod.POST)
    public String changeStatusOrder(Model model ,
                                    @RequestParam("id") int id,
                                    @RequestParam("status") OrderStatus status ,
                                    HttpServletRequest request) throws MessagingException {
        OrderEntity orderEntity = orderService.findOrderById(id) ;
        orderEntity.setStatus(status);
        orderService.save(orderEntity);
        if(status == OrderStatus.CANCEL) {
            MimeMessage message = mailSender.createMimeMessage();
            boolean multipart = true ;
            MimeMessageHelper helper = new MimeMessageHelper(message , multipart ,"utf-8");
            String htmlMsg = "Hello, " + orderEntity.getFullName() + "<br> Sorry,Your order: " + "<a href =\"http://localhost:8080/search-order-by-id/" +orderEntity.getId() +"\">CP000"+orderEntity.getId()+ " </a>"
                    + "has been canceled! " +"<p>Sorry for this Problem!</p>";
            message.setContent(htmlMsg , "text/html");
            helper.setTo(orderEntity.getEmail());
            helper.setSubject("Order Canceled !");
            this.mailSender.send(message);
        }
        String url = request.getHeader("referer") ;
        model.addAttribute("type" , "success");
        model.addAttribute("message" , "Change Status Success !");
        return "redirect:" + url ;

    }

    @RequestMapping("/order/order-detail/{id}")
    public String orderDetail(Model model ,
                              @PathVariable("id") int id) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString() ;
        if(principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }

        model.addAttribute("admin" , userService.findByEmail(username)) ;
        model.addAttribute("orderStatus" , OrderStatus.values()) ;
        model.addAttribute("order" , orderService.findOrderById(id)) ;
        return "admin/order-detail" ;
    }

    @RequestMapping(value = "/order/search-order-date" , method = RequestMethod.POST)
    public String searchOrderByDate(Model model ,
                                    @RequestParam("fromDate")String fromDate,
                                    @RequestParam("toDate")String toDate ) throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd") ;
        fromDate1 = simpleDateFormat.parse(fromDate) ;
        toDate1 = simpleDateFormat.parse(toDate) ;
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal() ;
        String username= principal.toString() ;
        if(principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("admin" ,userService.findByEmail(username));
        model.addAttribute("orders" , orderService.findOrderByDate(fromDate1 ,toDate1));
        model.addAttribute("orderStatus" , getOrderStatus()) ;

        return "admin/order_list";
    }
    @RequestMapping(value = "/order/search-order" , method = RequestMethod.POST)
    public String searchOrder(Model model ,
                              @RequestParam("key") String key) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal() ;
        String username = principal.toString() ;
        if(principal instanceof UserDetails) {
            username = principal.toString() ;
        }
        model.addAttribute("admin" , userService.findByEmail(username));
        model.addAttribute("orders" , orderService.searchOrderByNameAndId( key , key));
        model.addAttribute("orderStatus" , getOrderStatus()) ;
        return "admin/order_list" ;
    }

    public List<String> getOrderStatus () {
        List<String> orderStatuses = new ArrayList<>() ;
        orderStatuses.add(OrderStatus.PENDING.toString());
        orderStatuses.add(OrderStatus.CONFIRM.toString()) ;
        orderStatuses.add(OrderStatus.COMPLETED.toString());
        orderStatuses.add(OrderStatus.SHIPPING.toString()) ;
        orderStatuses.add(OrderStatus.CANCEL.toString()) ;
        return orderStatuses ;
    }
}
