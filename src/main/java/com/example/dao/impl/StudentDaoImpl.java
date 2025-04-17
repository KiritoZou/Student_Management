package com.example.dao.impl;

import com.example.dao.StudentDao;
import com.example.model.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Collections;
import java.util.List;
import java.util.Objects;

@Repository
public class StudentDaoImpl implements StudentDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<Student> studentRowMapper = new RowMapper<Student>() {
        @Override
        public Student mapRow(ResultSet rs, int rowNum) throws SQLException {
            Student student = new Student();
            student.setId(String.valueOf(rs.getLong("id")));
            student.setStudentNo(rs.getString("student_no"));
            student.setName(rs.getString("name"));
            student.setGender(rs.getString("gender"));
            student.setAge(rs.getInt("age"));
            student.setGrade(rs.getString("grade"));
            student.setMajor(rs.getString("major"));
            student.setClassName(rs.getString("class_name"));
            student.setPhone(rs.getString("phone"));
            student.setEmail(rs.getString("email"));
            student.setAddress(rs.getString("address"));
            student.setEnrollDate(rs.getDate("enroll_date"));
            student.setStatus(rs.getInt("status"));
            return student;
        }
    };

    @Override
    public List<Student> findAll() {
        try {
            return jdbcTemplate.query("SELECT * FROM students ORDER BY id", studentRowMapper);
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    @Override
    public List<Student> findByPage(int offset, int limit) {
        try {
            return jdbcTemplate.query(
                "SELECT * FROM students ORDER BY id LIMIT ?, ?",
                studentRowMapper,
                offset, limit
            );
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    @Override
    public Student findById(String id) {
        try {
            return jdbcTemplate.queryForObject(
                "SELECT * FROM students WHERE id = ?",
                studentRowMapper,
                Long.parseLong(id)
            );
        } catch (EmptyResultDataAccessException e) {
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public Student findByStudentNo(String studentNo) {
        try {
            return jdbcTemplate.queryForObject(
                "SELECT * FROM students WHERE student_no = ?",
                studentRowMapper,
                studentNo
            );
        } catch (EmptyResultDataAccessException e) {
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public int count() {
        try {
            Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM students", Integer.class);
            return count != null ? count : 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public void insert(Student student) {
        KeyHolder keyHolder = new GeneratedKeyHolder();
        
        try {
            jdbcTemplate.update(connection -> {
                PreparedStatement ps = connection.prepareStatement(
                    "INSERT INTO students (student_no, name, gender, age, grade, major, class_name, phone, email, address, enroll_date, status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS
                );
                ps.setString(1, student.getStudentNo());
                ps.setString(2, student.getName());
                ps.setString(3, student.getGender());
                ps.setInt(4, student.getAge() != null ? student.getAge() : 0);
                ps.setString(5, student.getGrade());
                ps.setString(6, student.getMajor());
                ps.setString(7, student.getClassName());
                ps.setString(8, student.getPhone());
                ps.setString(9, student.getEmail());
                ps.setString(10, student.getAddress());
                
                if (student.getEnrollDate() != null) {
                    ps.setDate(11, new java.sql.Date(student.getEnrollDate().getTime()));
                } else {
                    ps.setNull(11, java.sql.Types.DATE);
                }
                
                ps.setInt(12, student.getStatus() != null ? student.getStatus() : 1);
                return ps;
            }, keyHolder);
            
            if (keyHolder.getKey() != null) {
                student.setId(String.valueOf(keyHolder.getKey().longValue()));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public int update(Student student) {
        try {
            return jdbcTemplate.update(
                "UPDATE students SET student_no = ?, name = ?, gender = ?, age = ?, grade = ?, major = ?, " +
                "class_name = ?, phone = ?, email = ?, address = ?, enroll_date = ?, status = ? WHERE id = ?",
                student.getStudentNo(),
                student.getName(),
                student.getGender(),
                student.getAge(),
                student.getGrade(),
                student.getMajor(),
                student.getClassName(),
                student.getPhone(),
                student.getEmail(),
                student.getAddress(),
                student.getEnrollDate() != null ? new java.sql.Date(student.getEnrollDate().getTime()) : null,
                student.getStatus(),
                Long.parseLong(student.getId())
            );
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int delete(String id) {
        try {
            return jdbcTemplate.update("DELETE FROM students WHERE id = ?", Long.parseLong(id));
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int batchDelete(List<String> ids) {
        if (ids == null || ids.isEmpty()) {
            return 0;
        }
        
        try {
            String placeholders = String.join(",", Collections.nCopies(ids.size(), "?"));
            String sql = "DELETE FROM students WHERE id IN (" + placeholders + ")";
            
            // 转换为Long数组用于数据库查询
            Object[] idArray = ids.stream()
                             .map(Long::parseLong)
                             .toArray();
            
            return jdbcTemplate.update(sql, idArray);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
} 