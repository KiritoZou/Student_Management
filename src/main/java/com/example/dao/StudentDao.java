package com.example.dao;

import com.example.model.Student;
import java.util.List;

public interface StudentDao {
    // 查询所有学生
    List<Student> findAll();
    
    // 分页查询
    List<Student> findByPage(int offset, int limit);
    
    // 根据ID查询学生
    Student findById(String id);
    
    // 根据学号查询学生
    Student findByStudentNo(String studentNo);
    
    // 统计学生总数
    int count();
    
    // 添加学生
    void insert(Student student);
    
    // 更新学生
    int update(Student student);
    
    // 删除学生
    int delete(String id);
    
    // 批量删除学生
    int batchDelete(List<String> ids);
} 