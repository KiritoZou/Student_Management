package com.example.service.impl;

import java.util.List;

import com.example.dao.SemesterDao;
import com.example.dao.impl.SemesterDaoImpl;
import com.example.model.Semester;
import com.example.service.SemesterService;

/**
 * 学期服务实现类
 */
public class SemesterServiceImpl implements SemesterService {
    
    private SemesterDao semesterDao = new SemesterDaoImpl();

    @Override
    public List<Semester> getAllSemesters() {
        return semesterDao.findAll();
    }

    @Override
    public Semester getSemesterById(Integer id) {
        return semesterDao.findById(id);
    }

    @Override
    public void addSemester(Semester semester) {
        semesterDao.save(semester);
    }

    @Override
    public void updateSemester(Semester semester) {
        semesterDao.update(semester);
    }

    @Override
    public void deleteSemester(Integer id) {
        semesterDao.delete(id);
    }

    @Override
    public Semester getCurrentSemester() {
        return semesterDao.findCurrentSemester();
    }

    @Override
    public void setCurrentSemester(Integer id) {
        semesterDao.setCurrentSemester(id);
    }
} 