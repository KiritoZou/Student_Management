package com.example.service.impl;

import com.example.model.*;
import com.example.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Service
public class CourseServiceImpl implements CourseService {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<CourseScore> getScoresByUserId(Long userId) {
        String sql = "SELECT cs.*, c.name as course_name, c.credit, s.name as semester_name " +
                     "FROM course_scores cs " +
                     "JOIN courses c ON cs.course_id = c.id " +
                     "LEFT JOIN semesters s ON cs.semester_id = s.id " +
                     "WHERE cs.user_id = ?";
        
        try {
            return jdbcTemplate.query(sql, new CourseScoreRowMapper(), userId);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    @Override
    public List<Course> getCoursesByUserId(Long userId) {
        String sql = "SELECT c.* FROM courses c " +
                     "JOIN course_scores cs ON c.id = cs.course_id " +
                     "WHERE cs.user_id = ?";
        
        try {
            return jdbcTemplate.query(sql, new CourseRowMapper(), userId);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    private static class CourseScoreRowMapper implements RowMapper<CourseScore> {
        @Override
        public CourseScore mapRow(ResultSet rs, int rowNum) throws SQLException {
            CourseScore score = new CourseScore();
            score.setId(rs.getLong("id"));
            score.setUserId(rs.getLong("user_id"));
            score.setCourseId(rs.getLong("course_id"));
            score.setCourseName(rs.getString("course_name"));
            score.setScore(rs.getDouble("score"));
            score.setRanking(rs.getInt("ranking"));
            score.setSemester(rs.getString("semester"));
            
            // 可能为空的字段需要处理
            try {
                score.setSemesterId(rs.getLong("semester_id"));
            } catch (SQLException e) {
                // 字段不存在或为NULL时忽略
            }
            
            try {
                score.setSemesterName(rs.getString("semester_name"));
            } catch (SQLException e) {
                // 字段不存在或为NULL时忽略
            }
            
            try {
                score.setCredit(rs.getInt("credit"));
            } catch (SQLException e) {
                // 字段不存在或为NULL时忽略
            }
            
            try {
                double gpa = rs.getDouble("grade_point");
                score.setGradePoint(new BigDecimal(String.valueOf(gpa)));
            } catch (SQLException e) {
                // 字段不存在或为NULL时忽略
            }
            
            try {
                score.setTeacherComment(rs.getString("teacher_comment"));
            } catch (SQLException e) {
                // 字段不存在或为NULL时忽略
            }
            
            try {
                score.setExamDate(rs.getDate("exam_date"));
            } catch (SQLException e) {
                // 字段不存在或为NULL时忽略
            }
            
            return score;
        }
    }

    private static class CourseRowMapper implements RowMapper<Course> {
        @Override
        public Course mapRow(ResultSet rs, int rowNum) throws SQLException {
            Course course = new Course();
            course.setId(rs.getString("id"));
            course.setName(rs.getString("name"));
            course.setDescription(rs.getString("description"));
            course.setCredits(rs.getInt("credit"));
            course.setTeacherName(rs.getString("teacher"));
            course.setSemesterId(rs.getInt("semester_id"));
            return course;
        }
    }
} 