package com.example.controller;

import com.example.model.Course;
import com.example.model.Semester;
import com.example.service.CourseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/course")
public class CourseController {

    @Autowired
    private CourseService courseService;

    @GetMapping("/list")
    public String listCourses(Model model, HttpSession session) {
        // 检查用户是否登录
        Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
        if (isLoggedIn == null || !isLoggedIn) {
            return "redirect:/login";
        }
        
        // 模拟从数据库获取课程列表
        List<Map<String, Object>> courses = getMockCourses();
        
        // 模拟从数据库获取学期列表
        List<Map<String, Object>> semesters = getMockSemesters();
        
        model.addAttribute("courses", courses);
        model.addAttribute("semesters", semesters);
        
        // 添加管理员状态到模型
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        model.addAttribute("isAdmin", isAdmin != null && isAdmin);
        
        return "course/list";
    }
    
    @GetMapping("/add")
    public String showAddCourseForm(Model model, HttpSession session) {
        // 检查用户是否登录且是管理员
        Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (isLoggedIn == null || !isLoggedIn || isAdmin == null || !isAdmin) {
            return "redirect:/login";
        }
        
        // 模拟从数据库获取学期列表，用于下拉选择
        List<Map<String, Object>> semesters = getMockSemesters();
        model.addAttribute("semesters", semesters);
        
        return "course/add";
    }
    
    @PostMapping("/save")
    public String saveCourse(@ModelAttribute Course course, 
                            RedirectAttributes redirectAttributes,
                            HttpSession session) {
        // 检查用户是否登录且是管理员
        Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (isLoggedIn == null || !isLoggedIn || isAdmin == null || !isAdmin) {
            return "redirect:/login";
        }
        
        try {
            // 这里应该调用服务层保存课程
            // courseService.saveCourse(course);
            
            // 由于是模拟实现，我们只返回成功消息
            redirectAttributes.addFlashAttribute("message", "课程保存成功！");
            return "redirect:/course/list";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "保存课程失败：" + e.getMessage());
            redirectAttributes.addFlashAttribute("course", course);
            return "redirect:/course/add";
        }
    }
    
    @GetMapping("/edit/{id}")
    public String showEditCourseForm(@PathVariable String id, Model model, HttpSession session) {
        // 检查用户是否登录且是管理员
        Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (isLoggedIn == null || !isLoggedIn || isAdmin == null || !isAdmin) {
            return "redirect:/login";
        }
        
        // 模拟从数据库获取课程信息
        Map<String, Object> course = getMockCourseById(id);
        if (course == null) {
            return "redirect:/course/list";
        }
        
        // 模拟从数据库获取学期列表，用于下拉选择
        List<Map<String, Object>> semesters = getMockSemesters();
        
        model.addAttribute("course", course);
        model.addAttribute("semesters", semesters);
        
        return "course/edit";
    }
    
    @GetMapping("/view/{id}")
    public String viewCourse(@PathVariable String id, Model model, HttpSession session) {
        // 检查用户是否登录
        Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
        if (isLoggedIn == null || !isLoggedIn) {
            return "redirect:/login";
        }
        
        // 模拟从数据库获取课程信息
        Map<String, Object> course = getMockCourseById(id);
        if (course == null) {
            return "redirect:/course/list";
        }
        
        model.addAttribute("course", course);
        
        // 添加管理员状态到模型
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        model.addAttribute("isAdmin", isAdmin != null && isAdmin);
        
        return "course/view";
    }
    
    @GetMapping("/delete/{id}")
    public String deleteCourse(@PathVariable String id, 
                             RedirectAttributes redirectAttributes,
                             HttpSession session) {
        // 检查用户是否登录且是管理员
        Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (isLoggedIn == null || !isLoggedIn || isAdmin == null || !isAdmin) {
            return "redirect:/login";
        }
        
        try {
            // 这里应该调用服务层删除课程
            // courseService.deleteCourse(id);
            
            // 由于是模拟实现，我们只返回成功消息
            redirectAttributes.addFlashAttribute("message", "课程删除成功！");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "删除课程失败：" + e.getMessage());
        }
        
        return "redirect:/course/list";
    }
    
    // 模拟获取课程列表
    private List<Map<String, Object>> getMockCourses() {
        List<Map<String, Object>> courses = new ArrayList<>();
        
        Map<String, Object> course1 = new HashMap<>();
        course1.put("id", "CS101");
        course1.put("name", "计算机导论");
        course1.put("description", "计算机基础知识入门课程");
        course1.put("credits", 3);
        course1.put("teacherName", "张教授");
        course1.put("semesterId", 1);
        course1.put("semesterName", "2023-2024学年第一学期");
        
        Map<String, Object> course2 = new HashMap<>();
        course2.put("id", "CS102");
        course2.put("name", "C语言程序设计");
        course2.put("description", "C语言基础及应用");
        course2.put("credits", 4);
        course2.put("teacherName", "李教授");
        course2.put("semesterId", 1);
        course2.put("semesterName", "2023-2024学年第一学期");
        
        Map<String, Object> course3 = new HashMap<>();
        course3.put("id", "CS201");
        course3.put("name", "数据结构");
        course3.put("description", "基本数据结构与算法");
        course3.put("credits", 4);
        course3.put("teacherName", "王教授");
        course3.put("semesterId", 2);
        course3.put("semesterName", "2023-2024学年第二学期");
        
        Map<String, Object> course4 = new HashMap<>();
        course4.put("id", "CS202");
        course4.put("name", "数据库原理");
        course4.put("description", "数据库系统概念与设计");
        course4.put("credits", 3);
        course4.put("teacherName", "刘教授");
        course4.put("semesterId", 2);
        course4.put("semesterName", "2023-2024学年第二学期");
        
        courses.add(course1);
        courses.add(course2);
        courses.add(course3);
        courses.add(course4);
        
        return courses;
    }
    
    // 模拟根据ID获取课程信息
    private Map<String, Object> getMockCourseById(String id) {
        List<Map<String, Object>> courses = getMockCourses();
        
        for (Map<String, Object> course : courses) {
            if (course.get("id").equals(id)) {
                return course;
            }
        }
        
        return null;
    }
    
    // 模拟获取学期列表
    private List<Map<String, Object>> getMockSemesters() {
        List<Map<String, Object>> semesters = new ArrayList<>();
        
        Map<String, Object> semester1 = new HashMap<>();
        semester1.put("id", 1);
        semester1.put("name", "2023-2024学年第一学期");
        semester1.put("startDate", "2023-09-01");
        semester1.put("endDate", "2024-01-15");
        semester1.put("isCurrent", true);
        
        Map<String, Object> semester2 = new HashMap<>();
        semester2.put("id", 2);
        semester2.put("name", "2023-2024学年第二学期");
        semester2.put("startDate", "2024-02-15");
        semester2.put("endDate", "2024-07-01");
        semester2.put("isCurrent", false);
        
        semesters.add(semester1);
        semesters.add(semester2);
        
        return semesters;
    }
} 