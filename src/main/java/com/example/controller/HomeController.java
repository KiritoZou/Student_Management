package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import jakarta.servlet.http.HttpSession;

/**
 * 首页控制器
 * 处理网站根路径的请求
 */
@Controller
public class HomeController {

    /**
     * 处理根路径请求，显示首页
     * @return 首页视图名称
     */
    @GetMapping("/")
    public String home(HttpSession session) {
        // 如果用户已登录，重定向到
        return "forward:/index.jsp";
    }
}