package com.app.ecommerce.controller;

import com.app.ecommerce.entities.UserEntity;
import com.app.ecommerce.entities.UserRoleEntity;
import com.app.ecommerce.enums.UserStatus;
import com.app.ecommerce.services.UserRoleService;
import com.app.ecommerce.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import static com.app.ecommerce.config.SecurityUtils.encrytePassword;

@Controller
public class AccountController {

    @Autowired
    ServletContext context;

    @Autowired
    public UserService userService;

    @Autowired
    public UserRoleService userRoleService ;
    @Autowired
    public JavaMailSender emailSender;

    @GetMapping("/signup")
    public String signUp(Model model) {
        model.addAttribute("roles" , userRoleService.getUserRole());
        return "user/signup" ;
    }
    @RequestMapping(value = "/signup", method = RequestMethod.POST)
    public String signUpAccount(Model model,
                                @ModelAttribute("signup") UserEntity userEntity,
                                @RequestParam("brand_Logo") MultipartFile photo,
                                HttpServletRequest request,
                                @RequestParam(value = "type", required = false) String type,
                                @RequestParam(value = "message", required = false) String message) throws MessagingException, IOException {

        List<UserEntity> users = userService.getUsers();
        for (UserEntity user : users) {
            if (userEntity.getEmail().equals(user.getEmail())) {
                model.addAttribute("type", "fail");
                model.addAttribute("message", "This email is already registered!");
                return "user/signup";
            }
        }
        userEntity.setPassword(encrytePassword(userEntity.getPassword()));
        String[] roleIds = request.getParameterValues("role");
        if (roleIds != null) {
            Set<UserRoleEntity> roles = new HashSet<>();
            for (int i = 0; i < roleIds.length; i++) {
                UserRoleEntity userRole = userRoleService.getUserRoleById(Integer.valueOf(roleIds[i]));
                roles.add(userRole);
            }
            userEntity.setUserRoles(roles);
        }
            String photoPath = context.getRealPath("\\resources\\images\\user\\" + photo.getOriginalFilename());
            photo.transferTo(new File(photoPath));
            userEntity.setBrandLogo(photo.getOriginalFilename());
        userService.save(userEntity);
//       send mail
        MimeMessage messagee = emailSender.createMimeMessage();
        boolean multipart = true;
        MimeMessageHelper helper = new MimeMessageHelper(messagee, multipart, "utf-8");
        String htmlMsg = "";
        htmlMsg = "<h3>Registration Success</h3>" + "<br><br>" + "Complete Registration! " + "<br><br>" + "To confirm your account, please click here : "
                + "<a href=\"http://localhost:8080/active/" + userEntity.getId() + "\">" + "active" + "</a>";
        messagee.setContent(htmlMsg, "text/html");
        helper.setTo(userEntity.getEmail());
        helper.setSubject("Registration Success!!!");
        this.emailSender.send(messagee);

        model.addAttribute("type", type);
        model.addAttribute("message", message);
        model.addAttribute("type", "success");
        model.addAttribute("message", "Please Check Mail to login");

        return "login";
    }
    @RequestMapping(value = "/active/{id}" , method = RequestMethod.GET)
    public String updateStatus(@PathVariable(value = "id") int id) {
        UserEntity userEntity = userService.findUserById(id);
        userEntity.setStatus(UserStatus.ACTIVE);
        userService.save(userEntity);
        return "redirect:/login?type=success&message=Registration Success!: " + id;
    }

    @RequestMapping(value = "/changeAccount/{email}")
    public String ViewInfoAccount(Model model ,
                                  HttpServletRequest request,
                                  @PathVariable(value = "email") String email){
        UserEntity userEntity = userService.findByEmail(email);
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("username", username);
        if (userEntity.getId() > 0) {
            model.addAttribute("userEntity", userEntity);
            model.addAttribute("roles", userRoleService.getUserRole());
            model.addAttribute("action", "update");
            return "user/account";
        } else {
            model.addAttribute("type", "fail");
            model.addAttribute("message", "email already exist.!!");

            return "redirect:/user/account?type=error&message=Not found ";
        }
    }
    @RequestMapping(value = "/result" , method = RequestMethod.POST)
    public String home(@ModelAttribute("userEntity") UserEntity userEntity,
                       @RequestParam("file") MultipartFile photo,
                       HttpServletRequest request
                       ) throws IOException {
        String[] roleIds = request.getParameterValues("role");
        if (roleIds != null) {
            Set<UserRoleEntity> roles = new HashSet<>();
            for (int i = 0; i < roleIds.length; i++) {
                UserRoleEntity userRole = userRoleService.getUserRoleById(Integer.valueOf(roleIds[i]));
                roles.add(userRole);
            }
            userEntity.setUserRoles(roles);
        }
        if(photo != null && photo.getSize() > 1) {
            String photoPath = context.getRealPath("\\resources\\images\\user\\" + photo.getOriginalFilename());
            photo.transferTo(new File(photoPath));
            userEntity.setBrandLogo(photo.getOriginalFilename());
        }

        userService.save(userEntity);
        return "redirect:/changeAccount/" + userEntity.getEmail();
    }

    @RequestMapping(value = "/change-password/{id}" , method = RequestMethod.GET)
    public String viewFormChange(Model model , @PathVariable("id") int id) {
        UserEntity userEntity = userService.findUserById(id);
        model.addAttribute("user" , userEntity) ;
        model.addAttribute("roles" , userRoleService.getUserRole()) ;
        return "user/change-password" ;
    }

    @RequestMapping(value = "/change-password" , method = RequestMethod.POST)
    public String changePassword (Model model ,
                                  HttpServletRequest request ,
                                  @ModelAttribute("user") UserEntity user ) {
        String[] roleId = request.getParameterValues("role") ;
        if(roleId != null) {
            Set<UserRoleEntity> roles = new HashSet<>() ;
            for(int i = 0 ; i < roleId.length ; i++) {
                UserRoleEntity roleEntity = userRoleService.getUserRoleById(Integer.valueOf(roleId[i])) ;
                roles.add(roleEntity);
            }
            user.setUserRoles(roles);
        }
        user.setStatus(UserStatus.ACTIVE);
        user.setPassword(encrytePassword(user.getPassword()));
        userService.save(user);
        return "redirect:/home" ;
    }

    @RequestMapping("/forgot-password")
    public String resetForm(@RequestParam(value = "type", required = false) String type,
                            @RequestParam(value = "message", required = false) String message,
                            Model model){
        model.addAttribute("type" , type) ;
        model.addAttribute("message" , message);
        return "user/forgot-password" ;
    }
    @RequestMapping(value = "/forgot-password" , method = RequestMethod.POST)
    public String forgotPass (Model model ,
                              @RequestParam("email") String email,
                              @RequestParam(value = "type", required = false) String type,
                              @RequestParam(value = "message", required = false) String message) throws MessagingException {
        UserEntity userEntity = userService.findByEmail(email) ;
        if(userEntity == null) {
            model.addAttribute("type" , "error") ;
            model.addAttribute("message" , "Email Not Found ! Please Again!") ;
           return "user/forgot-password" ;
        }
        // Send Mail
        MimeMessage mimeMessage = emailSender.createMimeMessage() ;
        boolean multipart= true ;
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage , multipart ,"utf-8");
        String htmlMsg = "" ;
        htmlMsg = "<h4>Hello " + userEntity.getFullName() + "</h4>" + "<br><br>"
                + "Please click here to reset your password " +
                "<a href=\"http://localhost:8080/change-password/" + userEntity.getId() +"\">" +"Reset" + "</a>" ;
        mimeMessage.setContent(htmlMsg , "text/html");
        helper.setTo(userEntity.getEmail()) ;
        helper.setSubject("Reset Password Success !");
        this.emailSender.send(mimeMessage);

        model.addAttribute("type" , "success");
        model.addAttribute("message" , "Please Check Mail to Reset Password") ;
        return "login" ;
    }

}
