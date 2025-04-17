package com.example.dao;

import com.example.model.CourseScore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class CourseScoreDAO {
    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public CourseScoreDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<CourseScore> findByUserId(Long userId) {
        String sql = "SELECT cs.*, c.course_name, c.credit, s.semester_name " +
                    "FROM course_scores cs " +
                    "JOIN courses c ON cs.course_id = c.course_id " +
                    "JOIN semesters s ON cs.semester_id = s.semester_id " +
                    "WHERE cs.user_id = ? " +
                    "ORDER BY s.start_date DESC, c.course_name";
        
        return jdbcTemplate.query(sql, new CourseScoreRowMapper(), userId);
    }

    // 添加 RowMapper 内部类
    private static class CourseScoreRowMapper implements RowMapper<CourseScore> {
        @Override
        public CourseScore mapRow(ResultSet rs, int rowNum) throws SQLException {
            CourseScore score = new CourseScore();
            score.setId(rs.getLong("score_id"));
            score.setUserId(rs.getLong("user_id"));
            score.setCourseId(rs.getLong("course_id"));
            score.setSemesterId(rs.getLong("semester_id"));
            
            // 处理score字段，将BigDecimal转换为Double
            BigDecimal scoreValue = rs.getBigDecimal("score");
            if (scoreValue != null) {
                score.setScore(scoreValue.doubleValue());
            }
            
            // 处理gradePoint字段
            BigDecimal gradePoint = rs.getBigDecimal("grade_point");
            if (gradePoint != null) {
                score.setGradePoint(gradePoint);
            }
            
            score.setRanking(rs.getInt("ranking"));
            score.setTeacherComment(rs.getString("teacher_comment"));
            score.setExamDate(rs.getDate("exam_date"));
            
            // 设置关联数据
            score.setCourseName(rs.getString("course_name"));
            score.setCredit(rs.getInt("credit"));
            score.setSemesterName(rs.getString("semester_name"));
            
            return score;
        }
    }
} 