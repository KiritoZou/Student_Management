package com.example.dao;

import java.util.List;
import com.example.model.Semester;

/**
 * 学期数据访问接口
 */
public interface SemesterDao {
    
    /**
     * 获取所有学期列表
     */
    List<Semester> findAll();
    
    /**
     * 根据ID查找学期
     */
    Semester findById(Integer id);
    
    /**
     * 保存学期信息
     */
    void save(Semester semester);
    
    /**
     * 更新学期信息
     */
    void update(Semester semester);
    
    /**
     * 删除学期
     */
    void delete(Integer id);
    
    /**
     * 获取当前学期
     */
    Semester findCurrentSemester();
    
    /**
     * 设置当前学期
     */
    void setCurrentSemester(Integer id);
} 