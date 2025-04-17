package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;

@Controller
public class LoginController {
    
    @GetMapping("/login")
    public String showLoginPage() {
        return "redirect:/";
    }
    
    @PostMapping("/login")
    public String login(@RequestParam String username, 
                       @RequestParam String password,
                       HttpSession session,
                       Model model) {
        // 简化的身份验证逻辑 - 只要密码是zby2766485803即可通过
        if ("zby2766485803".equals(password)) {
            session.setAttribute("username", username);
            session.setAttribute("isLoggedIn", true);
            session.setAttribute("isAdmin", "root".equals(username));
            return "redirect:/dashboard";
        } else {
            return "redirect:/?error=用户名或密码错误";
        }
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
} 