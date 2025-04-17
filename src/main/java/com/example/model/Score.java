package com.example.model;

public class Score {
    private Integer id;
    private String studentId;
    private String courseId;
    private Double scoreValue;
    private Double gpa;
    private Integer semesterId;
    private String createTime;
    private String updateTime;
    
    public Score() {
    }
    
    public Score(Integer id, String studentId, String courseId, Double scoreValue, Double gpa, Integer semesterId) {
        this.id = id;
        this.studentId = studentId;
        this.courseId = courseId;
        this.scoreValue = scoreValue;
        this.gpa = gpa;
        this.semesterId = semesterId;
    }
    
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    public String getStudentId() {
        return studentId;
    }
    
    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }
    
    public String getCourseId() {
        return courseId;
    }
    
    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }
    
    public Double getScoreValue() {
        return scoreValue;
    }
    
    public void setScoreValue(Double scoreValue) {
        this.scoreValue = scoreValue;
    }
    
    public Double getGpa() {
        return gpa;
    }
    
    public void setGpa(Double gpa) {
        this.gpa = gpa;
    }
    
    public Integer getSemesterId() {
        return semesterId;
    }
    
    public void setSemesterId(Integer semesterId) {
        this.semesterId = semesterId;
    }
    
    public String getCreateTime() {
        return createTime;
    }
    
    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }
    
    public String getUpdateTime() {
        return updateTime;
    }
    
    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime;
    }
} 