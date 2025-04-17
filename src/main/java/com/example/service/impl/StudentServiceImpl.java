package com.example.service.impl;

import com.example.dao.StudentDao;
import com.example.model.Student;
import com.example.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class StudentServiceImpl implements StudentService {

    @Autowired
    private StudentDao studentDao;

    @Override
    public List<Student> getAllStudents() {
        return studentDao.findAll();
    }

    @Override
    public List<Student> getStudentsByPage(int pageNum, int pageSize) {
        int offset = (pageNum - 1) * pageSize;
        return studentDao.findByPage(offset, pageSize);
    }

    @Override
    public Student getStudentById(String id) {
        return studentDao.findById(id);
    }

    @Override
    public Student getStudentByStudentNo(String studentNo) {
        return studentDao.findByStudentNo(studentNo);
    }

    @Override
    public int countStudents() {
        return studentDao.count();
    }

    @Override
    @Transactional
    public void addStudent(Student student) throws Exception {
        // 检查学号是否已存在
        Student existingStudent = studentDao.findByStudentNo(student.getStudentNo());
        if (existingStudent != null) {
            throw new Exception("学号 " + student.getStudentNo() + " 已存在");
        }
        
        // 添加学生
        studentDao.insert(student);
    }

    @Override
    @Transactional
    public void updateStudent(Student student) throws Exception {
        // 检查学号是否已存在（排除当前学生）
        Student existingStudent = studentDao.findByStudentNo(student.getStudentNo());
        if (existingStudent != null && !existingStudent.getId().equals(student.getId())) {
            throw new Exception("学号 " + student.getStudentNo() + " 已存在");
        }
        
        // 更新学生
        int rows = studentDao.update(student);
        if (rows == 0) {
            throw new Exception("学生不存在或未更新任何信息");
        }
    }

    @Override
    @Transactional
    public void deleteStudent(String id) throws Exception {
        int rows = studentDao.delete(id);
        if (rows == 0) {
            throw new Exception("学生不存在，无法删除");
        }
    }

    @Override
    @Transactional
    public void batchDeleteStudents(List<String> ids) throws Exception {
        // 实现批量删除方法
        if (ids == null || ids.isEmpty()) {
            throw new Exception("未选择任何学生");
        }
        
        int deletedCount = studentDao.batchDelete(ids);
        if (deletedCount == 0) {
            throw new Exception("删除失败，请稍后再试");
        }
    }
} 