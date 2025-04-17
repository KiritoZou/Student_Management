package com.example.dao;

import com.example.model.Education;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class EducationDAO {
    private final JdbcTemplate jdbcTemplate;

    // 定义教育等级顺序
    private static final String EDUCATION_LEVEL_ORDER = 
        "CASE education_level " +
        "WHEN '小学' THEN 1 " +
        "WHEN '初中' THEN 2 " +
        "WHEN '高中' THEN 3 " +
        "WHEN '中专' THEN 3 " +
        "WHEN '大专' THEN 4 " +
        "WHEN '本科' THEN 5 " +
        "WHEN '硕士' THEN 6 " +
        "WHEN '博士' THEN 7 " +
        "ELSE 8 END";

    @Autowired
    public EducationDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Education> findByUserId(Long userId) {
        String sql = "SELECT * FROM education WHERE user_id = ? " +
                    "ORDER BY " + EDUCATION_LEVEL_ORDER + ", start_date ASC";
        return jdbcTemplate.query(sql, new EducationRowMapper(), userId);
    }

    public List<Education> findAll() {
        String sql = "SELECT * FROM education " +
                    "ORDER BY user_id, " + EDUCATION_LEVEL_ORDER + ", start_date ASC";
        return jdbcTemplate.query(sql, new EducationRowMapper());
    }

    private static class EducationRowMapper implements RowMapper<Education> {
        @Override
        public Education mapRow(ResultSet rs, int rowNum) throws SQLException {
            Education education = new Education();
            education.setEducationId(rs.getLong("education_id"));
            education.setUserId(rs.getLong("user_id"));
            education.setEducationLevel(rs.getString("education_level"));
            education.setSchoolName(rs.getString("school_name"));
            education.setStartDate(rs.getDate("start_date"));
            education.setEndDate(rs.getDate("end_date"));
            education.setMajor(rs.getString("major"));
            education.setClassName(rs.getString("class_name"));
            education.setDescription(rs.getString("description"));
            return education;
        }
    }
} 