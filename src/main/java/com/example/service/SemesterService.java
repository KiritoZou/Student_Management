package com.example.service;

import java.util.List;
import com.example.model.Semester;

/**
 * 学期服务接口
 */
public interface SemesterService {
    
    /**
     * 获取所有学期列表
     */
    List<Semester> getAllSemesters();
    
    /**
     * 根据ID查找学期
     */
    Semester getSemesterById(Integer id);
    
    /**
     * 添加学期
     */
    void addSemester(Semester semester);
    
    /**
     * 更新学期信息
     */
    void updateSemester(Semester semester);
    
    /**
     * 删除学期
     */
    void deleteSemester(Integer id);
    
    /**
     * 获取当前学期
     */
    Semester getCurrentSemester();
    
    /**
     * 设置当前学期
     */
    void setCurrentSemester(Integer id);
} 