package com.example.model;

import java.math.BigDecimal;
import java.util.Date;

public class CourseScore {
    private Long id;
    private Long userId;
    private Long courseId;
    private String courseName;
    private Double score;
    private Integer ranking;
    private String semester;
    private Long semesterId;
    private BigDecimal gradePoint;
    private Integer credit;
    private String letterGrade;
    private String teacherComment;
    private Date examDate;
    
    // 关联字段
    private String semesterName;  // 学期名称

    public CourseScore() {
    }
    
    public CourseScore(Long id, Long userId, Long courseId, String courseName, Double score, Integer ranking, String semester) {
        this.id = id;
        this.userId = userId;
        this.courseId = courseId;
        this.courseName = courseName;
        this.score = score;
        this.ranking = ranking;
        this.semester = semester;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getCourseId() {
        return courseId;
    }

    public void setCourseId(Long courseId) {
        this.courseId = courseId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }

    public Integer getRanking() {
        return ranking;
    }

    public void setRanking(Integer ranking) {
        this.ranking = ranking;
    }

    public String getSemester() {
        return semester;
    }

    public void setSemester(String semester) {
        this.semester = semester;
    }

    public Long getSemesterId() {
        return semesterId;
    }

    public void setSemesterId(Long semesterId) {
        this.semesterId = semesterId;
    }

    public BigDecimal getGradePoint() {
        return gradePoint;
    }

    public void setGradePoint(BigDecimal gradePoint) {
        this.gradePoint = gradePoint;
    }

    public Integer getCredit() {
        return credit;
    }

    public void setCredit(Integer credit) {
        this.credit = credit;
    }

    public String getLetterGrade() {
        return letterGrade;
    }

    public String getSemesterName() {
        return semesterName;
    }

    public void setSemesterName(String semesterName) {
        this.semesterName = semesterName;
    }

    public String getTeacherComment() {
        return teacherComment;
    }

    public void setTeacherComment(String teacherComment) {
        this.teacherComment = teacherComment;
    }

    public Date getExamDate() {
        return examDate;
    }

    public void setExamDate(Date examDate) {
        this.examDate = examDate;
    }

    // 根据分数计算等级
    private String calculateLetterGrade(BigDecimal score) {
        if (score == null) return "N/A";
        
        double scoreValue = score.doubleValue();
        if (scoreValue >= 90) return "A";
        if (scoreValue >= 85) return "A-";
        if (scoreValue >= 80) return "B+";
        if (scoreValue >= 75) return "B";
        if (scoreValue >= 70) return "B-";
        if (scoreValue >= 65) return "C+";
        if (scoreValue >= 60) return "C";
        return "F";
    }
} 