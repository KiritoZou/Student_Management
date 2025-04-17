<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>学生信息管理系统 - 学生详情</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- 自定义样式 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/dashboard.css">
    <style>
        .student-info-card {
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        
        .student-header {
            background-color: var(--primary-color);
            color: white;
            padding: 20px;
            position: relative;
        }
        
        .student-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            border: 3px solid white;
            object-fit: cover;
            margin-right: 20px;
        }
        
        .student-name {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 5px;
        }
        
        .student-id {
            font-size: 16px;
            opacity: 0.9;
        }
        
        .info-section {
            padding: 20px;
            border-bottom: 1px solid #eee;
        }
        
        .section-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 15px;
            color: var(--dark-color);
            border-left: 3px solid var(--primary-color);
            padding-left: 10px;
        }
        
        .info-item {
            margin-bottom: 15px;
        }
        
        .info-label {
            font-weight: 500;
            color: var(--gray-600);
        }
        
        .info-value {
            color: var(--gray-800);
        }
        
        .action-buttons {
            padding: 20px;
            background-color: #f8f9fa;
            text-align: right;
        }
    </style>
</head>
<body>
    <!-- 左侧导航栏 -->
    <div class="main-container">
        <nav class="sidebar">
            <div class="sidebar-header">
                <img src="${pageContext.request.contextPath}/static/images/logo.png" alt="Logo" class="sidebar-logo" onerror="this.src='data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI0MCIgaGVpZ2h0PSI0MCIgdmlld0JveD0iMCAwIDI0IDI0IiBmaWxsPSJub25lIiBzdHJva2U9IiMwMDQ3QUIiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIj48cGF0aCBkPSJNMiAzaDIwdjE0YzAgMS4xLS45IDItMiAySDRjLTEuMSAwLTItLjktMi0yVjN6Ii8+PHBhdGggZD0iTTggMjFWMTloOHYyIi8+PHBhdGggZD0iTTEyIDdoLjAxIi8+PC9zdmc+'">
                <span class="sidebar-title">学生信息管理</span>
            </div>
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/dashboard" class="nav-link">
                        <i class="bi bi-speedometer2 nav-icon"></i>
                        <span class="nav-text">仪表盘</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/student/list" class="nav-link active">
                        <i class="bi bi-people-fill nav-icon"></i>
                        <span class="nav-text">学生管理</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/course/list" class="nav-link">
                        <i class="bi bi-book nav-icon"></i>
                        <span class="nav-text">课程管理</span>
                    </a>
                </li>
            </ul>
        </nav>
        <main>
            <div class="student-info-card">
                <div class="student-header">
                    <img src="${pageContext.request.contextPath}/static/images/avatar.png" alt="Avatar" class="student-avatar">
                    <div>
                        <h1 class="student-name">${student.name}</h1>
                        <span class="student-id">学生编号：${student.id}</span>
                    </div>
                </div>
                <div class="info-section">
                    <h2 class="section-title">基本信息</h2>
                    <div class="info-item">
                        <span class="info-label">性别：</span>
                        <span class="info-value">${student.gender}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">年龄：</span>
                        <span class="info-value">${student.age}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">班级：</span>
                        <span class="info-value">${student.class}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">入学时间：</span>
                        <span class="info-value"><fmt:formatDate value="${student.enrollmentDate}" pattern="yyyy-MM-dd"/></span>
                    </div>
                </div>
                <div class="info-section">
                    <h2 class="section-title">联系方式</h2>
                    <div class="info-item">
                        <span class="info-label">电话：</span>
                        <span class="info-value">${student.phone}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">邮箱：</span>
                        <span class="info-value">${student.email}</span>
                    </div>
                </div>
                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/student/edit/${student.id}" class="btn btn-primary">编辑</a>
                    <a href="${pageContext.request.contextPath}/student/delete/${student.id}" class="btn btn-danger">删除</a>
                </div>
            </div>
        </main>
    </div>
</body>
</html> 