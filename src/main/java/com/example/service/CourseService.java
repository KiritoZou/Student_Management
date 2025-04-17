package com.example.service;

import com.example.model.Course;
import com.example.model.CourseScore;
import java.util.List;

public interface CourseService {
    List<CourseScore> getScoresByUserId(Long userId);
    List<Course> getCoursesByUserId(Long userId);
} 