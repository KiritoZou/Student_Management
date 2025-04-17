<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>添加课程</title>
    <style>
        body {
            font-family: 'Microsoft YaHei', sans-serif;
            background-color: #f4f5f7;
            margin: 0;
            padding: 20px;
            color: #333;
        }
        
        .container {
            max-width: 800px;
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
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
            color: #00695c;
        }
        
        input[type="text"],
        input[type="number"],
        textarea,
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #b2dfdb;
            border-radius: 4px;
            box-sizing: border-box;
            font-family: 'Microsoft YaHei', sans-serif;
            font-size: 14px;
        }
        
        textarea {
            height: 120px;
            resize: vertical;
        }
        
        .form-actions {
            margin-top: 30px;
            display: flex;
            justify-content: flex-end;
            gap: 15px;
        }
        
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #00796b;
            color: white;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .btn:hover {
            background-color: #00897b;
        }
        
        .btn-secondary {
            background-color: #757575;
        }
        
        .btn-secondary:hover {
            background-color: #616161;
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
        
        .error-message {
            color: #d32f2f;
            font-size: 14px;
            margin-top: 5px;
        }
        
        .helper-text {
            color: #757575;
            font-size: 12px;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>添加课程</h1>
        
        <form action="${pageContext.request.contextPath}/course/save" method="post">
            <div class="form-group">
                <label for="id">课程编号</label>
                <input type="text" id="id" name="id" required>
                <div class="helper-text">请输入唯一的课程编号，如：CS101</div>
            </div>
            
            <div class="form-group">
                <label for="name">课程名称</label>
                <input type="text" id="name" name="name" required>
            </div>
            
            <div class="form-group">
                <label for="description">课程描述</label>
                <textarea id="description" name="description" required></textarea>
            </div>
            
            <div class="form-group">
                <label for="credits">学分</label>
                <input type="number" id="credits" name="credits" min="1" max="10" value="3" required>
                <div class="helper-text">请输入1-10之间的整数</div>
            </div>
            
            <div class="form-group">
                <label for="teacherName">任课教师</label>
                <input type="text" id="teacherName" name="teacherName" required>
            </div>
            
            <div class="form-group">
                <label for="semesterId">所属学期</label>
                <select id="semesterId" name="semesterId" required>
                    <option value="">请选择学期</option>
                    <c:forEach items="${semesters}" var="semester">
                        <option value="${semester.id}">${semester.name}</option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="form-actions">
                <a href="${pageContext.request.contextPath}/course/list" class="btn btn-secondary">取消</a>
                <button type="submit" class="btn">保存课程</button>
            </div>
        </form>
        
        <a href="${pageContext.request.contextPath}/course/list" class="back-link">返回课程列表</a>
    </div>
</body>
</html> 