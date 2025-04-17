package com.example.dao.impl;

import com.example.model.User;
import com.example.dao.UserDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;

@Repository
public class UserDAOImpl implements UserDAO {
    
    private final JdbcTemplate jdbcTemplate;
    
    @Autowired
    public UserDAOImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    
    @Override
    public User findByUsernameAndPassword(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new UserRowMapper(), username, password);
        } catch (Exception e) {
            return null;
        }
    }
    
    @Override
    public User findByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new UserRowMapper(), username);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }
    
    @Override
    public boolean existsByUsername(String username) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, username);
        return count != null && count > 0;
    }
    
    @Override
    public void save(User user) {
        String sql = "INSERT INTO users (username, password, real_name, gender, email, status) VALUES (?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(
            sql,
            user.getUsername(),
            user.getPassword(),
            user.getRealName(),
            user.getGender(),
            user.getEmail(),
            user.getStatus()
        );
    }
    
    private static class UserRowMapper implements RowMapper<User> {
        @Override
        public User mapRow(ResultSet rs, int rowNum) throws SQLException {
            User user = new User();
            user.setId(rs.getLong("id"));
            user.setUsername(rs.getString("username"));
            user.setPassword(rs.getString("password"));
            user.setRealName(rs.getString("real_name"));
            user.setEmail(rs.getString("email"));
            
            // 尝试获取可选字段
            try {
                user.setGender(rs.getString("gender"));
            } catch (SQLException e) {
                // 字段不存在，忽略
            }
            
            try {
                user.setStatus(rs.getInt("status"));
            } catch (SQLException e) {
                // 字段不存在，忽略
            }
            
            return user;
        }
    }
} 