<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>学生成绩信息</title>
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
            color: #2196f3;
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
            background-image: linear-gradient(to right, #2196f3, #64b5f6);
        }
        
        .student-info {
            background-color: #e3f2fd;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 4px solid #2196f3;
        }
        
        .student-info p {
            margin: 8px 0;
            font-size: 16px;
        }
        
        .score-semester {
            margin-bottom: 30px;
        }
        
        .semester-title {
            background-color: #2196f3;
            color: white;
            padding: 10px 15px;
            border-radius: 4px;
            font-size: 18px;
            margin-bottom: 15px;
        }
        
        .score-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        
        .score-table th {
            background-color: #e3f2fd;
            color: #2196f3;
            padding: 12px;
            text-align: left;
            font-weight: 600;
            border-bottom: 2px solid #bbdefb;
        }
        
        .score-table td {
            padding: 12px;
            border-bottom: 1px solid #e0e0e0;
        }
        
        .score-table tr:hover {
            background-color: #f5f5f5;
        }
        
        .score-value {
            font-weight: bold;
        }
        
        .semester-gpa {
            text-align: right;
            font-size: 16px;
            color: #555;
            margin: 10px 0;
        }
        
        .semester-gpa span {
            font-weight: bold;
            color: #2196f3;
        }
        
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #2196f3;
            text-decoration: none;
            font-weight: bold;
            font-size: 14px;
            transition: color 0.3s;
        }
        
        .back-link:hover {
            color: #64b5f6;
            text-decoration: underline;
        }
        
        .score-90-100 { color: #4caf50; }
        .score-80-89 { color: #8bc34a; }
        .score-70-79 { color: #ffc107; }
        .score-60-69 { color: #ff9800; }
        .score-below-60 { color: #f44336; }
    </style>
</head>
<body>
    <div class="container">
        <h1>学生成绩信息</h1>
        
        <div class="student-info">
            <p><strong>姓名：</strong>${student.name}</p>
            <p><strong>学号：</strong>${student.id}</p>
            <p><strong>专业：</strong>${student.major}</p>
        </div>
        
        <c:forEach items="${scores}" var="semesterEntry">
            <div class="score-semester">
                <div class="semester-title">${semesterEntry.key}</div>
                
                <table class="score-table">
                    <thead>
                        <tr>
                            <th>课程名称</th>
                            <th>课程编号</th>
                            <th>学分</th>
                            <th>成绩</th>
                            <th>绩点</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${semesterEntry.value.courses}" var="course">
                            <tr>
                                <td>${course.name}</td>
                                <td>${course.code}</td>
                                <td>${course.credit}</td>
                                <td>
                                    <span class="score-value 
                                        <c:choose>
                                            <c:when test="${course.score >= 90}">score-90-100</c:when>
                                            <c:when test="${course.score >= 80}">score-80-89</c:when>
                                            <c:when test="${course.score >= 70}">score-70-79</c:when>
                                            <c:when test="${course.score >= 60}">score-60-69</c:when>
                                            <c:otherwise>score-below-60</c:otherwise>
                                        </c:choose>
                                    ">
                                        ${course.score}
                                    </span>
                                </td>
                                <td>${course.gpa}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <div class="semester-gpa">
                    学期平均绩点: <span>${semesterEntry.value.averageGpa}</span>
                </div>
            </div>
        </c:forEach>
        
        <a href="${pageContext.request.contextPath}/student/list" class="back-link">返回学生列表</a>
    </div>
</body>
</html> 