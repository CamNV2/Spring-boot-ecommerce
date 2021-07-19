package com.app.ecommerce.controller;

import com.app.ecommerce.entities.UserEntity;
import com.app.ecommerce.entities.UserRoleEntity;
import com.app.ecommerce.enums.UserStatus;
import com.app.ecommerce.services.UserRoleService;
import com.app.ecommerce.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
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
import javax.servlet.http.HttpServletRequest;
import java.util.HashSet;
import java.util.List;
import java.util.Set;


@Controller
@RequestMapping("/admin")
public class ManageUserController {
   @Autowired
    UserService userService ;

   @Autowired
    UserRoleService userRoleService ;

   @Autowired
    JavaMailSender mailSender ;

   @RequestMapping("/user-list")
    public String viewUserList (Model model,
                                @RequestParam(name = "type", required = false) String type,
                                @RequestParam(name = "message", required = false) String message,
                                @RequestParam(name = "page" , required = false , defaultValue = "0") int page ,
                                @RequestParam(name = "size" , required = false , defaultValue = "3") int size ,
                                @RequestParam(name = "start" ,required = false , defaultValue = "0") int start,
                                @RequestParam(name = "sortBy",required = false,defaultValue = "id") String sortBy){

       Pageable pageable = PageRequest.of(page, size, Sort.by(sortBy).descending()) ;
       int n = userService.getUsers().size() ;
       if(n % size != 0) {
           model.addAttribute("numberPages" , (n /size) + 1) ;
       }
       else {
           model.addAttribute("numberPages" , (n/size) ) ;
       }
       Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal() ;
       String username = principal.toString() ;
       if(principal instanceof UserDetails) {
           username = ((UserDetails) principal).getUsername();
           UserEntity userEntity = userService.findByEmail(username) ;
           model.addAttribute("admin" , userEntity) ;
       }
       model.addAttribute("users" , userService.getUserPages(pageable));
       model.addAttribute("roles" , userRoleService.getUserRole()) ;
       model.addAttribute("userStatus" , UserStatus.values()) ;
       model.addAttribute("page" , page) ;
       model.addAttribute("size" , size) ;
       model.addAttribute("start" , start) ;
       model.addAttribute("n" , n) ;
       model.addAttribute("type", type);
       model.addAttribute("message", message);
       return "admin/user_list" ;
   }

   @RequestMapping(value = "/user/update-user" , method = RequestMethod.GET)
    public String updateUser (@RequestParam("id") int id ,
                              @RequestParam("status") UserStatus status,
                              Model model ,
                              HttpServletRequest request) {
       String url = request.getHeader("referer") ;
       UserEntity user = userService.findUserById(id);
       String[] roles = request.getParameterValues("role");
       if(roles != null) {
           Set<UserRoleEntity> roleEntitySet = new HashSet<>() ;
           for(int i = 0 ; i < roles.length ; i++) {
               UserRoleEntity roleEntity = userRoleService.getUserRoleById(Integer.valueOf(roles[i]));
               roleEntitySet.add(roleEntity) ;
           }
           user.setUserRoles(roleEntitySet);
       }
       user.setStatus(status);
       userService.save(user);
       return "redirect:" + url ;
   }

   @RequestMapping("/user/add-user")
    public String viewFormAdd(Model model,
                              @RequestParam(name = "type", required = false) String type,
                              @RequestParam(name = "message", required = false) String message) {
       Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal() ;
       String username = principal.toString() ;
       if(principal instanceof UserDetails) {
           username = ((UserDetails) principal).getUsername();
           UserEntity userEntity = userService.findByEmail(username) ;
           model.addAttribute("admin" , userEntity) ;
       }
       model.addAttribute("user" , new UserEntity());
       model.addAttribute("roles" , userRoleService.getUserRole());
       model.addAttribute("type", type);
       model.addAttribute("message", message);
       return "admin/user" ;
   }
    @RequestMapping(value = "/user/add-user" , method = RequestMethod.POST)
    public String addUserResult(@ModelAttribute("user") UserEntity user,
                                Model model ,
                                HttpServletRequest request) throws MessagingException {
        List<UserEntity> userEntities = userService.getUsers() ;
        for(UserEntity userEntity : userEntities) {
            if(user.getEmail().equals(userEntity.getEmail())) {
                model.addAttribute("type" , "error");
                model.addAttribute("message" , "This email is already registered");
                return "redirect:/admin/user/add-user" ;
            }
        }
        String[] roleId = request.getParameterValues("role");
        if(roleId != null) {
            Set<UserRoleEntity> roles = new HashSet<>();
            for(int i = 0 ; i < roleId.length ; i++) {
                UserRoleEntity userRole = userRoleService.getUserRoleById(Integer.valueOf(roleId[i]));
                roles.add(userRole) ;
            }
            user.setUserRoles(roles);
        }
        userService.save(user);
//        Send Mail
        MimeMessage message = mailSender.createMimeMessage();
        boolean multipart = true ;
        MimeMessageHelper helper = new MimeMessageHelper(message , multipart , "utf-8") ;
        String htmlMsg = "" ;
        htmlMsg = "<h3>Registration Success!</h3>" + "<br><br>" + "<b>To Confirm your account and Change password , please here: </b>" +
                "<a href=\"http://localhost:8080/change-password/" + user.getId() +"\">"+ "Confirm and Changes Password" + "</a>" ;
        message.setContent(htmlMsg , "text/html");
        helper.setTo(user.getEmail());
        helper.setSubject("Register Success!");
        this.mailSender.send(message);
        model.addAttribute("type" , "success") ;
        model.addAttribute("message" , "Create User Success!") ;
        return "redirect:/admin/user-list" ;
    }
    @RequestMapping(value = "/search-user" , method = RequestMethod.POST)
    public String searchUser(Model model , @RequestParam("key") String key) {
       if(key.equals("")) {
           return "redirect:/admin/user-list" ;
       }
       Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal() ;
       String username = principal.toString() ;
       if(principal instanceof UserDetails) {
           username = ((UserDetails) principal).getUsername();
           UserEntity userEntity = userService.findByEmail(username);
           model.addAttribute("admin" , userEntity) ;
       }
       model.addAttribute("users" , userService.findUserByEmailAndName(key , key));
       model.addAttribute("roles" , userRoleService.getUserRole()) ;
       model.addAttribute("userStatus" , UserStatus.values()) ;
       model.addAttribute("key" , key) ;
       return "admin/user_list" ;
    }
}
