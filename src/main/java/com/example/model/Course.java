package com.example.model;

public class Course {
    private String id;
    private String name;
    private String description;
    private Integer credits;
    private String teacherName;
    private Integer semesterId;
    
    public Course() {
    }
    
    public Course(String id, String name, String description, Integer credits, String teacherName, Integer semesterId) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.credits = credits;
        this.teacherName = teacherName;
        this.semesterId = semesterId;
    }
    
    public String getId() {
        return id;
    }
    
    public void setId(String id) {
        this.id = id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public Integer getCredits() {
        return credits;
    }
    
    public void setCredits(Integer credits) {
        this.credits = credits;
    }
    
    public String getTeacherName() {
        return teacherName;
    }
    
    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }
    
    public Integer getSemesterId() {
        return semesterId;
    }
    
    public void setSemesterId(Integer semesterId) {
        this.semesterId = semesterId;
    }
} 