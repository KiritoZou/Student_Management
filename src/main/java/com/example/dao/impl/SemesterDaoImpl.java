package com.example.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.example.dao.SemesterDao;
import com.example.model.Semester;
import com.example.util.DBUtil;

/**
 * 学期数据访问实现类
 */
public class SemesterDaoImpl implements SemesterDao {

    @Override
    public List<Semester> findAll() {
        List<Semester> semesters = new ArrayList<>();
        String sql = "SELECT * FROM semesters ORDER BY start_date DESC";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                semesters.add(extractSemesterFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return semesters;
    }

    @Override
    public Semester findById(Integer id) {
        Semester semester = null;
        String sql = "SELECT * FROM semesters WHERE semester_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    semester = extractSemesterFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return semester;
    }

    @Override
    public void save(Semester semester) {
        String sql = "INSERT INTO semesters (semester_name, start_date, end_date, is_current) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, semester.getSemesterName());
            pstmt.setString(2, semester.getStartDate());
            pstmt.setString(3, semester.getEndDate());
            pstmt.setBoolean(4, semester.getIsCurrent());
            
            if (semester.getIsCurrent()) {
                // 如果是当前学期，则先将其他学期的当前状态设为false
                resetCurrentSemester(conn);
            }
            
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Semester semester) {
        String sql = "UPDATE semesters SET semester_name = ?, start_date = ?, end_date = ?, is_current = ? WHERE semester_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, semester.getSemesterName());
            pstmt.setString(2, semester.getStartDate());
            pstmt.setString(3, semester.getEndDate());
            pstmt.setBoolean(4, semester.getIsCurrent());
            pstmt.setInt(5, semester.getSemesterId());
            
            if (semester.getIsCurrent()) {
                // 如果是当前学期，则先将其他学期的当前状态设为false
                resetCurrentSemester(conn);
            }
            
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(Integer id) {
        String sql = "DELETE FROM semesters WHERE semester_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Semester findCurrentSemester() {
        Semester semester = null;
        String sql = "SELECT * FROM semesters WHERE is_current = true";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                semester = extractSemesterFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return semester;
    }

    @Override
    public void setCurrentSemester(Integer id) {
        try (Connection conn = DBUtil.getConnection()) {
            // 先将所有学期的当前状态设为false
            resetCurrentSemester(conn);
            
            // 将指定ID的学期设为当前学期
            String sql = "UPDATE semesters SET is_current = true WHERE semester_id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, id);
                pstmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    /**
     * 从ResultSet中提取学期信息
     */
    private Semester extractSemesterFromResultSet(ResultSet rs) throws SQLException {
        Semester semester = new Semester();
        semester.setSemesterId(rs.getInt("semester_id"));
        semester.setSemesterName(rs.getString("semester_name"));
        semester.setStartDate(rs.getString("start_date"));
        semester.setEndDate(rs.getString("end_date"));
        semester.setIsCurrent(rs.getBoolean("is_current"));
        semester.setCreatedAt(rs.getTimestamp("created_at"));
        semester.setUpdatedAt(rs.getTimestamp("updated_at"));
        return semester;
    }
    
    /**
     * 重置所有学期的当前状态为false
     */
    private void resetCurrentSemester(Connection conn) throws SQLException {
        String resetSql = "UPDATE semesters SET is_current = false";
        try (Statement stmt = conn.createStatement()) {
            stmt.executeUpdate(resetSql);
        }
    }
} 