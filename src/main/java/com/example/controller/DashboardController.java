package com.example.controller;

import com.example.model.*;
import com.example.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Comparator;
import java.util.stream.Collectors;
import java.util.ArrayList;
import java.util.Map;

@Controller
public class DashboardController {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private CourseService courseService;
    
    @Autowired
    private AwardService awardService;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        // 检查用户是否已登录
        if (session.getAttribute("isLoggedIn") == null || !(Boolean)session.getAttribute("isLoggedIn")) {
            return "redirect:/login";
        }
        
        // 获取当前用户
        User user = (User) session.getAttribute("user");
        
        // 如果用户对象为null，创建一个简单的User对象作为替代
        if (user == null) {
            user = new User();
            String username = (String) session.getAttribute("username");
            user.setUsername(username);
            
            // 检查是否是管理员账户
            if (session.getAttribute("isAdmin") != null && (Boolean) session.getAttribute("isAdmin")) {
                // 设置管理员信息
                user.setRealName("哈基渊");
                user.setStudentId("001"); // 设置工号
                user.setStatus(1); // 管理员状态设为1
                
                // 设置头像路径
                model.addAttribute("avatarPath", "/static/images/boyuan.jpg");
                model.addAttribute("isAdmin", true);
            } else {
                // 一般学生用户
                user.setRealName(username);
                user.setStatus(0); // 普通用户状态设为0
                model.addAttribute("isAdmin", false);
            }
            
            try {
                // 尝试从UserService获取用户信息
                // 由于UserService接口中没有getUserByUsername方法，所以这里使用authenticate
                // 实际生产中应该添加适当的方法到UserService接口
                User dbUser = userService.authenticate(user.getUsername(), null);
                if (dbUser != null) {
                    user = dbUser;
                    // 如果是管理员，仍然使用我们设置的名称和工号
                    if (session.getAttribute("isAdmin") != null && (Boolean) session.getAttribute("isAdmin")) {
                        user.setRealName("哈基渊");
                        user.setStudentId("001");
                    }
                }
            } catch (Exception e) {
                // 如果获取失败，继续使用简单的User对象
            }
        }
        
        // 为模型添加必要信息
        model.addAttribute("user", user);
        
        try {
            // 如果是管理员，加载管理相关信息
            if (session.getAttribute("isAdmin") != null && (Boolean) session.getAttribute("isAdmin")) {
                // 加载所有学生的数据作为管理员查看
                loadAdminDashboardData(model);
            } else {
                // 加载学生自己的数据
                loadStudentDashboardData(user, model);
            }
        } catch (Exception e) {
            // 如果发生异常，使用空列表
            model.addAttribute("courseScores", new ArrayList<>());
            model.addAttribute("awards", new ArrayList<>());
            model.addAttribute("courses", new ArrayList<>());
            model.addAttribute("students", new ArrayList<>());
            model.addAttribute("pendingTasks", new ArrayList<>());
        }
        
        return "dashboard";
    }
    
    // 加载管理员的仪表盘数据
    private void loadAdminDashboardData(Model model) {
        // 这里可以加载管理员需要的数据，如学生列表、待处理的事项等
        List<Map<String, Object>> pendingTasks = new ArrayList<>();
        
        // 添加管理员的待办事项
        Map<String, Object> task1 = new java.util.HashMap<>();
        task1.put("title", "填报期末成绩");
        task1.put("deadline", "2023-07-15");
        task1.put("priority", "high");
        task1.put("course", "计算机科学导论");
        task1.put("class", "计算机1班");
        pendingTasks.add(task1);
        
        Map<String, Object> task2 = new java.util.HashMap<>();
        task2.put("title", "审核学生获奖信息");
        task2.put("deadline", "2023-07-10");
        task2.put("priority", "medium");
        task2.put("count", 5);
        pendingTasks.add(task2);
        
        Map<String, Object> task3 = new java.util.HashMap<>();
        task3.put("title", "组织教研活动");
        task3.put("deadline", "2023-07-20");
        task3.put("priority", "medium");
        task3.put("department", "计算机科学系");
        pendingTasks.add(task3);
        
        Map<String, Object> task4 = new java.util.HashMap<>();
        task4.put("title", "处理学生转专业申请");
        task4.put("deadline", "2023-07-25");
        task4.put("priority", "low");
        task4.put("count", 3);
        pendingTasks.add(task4);
        
        // 向模型添加待办事项
        model.addAttribute("pendingTasks", pendingTasks);
        
        // 向模型添加学生列表（简化版，实际应从数据库获取）
        List<Map<String, Object>> students = new ArrayList<>();
        
        // 添加几个学生记录
        Map<String, Object> student1 = new java.util.HashMap<>();
        student1.put("id", 1);
        student1.put("name", "张三");
        student1.put("studentId", "20230001");
        student1.put("major", "计算机科学与技术");
        student1.put("grade", 2023);
        student1.put("gpa", 3.7);
        students.add(student1);
        
        Map<String, Object> student2 = new java.util.HashMap<>();
        student2.put("id", 2);
        student2.put("name", "李四");
        student2.put("studentId", "20230002");
        student2.put("major", "计算机科学与技术");
        student2.put("grade", 2023);
        student2.put("gpa", 3.5);
        students.add(student2);
        
        Map<String, Object> student3 = new java.util.HashMap<>();
        student3.put("id", 3);
        student3.put("name", "小兰");
        student3.put("studentId", "20230003");
        student3.put("major", "计算机科学与技术");
        student3.put("grade", 2023);
        student3.put("gpa", 4.0);
        students.add(student3);
        
        model.addAttribute("students", students);
    }
    
    // 加载学生的仪表盘数据
    private void loadStudentDashboardData(User user, Model model) {
        // 获取课程成绩并排序
        List<CourseScore> courseScores = courseService.getScoresByUserId(user.getId());
        if (courseScores != null) {
            courseScores = courseScores.stream()
                .sorted(Comparator.comparing(CourseScore::getScore).reversed())
                .collect(Collectors.toList());
            model.addAttribute("courseScores", courseScores);
        } else {
            model.addAttribute("courseScores", new ArrayList<>());
        }
        
        // 获取获奖信息
        List<Award> awards = awardService.getAwardsByUserId(user.getId());
        if (awards != null) {
            awards = awards.stream()
                .sorted(Comparator.comparing(Award::getAwardDate).reversed())
                .collect(Collectors.toList());
            model.addAttribute("awards", awards);
        } else {
            model.addAttribute("awards", new ArrayList<>());
        }
        
        // 获取课程信息
        List<Course> courses = courseService.getCoursesByUserId(user.getId());
        if (courses != null) {
            model.addAttribute("courses", courses);
        } else {
            model.addAttribute("courses", new ArrayList<>());
        }
    }
} 