<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>课程管理</title>
    <style>
        body {
            font-family: 'Microsoft YaHei', sans-serif;
            background-color: #f4f5f7;
            margin: 0;
            padding: 20px;
            color: #333;
        }
        
        .container {
            max-width: 1200px;
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
        
        .actions {
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
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
        }
        
        .btn:hover {
            background-color: #00897b;
        }
        
        .filters {
            display: flex;
            gap: 15px;
            background-color: #e0f2f1;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        
        .filter-item {
            display: flex;
            align-items: center;
        }
        
        .filter-item label {
            margin-right: 8px;
            font-size: 14px;
            color: #00695c;
        }
        
        .filter-item select {
            padding: 6px;
            border-radius: 4px;
            border: 1px solid #b2dfdb;
            background-color: white;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        
        th {
            background-color: #e0f2f1;
            color: #00695c;
            padding: 12px;
            text-align: left;
            font-weight: 600;
        }
        
        td {
            padding: 12px;
            border-bottom: 1px solid #e0e0e0;
        }
        
        tr:hover {
            background-color: #f5f5f5;
        }
        
        .course-actions {
            display: flex;
            gap: 10px;
        }
        
        .course-actions a {
            color: #00796b;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s;
        }
        
        .course-actions a:hover {
            color: #004d40;
            text-decoration: underline;
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
        }
        
        .pagination a {
            display: inline-block;
            padding: 5px 10px;
            background-color: #e0f2f1;
            color: #00796b;
            border-radius: 3px;
            text-decoration: none;
            transition: background-color 0.3s;
        }
        
        .pagination a:hover, .pagination a.active {
            background-color: #00796b;
            color: white;
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
        <h1>课程管理</h1>
        
        <div class="actions">
            <c:if test="${isAdmin}">
                <a href="${pageContext.request.contextPath}/course/add" class="btn">添加课程</a>
            </c:if>
            <div>
                <input type="text" id="searchInput" placeholder="搜索课程名称..." style="padding: 8px; border-radius: 4px; border: 1px solid #ccc; width: 200px;">
                <button class="btn" style="margin-left: 5px;">搜索</button>
            </div>
        </div>
        
        <div class="filters">
            <div class="filter-item">
                <label for="semesterFilter">学期:</label>
                <select id="semesterFilter">
                    <option value="">全部学期</option>
                    <c:forEach items="${semesters}" var="semester">
                        <option value="${semester.id}">${semester.name}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="filter-item">
                <label for="creditFilter">学分:</label>
                <select id="creditFilter">
                    <option value="">全部学分</option>
                    <option value="1">1学分</option>
                    <option value="2">2学分</option>
                    <option value="3">3学分</option>
                    <option value="4">4学分</option>
                    <option value="5">5学分及以上</option>
                </select>
            </div>
        </div>
        
        <table>
            <thead>
                <tr>
                    <th>课程编号</th>
                    <th>课程名称</th>
                    <th>任课教师</th>
                    <th>学分</th>
                    <th>学期</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${courses}" var="course">
                    <tr>
                        <td>${course.id}</td>
                        <td>${course.name}</td>
                        <td>${course.teacherName}</td>
                        <td>${course.credits}</td>
                        <td>${course.semesterName}</td>
                        <td class="course-actions">
                            <a href="${pageContext.request.contextPath}/course/view/${course.id}">查看详情</a>
                            <c:if test="${isAdmin}">
                                <a href="${pageContext.request.contextPath}/course/edit/${course.id}">编辑</a>
                                <a href="#" onclick="if(confirm('确定要删除该课程吗？')) window.location.href='${pageContext.request.contextPath}/course/delete/${course.id}'">删除</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty courses}">
                    <tr>
                        <td colspan="6" style="text-align: center;">暂无课程信息</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
        
        <div class="pagination">
            <a href="#" class="active">1</a>
            <a href="#">2</a>
            <a href="#">3</a>
            <a href="#">&raquo;</a>
        </div>
        
        <a href="${pageContext.request.contextPath}/dashboard" class="back-link">返回仪表盘</a>
    </div>
    
    <script>
        // 简单的客户端筛选功能
        document.addEventListener('DOMContentLoaded', function() {
            const semesterFilter = document.getElementById('semesterFilter');
            const creditFilter = document.getElementById('creditFilter');
            const searchInput = document.getElementById('searchInput');
            
            function applyFilters() {
                const semesterId = semesterFilter.value;
                const creditValue = creditFilter.value;
                const searchText = searchInput.value.toLowerCase();
                
                const rows = document.querySelectorAll('tbody tr');
                
                rows.forEach(row => {
                    const courseName = row.cells[1].textContent.toLowerCase();
                    const courseCredit = row.cells[3].textContent;
                    const courseSemester = row.cells[4].textContent;
                    
                    let showRow = true;
                    
                    if (semesterId && !courseSemester.includes(semesterId)) {
                        showRow = false;
                    }
                    
                    if (creditValue && courseCredit != creditValue) {
                        showRow = false;
                    }
                    
                    if (searchText && !courseName.includes(searchText)) {
                        showRow = false;
                    }
                    
                    row.style.display = showRow ? '' : 'none';
                });
            }
            
            semesterFilter.addEventListener('change', applyFilters);
            creditFilter.addEventListener('change', applyFilters);
            searchInput.addEventListener('input', applyFilters);
        });
    </script>
</body>
</html> 