<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>课程详情</title>
    <style>
        body {
            font-family: 'Microsoft YaHei', sans-serif;
            background-color: #f4f5f7;
            margin: 0;
            padding: 20px;
            color: #333;
        }
        
        .container {
            max-width: 900px;
            margin: 0 auto;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        
        h1 {
            color: #00796b;
            text-align: center;
            margin-bottom: 30px;
            font-size: 24px;
            position: relative;
            padding-bottom: 10px;
        }
        
        h1::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 3px;
            background-image: linear-gradient(to right, #00796b, #4db6ac);
        }
        
        .course-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            background-color: #e0f2f1;
            padding: 15px 20px;
            border-radius: 8px;
            border-left: 5px solid #00796b;
        }
        
        .course-title {
            font-size: 20px;
            font-weight: bold;
            color: #00695c;
        }
        
        .course-code {
            color: #00796b;
            font-size: 16px;
            font-weight: 500;
        }
        
        .course-info {
            margin-bottom: 25px;
        }
        
        .info-section {
            margin-bottom: 20px;
        }
        
        .section-title {
            font-size: 18px;
            font-weight: bold;
            color: #00796b;
            margin-bottom: 10px;
            padding-bottom: 8px;
            border-bottom: 1px solid #b2dfdb;
        }
        
        .info-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-bottom: 10px;
        }
        
        .info-item {
            display: flex;
            align-items: baseline;
        }
        
        .info-label {
            font-weight: bold;
            color: #00695c;
            width: 80px;
            flex-shrink: 0;
        }
        
        .info-value {
            flex: 1;
        }
        
        .course-description {
            background-color: #f5f5f5;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 25px;
            line-height: 1.6;
        }
        
        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 25px;
        }
        
        .btn {
            display: inline-block;
            padding: 8px 16px;
            background-color: #00796b;
            color: white;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s;
            text-align: center;
        }
        
        .btn:hover {
            background-color: #00897b;
        }
        
        .btn-secondary {
            background-color: #546e7a;
        }
        
        .btn-secondary:hover {
            background-color: #37474f;
        }
        
        .btn-danger {
            background-color: #e53935;
        }
        
        .btn-danger:hover {
            background-color: #c62828;
        }
        
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #00796b;
            text-decoration: none;
            font-weight: bold;
            font-size: 14px;
            transition: color 0.3s;
        }
        
        .back-link:hover {
            color: #004d40;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>课程详情</h1>
        
        <div class="course-header">
            <div>
                <div class="course-title">${course.name}</div>
                <div class="course-code">课程编号: ${course.id}</div>
            </div>
            <div>
                <span class="btn" style="cursor: default; background-color: #4db6ac;">${course.credits} 学分</span>
            </div>
        </div>
        
        <div class="course-info">
            <div class="info-section">
                <div class="section-title">基本信息</div>
                <div class="info-row">
                    <div class="info-item">
                        <span class="info-label">任课教师:</span>
                        <span class="info-value">${course.teacherName}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">所属学期:</span>
                        <span class="info-value">${course.semesterName}</span>
                    </div>
                </div>
                <div class="info-row">
                    <div class="info-item">
                        <span class="info-label">课程类型:</span>
                        <span class="info-value">专业必修课</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">学时:</span>
                        <span class="info-value">${course.credits * 16} 学时</span>
                    </div>
                </div>
            </div>
            
            <div class="info-section">
                <div class="section-title">课程描述</div>
                <div class="course-description">
                    ${course.description}
                </div>
            </div>
            
            <div class="info-section">
                <div class="section-title">教学安排</div>
                <div class="info-row">
                    <div class="info-item">
                        <span class="info-label">上课时间:</span>
                        <span class="info-value">周一 08:00-09:40</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">上课地点:</span>
                        <span class="info-value">教学楼A201</span>
                    </div>
                </div>
                <div class="info-row">
                    <div class="info-item">
                        <span class="info-label">考核方式:</span>
                        <span class="info-value">考试</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">考试时间:</span>
                        <span class="info-value">待定</span>
                    </div>
                </div>
            </div>
        </div>
        
        <c:if test="${isAdmin}">
            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/course/edit/${course.id}" class="btn">编辑课程</a>
                <a href="${pageContext.request.contextPath}/course/students/${course.id}" class="btn btn-secondary">学生名单</a>
                <a href="#" onclick="if(confirm('确定要删除该课程吗？')) window.location.href='${pageContext.request.contextPath}/course/delete/${course.id}'" class="btn btn-danger">删除课程</a>
            </div>
        </c:if>
        
        <a href="${pageContext.request.contextPath}/course/list" class="back-link">返回课程列表</a>
    </div>
</body>
</html> 