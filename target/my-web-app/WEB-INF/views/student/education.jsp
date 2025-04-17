<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>学生学历信息</title>
    <style>
        body {
            font-family: 'Microsoft YaHei', sans-serif;
            background-color: #f4f5f7;
            margin: 0;
            padding: 20px;
            color: #333;
        }
        
        .container {
            max-width: 1000px;
            margin: 0 auto;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        
        h1 {
            color: #3f51b5;
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
            background-image: linear-gradient(to right, #3f51b5, #7986cb);
        }
        
        .student-info {
            background-color: #e8eaf6;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 4px solid #3f51b5;
        }
        
        .student-info p {
            margin: 8px 0;
            font-size: 16px;
        }
        
        .education-timeline {
            position: relative;
            padding-left: 30px;
        }
        
        .education-timeline::before {
            content: '';
            position: absolute;
            top: 0;
            bottom: 0;
            left: 15px;
            width: 2px;
            background-color: #3f51b5;
        }
        
        .education-item {
            position: relative;
            margin-bottom: 30px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
        }
        
        .education-item:hover {
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
            transform: translateY(-2px);
        }
        
        .education-item::before {
            content: '';
            position: absolute;
            left: -30px;
            top: 20px;
            width: 16px;
            height: 16px;
            border-radius: 50%;
            background-color: #3f51b5;
            border: 3px solid #e8eaf6;
        }
        
        .education-level {
            font-size: 18px;
            color: #3f51b5;
            margin-bottom: 10px;
            font-weight: bold;
        }
        
        .education-school {
            font-size: 16px;
            color: #555;
            margin-bottom: 8px;
        }
        
        .education-date {
            color: #7986cb;
            font-size: 14px;
            margin-bottom: 8px;
        }
        
        .education-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            margin-top: 15px;
        }
        
        .detail-item {
            font-size: 14px;
            color: #666;
        }
        
        .detail-label {
            font-weight: bold;
            display: inline-block;
            min-width: 60px;
        }
        
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #3f51b5;
            text-decoration: none;
            font-weight: bold;
            font-size: 14px;
            transition: color 0.3s;
        }
        
        .back-link:hover {
            color: #5c6bc0;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>学生学历信息</h1>
        
        <div class="student-info">
            <p><strong>姓名：</strong>${student.name}</p>
            <p><strong>学号：</strong>${student.id}</p>
            <p><strong>专业：</strong>${student.major}</p>
        </div>
        
        <div class="education-timeline">
            <c:forEach items="${educations}" var="education">
                <div class="education-item">
                    <div class="education-level">${education.level}</div>
                    <div class="education-school">${education.school}</div>
                    <div class="education-date">${education.startDate} 至 ${education.endDate}</div>
                    
                    <div class="education-details">
                        <div class="detail-item">
                            <span class="detail-label">专业：</span>
                            <span>${empty education.major ? '无' : education.major}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">班级：</span>
                            <span>${education.className}</span>
                        </div>
                        <div class="detail-item" style="grid-column: span 2;">
                            <span class="detail-label">描述：</span>
                            <span>${education.description}</span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <a href="/student_info" class="back-link">返回学生列表</a>
    </div>
</body>
</html> 