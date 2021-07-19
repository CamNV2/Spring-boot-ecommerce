package com.app.ecommerce.config;

import com.app.ecommerce.services.UserDetailsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@Configuration
@EnableWebSecurity
@ComponentScan(basePackages = {"com.app.ecommerce"})
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private UserDetailsServiceImpl userDetailsService ;

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder() ;
        return bCryptPasswordEncoder ;
    }
    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws  Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable() ;
        http.authorizeRequests().antMatchers("/" , "/login" , "/logout" , "/home").permitAll();
        http.authorizeRequests().antMatchers("/user/*").access("hasAnyRole('ROLE_ADMIN ,ROLE_USER ')")
                .antMatchers("/admin/*").access("hasAnyRole('ROLE_ADMIN')") ;
        http.authorizeRequests().and().exceptionHandling().accessDeniedPage("/403") ;
        http.authorizeRequests().and().formLogin()
                .loginProcessingUrl("/j_spring_security_check")
                .loginPage("/login")
                .defaultSuccessUrl("/home")
                .failureUrl("/login?type=fail")
                .usernameParameter("email")
                .passwordParameter("password")
                .and().logout().logoutUrl("/logout")
                .logoutSuccessUrl("/home").deleteCookies("JSESSIONID") ;
    }
}
