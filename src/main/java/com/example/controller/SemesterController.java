package com.example.controller;

import com.example.model.Semester;
import com.example.service.SemesterService;
import com.example.service.impl.SemesterServiceImpl;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/semester")
public class SemesterController {
    
    private SemesterService semesterService = new SemesterServiceImpl();

    @GetMapping("/list")
    public String listSemesters(Model model, HttpSession session) {
        // 检查用户是否登录
        Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
        if (isLoggedIn == null || !isLoggedIn) {
            return "redirect:/login";
        }
        
        // 检查是否有管理员权限
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (isAdmin == null || !isAdmin) {
            return "redirect:/dashboard?error=无权访问";
        }
        
        // 从数据库获取学期列表
        List<Semester> semesters = semesterService.getAllSemesters();
        
        model.addAttribute("semesters", semesters);
        
        return "semester/list";
    }
    
    @GetMapping("/add")
    public String showAddForm(Model model, HttpSession session) {
        // 检查用户是否登录
        Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
        if (isLoggedIn == null || !isLoggedIn) {
            return "redirect:/login";
        }
        
        // 检查是否有管理员权限
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (isAdmin == null || !isAdmin) {
            return "redirect:/dashboard?error=无权访问";
        }
        
        // 创建一个新的空学期对象用于表单
        model.addAttribute("semester", new Semester());
        
        return "semester/form";
    }
    
    @PostMapping("/add")
    public String addSemester(@ModelAttribute Semester semester, 
                             RedirectAttributes redirectAttributes,
                             HttpSession session) {
        // 检查用户是否登录
        Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
        if (isLoggedIn == null || !isLoggedIn) {
            return "redirect:/login";
        }
        
        // 检查是否有管理员权限
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (isAdmin == null || !isAdmin) {
            return "redirect:/dashboard?error=无权访问";
        }
        
        // 保存学期到数据库
        semesterService.addSemester(semester);
        
        redirectAttributes.addFlashAttribute("successMessage", "学期添加成功！");
        
        return "redirect:/semester/list";
    }
    
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Integer id, Model model, HttpSession session) {
        // 检查用户是否登录
        Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
        if (isLoggedIn == null || !isLoggedIn) {
            return "redirect:/login";
        }
        
        // 检查是否有管理员权限
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (isAdmin == null || !isAdmin) {
            return "redirect:/dashboard?error=无权访问";
        }
        
        // 从数据库获取学期
        Semester semester = semesterService.getSemesterById(id);
        
        if (semester == null) {
            return "redirect:/semester/list?error=学期不存在";
        }
        
        model.addAttribute("semester", semester);
        
        return "semester/form";
    }
    
    @PostMapping("/update")
    public String updateSemester(@ModelAttribute Semester semester, 
                                RedirectAttributes redirectAttributes,
                                HttpSession session) {
        // 检查用户是否登录
        Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
        if (isLoggedIn == null || !isLoggedIn) {
            return "redirect:/login";
        }
        
        // 检查是否有管理员权限
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (isAdmin == null || !isAdmin) {
            return "redirect:/dashboard?error=无权访问";
        }
        
        // 更新学期到数据库
        semesterService.updateSemester(semester);
        
        redirectAttributes.addFlashAttribute("successMessage", "学期更新成功！");
        
        return "redirect:/semester/list";
    }
    
    @GetMapping("/delete/{id}")
    public String deleteSemester(@PathVariable Integer id, 
                                RedirectAttributes redirectAttributes,
                                HttpSession session) {
        // 检查用户是否登录
        Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
        if (isLoggedIn == null || !isLoggedIn) {
            return "redirect:/login";
        }
        
        // 检查是否有管理员权限
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (isAdmin == null || !isAdmin) {
            return "redirect:/dashboard?error=无权访问";
        }
        
        // 从数据库删除学期
        semesterService.deleteSemester(id);
        
        redirectAttributes.addFlashAttribute("successMessage", "学期删除成功！");
        
        return "redirect:/semester/list";
    }
    
    @GetMapping("/setCurrent/{id}")
    public String setCurrentSemester(@PathVariable Integer id, 
                                    RedirectAttributes redirectAttributes,
                                    HttpSession session) {
        // 检查用户是否登录
        Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
        if (isLoggedIn == null || !isLoggedIn) {
            return "redirect:/login";
        }
        
        // 检查是否有管理员权限
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (isAdmin == null || !isAdmin) {
            return "redirect:/dashboard?error=无权访问";
        }
        
        // 设置当前学期
        semesterService.setCurrentSemester(id);
        
        redirectAttributes.addFlashAttribute("successMessage", "当前学期设置成功！");
        
        return "redirect:/semester/list";
    }
} 