package com.example.filter;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(urlPatterns = {"/*"})
public class AuthenticationFilter implements Filter {
    
    private List<String> excludeUrls;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        String excludePattern = filterConfig.getInitParameter("excludeUrls");
        if (excludePattern != null) {
            excludeUrls = Arrays.asList(excludePattern.split(","));
        }
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String uri = requestURI.substring(contextPath.length());
        
        // 检查是否为排除的URL
        boolean isExcluded = false;
        if (excludeUrls != null) {
            for (String excludeUrl : excludeUrls) {
                if (uri.startsWith(excludeUrl)) {
                    isExcluded = true;
                    break;
                }
            }
        }
        
        // 对于index.jsp, /login和静态资源，直接放行
        if (isExcluded || uri.equals("/") || uri.equals("") || uri.equals("/index.jsp") || 
            uri.startsWith("/login") || uri.startsWith("/static/")) {
            chain.doFilter(request, response);
            return;
        }
        
        // 获取会话并检查登录状态
        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedIn = session != null && session.getAttribute("isLoggedIn") != null && 
                             (Boolean) session.getAttribute("isLoggedIn");
        
        // 检查是否为管理员路径且用户是否为管理员
        boolean isAdminPath = uri.contains("/admin");
        boolean isAdmin = session != null && session.getAttribute("isAdmin") != null && 
                          (Boolean) session.getAttribute("isAdmin");
        
        // 仅用于测试目的 - 如果没有会话，创建一个模拟会话
        if (session == null || !isLoggedIn) {
            // 创建或获取会话
            session = httpRequest.getSession(true);
            // 设置默认登录状态和用户名
            session.setAttribute("isLoggedIn", true);
            session.setAttribute("username", "测试用户");
            session.setAttribute("isAdmin", true); // 默认都是管理员权限
            isLoggedIn = true;
            isAdmin = true;
        }
        
        // 如果未登录或尝试访问管理员页面但不是管理员
        if (!isLoggedIn || (isAdminPath && !isAdmin)) {
            // 对于AJAX请求返回401状态码
            if ("XMLHttpRequest".equals(httpRequest.getHeader("X-Requested-With"))) {
                httpResponse.sendError(HttpServletResponse.SC_UNAUTHORIZED, "未授权的访问");
            } else {
                // 普通请求重定向到登录页面
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/?error=请先登录");
            }
            return;
        }
        
        // 继续处理请求
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // 销毁过滤器
    }
} 