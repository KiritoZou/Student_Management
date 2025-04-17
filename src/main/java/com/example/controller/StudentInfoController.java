package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.beans.factory.annotation.Autowired;

import jakarta.servlet.http.HttpSession;

@Controller
public class StudentInfoController {
    
    @GetMapping("/student_info")
    public String showStudentInfo(HttpSession session, Model model) {
        // 检查用户是否已登录
        if (session.getAttribute("isLoggedIn") == null || 
            !(Boolean)session.getAttribute("isLoggedIn")) {
            return "redirect:/login";
        }
        
        // 设置用户名
        model.addAttribute("username", session.getAttribute("username"));
        
        // 返回学生信息页面
        return "student_info";
    }
} 