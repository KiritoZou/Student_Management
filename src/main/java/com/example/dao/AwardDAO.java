package com.example.dao;

import com.example.model.Award;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class AwardDAO {
    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public AwardDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Award> findByUserId(Long userId) {
        String sql = "SELECT a.*, at.type_name, al.level_name " +
                     "FROM awards a " +
                     "JOIN award_types at ON a.type_id = at.type_id " +
                     "JOIN award_levels al ON a.level_id = al.level_id " +
                     "WHERE a.user_id = ? " +
                     "ORDER BY a.award_date DESC";
        
        return jdbcTemplate.query(sql, new AwardRowMapper(), userId);
    }

    // 添加 RowMapper 内部类
    private static class AwardRowMapper implements RowMapper<Award> {
        @Override
        public Award mapRow(ResultSet rs, int rowNum) throws SQLException {
            Award award = new Award();
            award.setAwardId(rs.getLong("award_id"));
            award.setUserId(rs.getLong("user_id"));
            award.setAwardName(rs.getString("award_name"));
            award.setTypeId(rs.getInt("type_id"));
            award.setLevelId(rs.getInt("level_id"));
            award.setAwardDate(rs.getDate("award_date"));
            award.setOrganization(rs.getString("organization"));
            award.setCertificateNo(rs.getString("certificate_no"));
            award.setDescription(rs.getString("description"));
            award.setTypeName(rs.getString("type_name"));
            award.setLevelName(rs.getString("level_name"));
            return award;
        }
    }
} 