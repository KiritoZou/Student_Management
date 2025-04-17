package com.example.controller;

import com.example.model.Course;
import com.example.model.Semester;
import com.example.model.Student;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ScoreController {

    @GetMapping("/student/score")
    public String showStudentScore(@RequestParam("id") String studentId, Model model, HttpSession session) {
        // 检查用户是否登录
        Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
        if (isLoggedIn == null || !isLoggedIn) {
            return "redirect:/login";
        }
        
        // 模拟从数据库获取学生信息
        Student student = new Student();
        student.setId(studentId);
        student.setName("张三");
        student.setMajor("计算机科学与技术");
        
        // 模拟从数据库获取学生成绩信息
        Map<String, Map<String, Object>> scores = getStudentScores(studentId);
        
        model.addAttribute("student", student);
        model.addAttribute("scores", scores);
        
        return "student/score";
    }
    
    // 模拟获取学生成绩数据
    private Map<String, Map<String, Object>> getStudentScores(String studentId) {
        Map<String, Map<String, Object>> semesterMap = new LinkedHashMap<>();
        
        // 第一学期
        Map<String, Object> semester1 = new LinkedHashMap<>();
        List<Map<String, Object>> courses1 = new ArrayList<>();
        
        Map<String, Object> course1 = new LinkedHashMap<>();
        course1.put("name", "高等数学");
        course1.put("code", "MATH101");
        course1.put("credit", 4.0);
        course1.put("score", 85);
        course1.put("gpa", 3.7);
        
        Map<String, Object> course2 = new LinkedHashMap<>();
        course2.put("name", "大学英语");
        course2.put("code", "ENG101");
        course2.put("credit", 3.0);
        course2.put("score", 92);
        course2.put("gpa", 4.0);
        
        Map<String, Object> course3 = new LinkedHashMap<>();
        course3.put("name", "计算机导论");
        course3.put("code", "CS101");
        course3.put("credit", 3.0);
        course3.put("score", 78);
        course3.put("gpa", 3.0);
        
        courses1.add(course1);
        courses1.add(course2);
        courses1.add(course3);
        
        semester1.put("courses", courses1);
        semester1.put("averageGpa", 3.57);
        
        // 第二学期
        Map<String, Object> semester2 = new LinkedHashMap<>();
        List<Map<String, Object>> courses2 = new ArrayList<>();
        
        Map<String, Object> course4 = new LinkedHashMap<>();
        course4.put("name", "线性代数");
        course4.put("code", "MATH201");
        course4.put("credit", 3.0);
        course4.put("score", 75);
        course4.put("gpa", 2.7);
        
        Map<String, Object> course5 = new LinkedHashMap<>();
        course5.put("name", "数据结构");
        course5.put("code", "CS201");
        course5.put("credit", 4.0);
        course5.put("score", 88);
        course5.put("gpa", 3.7);
        
        Map<String, Object> course6 = new LinkedHashMap<>();
        course6.put("name", "面向对象程序设计");
        course6.put("code", "CS202");
        course6.put("credit", 4.0);
        course6.put("score", 90);
        course6.put("gpa", 4.0);
        
        courses2.add(course4);
        courses2.add(course5);
        courses2.add(course6);
        
        semester2.put("courses", courses2);
        semester2.put("averageGpa", 3.47);
        
        semesterMap.put("2023-2024学年第一学期", semester1);
        semesterMap.put("2023-2024学年第二学期", semester2);
        
        return semesterMap;
    }
} 