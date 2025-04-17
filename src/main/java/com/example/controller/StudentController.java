package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/student")
public class StudentController {

    @GetMapping("/list")
    public String list(Model model, 
                     @RequestParam(defaultValue = "1") int pageNum, 
                     @RequestParam(defaultValue = "10") int pageSize,
                     HttpSession session) {
        // 如果用户未登录，重定向到登录页面
        if (session.getAttribute("user") == null) {
            // 假设用户已登录 - 生产环境中应当验证用户登录状态
            // 为简化测试，这里暂时注释登录检查
            // return "redirect:/login";
        }
        
        // 简化版本，暂时使用假数据
        // 这部分已在JSP页面中硬编码，无需在此提供
        
        return "student/list";
    }

    @GetMapping("/add")
    public String showAddForm(HttpSession session) {
        // 如果用户未登录，重定向到登录页面
        if (session.getAttribute("user") == null) {
            // 假设用户已登录 - 生产环境中应当验证用户登录状态
            // 为简化测试，这里暂时注释登录检查
            // return "redirect:/login";
        }
        
        return "student/add";
    }
    
    @GetMapping("/view/{id}")
    public String viewStudent(@PathVariable Long id, Model model, HttpSession session) {
        // 如果用户未登录，重定向到登录页面
        if (session.getAttribute("isLoggedIn") == null) {
            // 为简化测试，这里暂时注释登录检查
            return "redirect:/login";
        }
        
        // 向模型添加学生ID
        model.addAttribute("studentId", id);
        
        // 假设添加三个学生的硬编码数据
        if (id == 1L) {
            addStudent1Data(model);
        } else if (id == 2L) {
            addStudent2Data(model);
        } else if (id == 3L) {
            addStudent3Data(model);
        } else {
            // 默认数据
            addDefaultStudentData(model);
        }
        
        // 简化版本，直接返回视图
        return "student/view";
    }
    
    @GetMapping("/edit/{id}")
    public String editStudent(@PathVariable Long id, Model model, HttpSession session) {
        // 如果用户未登录，重定向到登录页面
        if (session.getAttribute("isLoggedIn") == null) {
            // 为简化测试，这里暂时注释登录检查
            return "redirect:/login";
        }
        
        // 检查管理员权限
        if (session.getAttribute("isAdmin") == null || !(Boolean)session.getAttribute("isAdmin")) {
            return "redirect:/dashboard?error=无权访问";
        }
        
        // 向模型添加学生ID
        model.addAttribute("studentId", id);
        
        // 假设添加学生数据
        if (id == 1L) {
            addStudent1Data(model);
        } else if (id == 2L) {
            addStudent2Data(model);
        } else if (id == 3L) {
            addStudent3Data(model);
        } else {
            // 默认数据
            addDefaultStudentData(model);
        }
        
        // 简化版本，直接返回视图
        return "student/edit";
    }
    
    @GetMapping("/education/{id}")
    public String viewStudentEducation(@PathVariable Long id, Model model, HttpSession session) {
        // 如果用户未登录，重定向到登录页面
        if (session.getAttribute("isLoggedIn") == null) {
            return "redirect:/login";
        }
        
        // 向模型添加学生ID
        model.addAttribute("studentId", id);
        
        // 根据学生ID获取基本信息
        if (id == 1L) {
            addStudent1Data(model);
            addStudent1Education(model);
        } else if (id == 2L) {
            addStudent2Data(model);
            addStudent2Education(model);
        } else if (id == 3L) {
            addStudent3Data(model);
            addStudent3Education(model);
        } else {
            // 默认数据
            addDefaultStudentData(model);
            model.addAttribute("educations", new java.util.ArrayList<>());
        }
        
        return "student/education";
    }
    
    @GetMapping("/score/{id}")
    public String viewStudentScore(@PathVariable Long id, Model model, HttpSession session) {
        // 如果用户未登录，重定向到登录页面
        if (session.getAttribute("isLoggedIn") == null) {
            return "redirect:/login";
        }
        
        // 向模型添加学生ID
        model.addAttribute("studentId", id);
        
        // 根据学生ID获取基本信息和成绩信息
        if (id == 1L) {
            addStudent1Data(model);
            // 成绩信息已在addStudent1Data中添加
        } else if (id == 2L) {
            addStudent2Data(model);
            // 成绩信息已在addStudent2Data中添加
        } else if (id == 3L) {
            addStudent3Data(model);
            // 成绩信息已在addStudent3Data中添加
        } else {
            // 默认数据
            addDefaultStudentData(model);
        }
        
        return "student/score";
    }
    
    @GetMapping("/award/{id}")
    public String viewStudentAward(@PathVariable Long id, Model model, HttpSession session) {
        // 如果用户未登录，重定向到登录页面
        if (session.getAttribute("isLoggedIn") == null) {
            return "redirect:/login";
        }
        
        // 向模型添加学生ID
        model.addAttribute("studentId", id);
        
        // 根据学生ID获取基本信息和获奖信息
        if (id == 1L) {
            addStudent1Data(model);
            // 获奖信息已在addStudent1Data中添加
        } else if (id == 2L) {
            addStudent2Data(model);
            // 获奖信息已在addStudent2Data中添加
        } else if (id == 3L) {
            addStudent3Data(model);
            // 获奖信息已在addStudent3Data中添加
        } else {
            // 默认数据
            addDefaultStudentData(model);
        }
        
        return "student/award";
    }

    // 帮助方法：添加张三的数据
    private void addStudent1Data(Model model) {
        model.addAttribute("student", createStudentMap(
            1L, "张三", "20230001", "男", "1998-05-15", 
            "计算机科学与技术", "2023级", "计算机1班", "13800138001",
            "zhangsan@example.com", "北京市海淀区XX路XX号"
        ));
        
        // 添加该学生的成绩信息
        model.addAttribute("scores", createZhangsanScores());
        
        // 添加该学生的获奖信息
        model.addAttribute("awards", createZhangsanAwards());
    }
    
    // 帮助方法：添加李四的数据
    private void addStudent2Data(Model model) {
        model.addAttribute("student", createStudentMap(
            2L, "李四", "20230002", "男", "1999-03-22", 
            "计算机科学与技术", "2023级", "计算机1班", "13800138002",
            "lisi@example.com", "上海市浦东新区XX路XX号"
        ));
        
        // 添加该学生的成绩信息
        model.addAttribute("scores", createLisiScores());
        
        // 添加该学生的获奖信息
        model.addAttribute("awards", createLisiAwards());
    }
    
    // 帮助方法：添加小兰的数据
    private void addStudent3Data(Model model) {
        model.addAttribute("student", createStudentMap(
            3L, "小兰", "20230003", "女", "2000-07-30", 
            "计算机科学与技术", "2023级", "计算机1班", "13800138003",
            "xiaolan@example.com", "广州市天河区XX路XX号"
        ));
        
        // 添加该学生的成绩信息
        model.addAttribute("scores", createXiaolanScores());
        
        // 添加该学生的获奖信息
        model.addAttribute("awards", createXiaolanAwards());
    }
    
    // 帮助方法：添加默认数据
    private void addDefaultStudentData(Model model) {
        model.addAttribute("student", createStudentMap(
            0L, "未知学生", "0000000", "未知", "2000-01-01", 
            "未知专业", "未知年级", "未知班级", "未知电话",
            "unknown@example.com", "未知地址"
        ));
        
        // 添加空的成绩和获奖信息
        model.addAttribute("scores", new java.util.ArrayList<>());
        model.addAttribute("awards", new java.util.ArrayList<>());
    }
    
    // 帮助方法：创建学生信息映射
    private java.util.Map<String, Object> createStudentMap(Long id, String name, String studentId, 
                                                          String gender, String birthDate, 
                                                          String major, String grade, String className,
                                                          String phone, String email, String address) {
        java.util.Map<String, Object> student = new java.util.HashMap<>();
        student.put("id", id);
        student.put("name", name);
        student.put("studentId", studentId);
        student.put("gender", gender);
        student.put("birthDate", birthDate);
        student.put("major", major);
        student.put("grade", grade);
        student.put("className", className);
        student.put("phone", phone);
        student.put("email", email);
        student.put("address", address);
        student.put("status", "在读");
        return student;
    }
    
    // 帮助方法：创建张三的成绩信息
    private java.util.List<java.util.Map<String, Object>> createZhangsanScores() {
        java.util.List<java.util.Map<String, Object>> scores = new java.util.ArrayList<>();
        
        scores.add(createScoreMap("高等数学", "85.5", "3.7", "10/60", "2023年秋季", "已通过"));
        scores.add(createScoreMap("大学物理", "78.0", "3.0", "15/60", "2023年秋季", "已通过"));
        scores.add(createScoreMap("大学英语", "92.0", "4.0", "5/60", "2023年秋季", "已通过"));
        scores.add(createScoreMap("计算机科学导论", "88.5", "3.7", "8/60", "2023年秋季", "已通过"));
        
        return scores;
    }
    
    // 帮助方法：创建李四的成绩信息
    private java.util.List<java.util.Map<String, Object>> createLisiScores() {
        java.util.List<java.util.Map<String, Object>> scores = new java.util.ArrayList<>();
        
        scores.add(createScoreMap("高等数学", "76.5", "2.7", "25/60", "2023年秋季", "已通过"));
        scores.add(createScoreMap("大学英语", "95.0", "4.0", "3/60", "2023年秋季", "已通过"));
        scores.add(createScoreMap("体育", "90.0", "4.0", "2/60", "2023年秋季", "已通过"));
        scores.add(createScoreMap("普通化学", "82.0", "3.3", "12/60", "2023年秋季", "已通过"));
        
        return scores;
    }
    
    // 帮助方法：创建小兰的成绩信息
    private java.util.List<java.util.Map<String, Object>> createXiaolanScores() {
        java.util.List<java.util.Map<String, Object>> scores = new java.util.ArrayList<>();
        
        scores.add(createScoreMap("高等数学", "94.0", "4.0", "2/60", "2023年秋季", "已通过"));
        scores.add(createScoreMap("大学物理", "89.5", "3.7", "7/60", "2023年秋季", "已通过"));
        scores.add(createScoreMap("计算机科学导论", "91.0", "4.0", "4/60", "2023年秋季", "已通过"));
        scores.add(createScoreMap("普通化学", "87.0", "3.7", "9/60", "2023年秋季", "已通过"));
        
        return scores;
    }
    
    // 帮助方法：创建成绩映射
    private java.util.Map<String, Object> createScoreMap(String courseName, String score, 
                                                        String gradePoint, String ranking, 
                                                        String semester, String status) {
        java.util.Map<String, Object> scoreMap = new java.util.HashMap<>();
        scoreMap.put("courseName", courseName);
        scoreMap.put("score", score);
        scoreMap.put("gradePoint", gradePoint);
        scoreMap.put("ranking", ranking);
        scoreMap.put("semester", semester);
        scoreMap.put("status", status);
        return scoreMap;
    }
    
    // 帮助方法：创建张三的获奖信息
    private java.util.List<java.util.Map<String, Object>> createZhangsanAwards() {
        java.util.List<java.util.Map<String, Object>> awards = new java.util.ArrayList<>();
        
        awards.add(createAwardMap("全国大学生数学建模竞赛一等奖", "国家级", "学术类", "2020-11-15", "中国工业与应用数学学会", "团队合作完成复杂数学建模问题"));
        awards.add(createAwardMap("校级三好学生", "校级", "其他", "2021-06-20", "清华大学", "连续两年获得校级三好学生称号"));
        
        return awards;
    }
    
    // 帮助方法：创建李四的获奖信息
    private java.util.List<java.util.Map<String, Object>> createLisiAwards() {
        java.util.List<java.util.Map<String, Object>> awards = new java.util.ArrayList<>();
        
        awards.add(createAwardMap("ACM国际大学生程序设计竞赛亚洲区银奖", "国际级", "学术类", "2020-10-25", "ACM国际组织", "算法设计与实现能力突出"));
        awards.add(createAwardMap("全国大学生英语演讲比赛特等奖", "国家级", "学术类", "2021-05-18", "教育部高等学校大学外语教学指导委员会", "英语演讲与即兴问答表现优异"));
        awards.add(createAwardMap("校级优秀学生干部", "校级", "其他", "2021-06-15", "北京大学", "担任班级学习委员，工作认真负责"));
        
        return awards;
    }
    
    // 帮助方法：创建小兰的获奖信息
    private java.util.List<java.util.Map<String, Object>> createXiaolanAwards() {
        java.util.List<java.util.Map<String, Object>> awards = new java.util.ArrayList<>();
        
        awards.add(createAwardMap("全国电子设计竞赛一等奖", "国家级", "学术类", "2021-08-12", "教育部高等教育司", "设计并实现智能家居控制系统"));
        awards.add(createAwardMap("浙江省大学生运动会女子100米冠军", "省级", "体育类", "2020-10-08", "浙江省教育厅", "打破校运动会记录"));
        awards.add(createAwardMap("国家奖学金", "国家级", "学术类", "2021-11-10", "教育部", "学业成绩与综合素质表现优异"));
        
        return awards;
    }
    
    // 帮助方法：创建获奖信息映射
    private java.util.Map<String, Object> createAwardMap(String awardName, String level, 
                                                        String type, String awardDate, 
                                                        String organization, String description) {
        java.util.Map<String, Object> awardMap = new java.util.HashMap<>();
        awardMap.put("awardName", awardName);
        awardMap.put("level", level);
        awardMap.put("type", type);
        awardMap.put("awardDate", awardDate);
        awardMap.put("organization", organization);
        awardMap.put("description", description);
        return awardMap;
    }

    // 添加学生的学历信息
    private void addStudent1Education(Model model) {
        java.util.List<java.util.Map<String, Object>> educations = new java.util.ArrayList<>();
        
        educations.add(createEducationMap("小学", "实验小学", "2000-09-01", "2006-07-01", null, "1班", "小学教育阶段"));
        educations.add(createEducationMap("初中", "实验中学", "2006-09-01", "2009-07-01", null, "2班", "初中教育阶段"));
        educations.add(createEducationMap("高中", "实验高中", "2009-09-01", "2012-07-01", "理科", "3班", "高中教育阶段"));
        educations.add(createEducationMap("大学", "某某大学", "2012-09-01", "2016-07-01", "计算机科学", "计算机1班", "本科教育阶段"));
        
        model.addAttribute("educations", educations);
    }
    
    private void addStudent2Education(Model model) {
        java.util.List<java.util.Map<String, Object>> educations = new java.util.ArrayList<>();
        
        educations.add(createEducationMap("小学", "第二实验小学", "2001-09-01", "2007-07-01", null, "3班", "小学教育阶段"));
        educations.add(createEducationMap("初中", "第二实验中学", "2007-09-01", "2010-07-01", null, "1班", "初中教育阶段"));
        educations.add(createEducationMap("高中", "第二实验高中", "2010-09-01", "2013-07-01", "理科", "2班", "高中教育阶段"));
        educations.add(createEducationMap("大学", "北京大学", "2013-09-01", "2017-07-01", "计算机科学", "计算机2班", "本科教育阶段"));
        
        model.addAttribute("educations", educations);
    }
    
    private void addStudent3Education(Model model) {
        java.util.List<java.util.Map<String, Object>> educations = new java.util.ArrayList<>();
        
        educations.add(createEducationMap("小学", "阳光小学", "2002-09-01", "2008-07-01", null, "2班", "小学教育阶段"));
        educations.add(createEducationMap("初中", "阳光中学", "2008-09-01", "2011-07-01", null, "1班", "初中教育阶段"));
        educations.add(createEducationMap("高中", "阳光高中", "2011-09-01", "2014-07-01", "理科", "1班", "高中教育阶段"));
        educations.add(createEducationMap("大学", "浙江大学", "2014-09-01", "2018-07-01", "计算机科学", "计算机1班", "本科教育阶段"));
        
        model.addAttribute("educations", educations);
    }
    
    // 帮助方法：创建学历映射
    private java.util.Map<String, Object> createEducationMap(String level, String school, 
                                                            String startDate, String endDate, 
                                                            String major, String className, String description) {
        java.util.Map<String, Object> education = new java.util.HashMap<>();
        education.put("level", level);
        education.put("school", school);
        education.put("startDate", startDate);
        education.put("endDate", endDate);
        education.put("major", major);
        education.put("className", className);
        education.put("description", description);
        return education;
    }
} 