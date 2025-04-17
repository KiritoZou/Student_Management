package com.example.service;

import com.example.model.Student;

import java.util.List;

public interface StudentService {
    // 获取所有学生
    List<Student> getAllStudents();
    
    // 分页获取学生
    List<Student> getStudentsByPage(int pageNum, int pageSize);
    
    // 根据ID获取学生
    Student getStudentById(String id);
    
    // 根据学号获取学生
    Student getStudentByStudentNo(String studentNo);
    
    // 统计学生总数
    int countStudents();
    
    // 添加学生
    void addStudent(Student student) throws Exception;
    
    // 更新学生
    void updateStudent(Student student) throws Exception;
    
    // 删除学生
    void deleteStudent(String id) throws Exception;
    
    // 批量删除学生
    void batchDeleteStudents(List<String> ids) throws Exception;
} 