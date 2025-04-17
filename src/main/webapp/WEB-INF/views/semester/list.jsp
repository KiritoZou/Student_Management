<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>学期管理</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    <style>
        .container {
            margin-top: 30px;
        }
        .btn-margin {
            margin-right: 5px;
        }
        .current-semester {
            background-color: #e8f4f8;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>学期管理</h2>
        
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${successMessage}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>
        
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${param.error}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>
        
        <div class="mb-3">
            <a href="${pageContext.request.contextPath}/semester/add" class="btn btn-primary">添加新学期</a>
            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary">返回主页</a>
        </div>
        
        <table class="table table-striped table-bordered">
            <thead class="thead-dark">
                <tr>
                    <th>ID</th>
                    <th>学期名称</th>
                    <th>开始日期</th>
                    <th>结束日期</th>
                    <th>当前学期</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="semester" items="${semesters}">
                    <tr class="${semester.isCurrent ? 'current-semester' : ''}">
                        <td>${semester.id}</td>
                        <td>${semester.name}</td>
                        <td>${semester.startDate}</td>
                        <td>${semester.endDate}</td>
                        <td>
                            <c:if test="${semester.isCurrent}">
                                <span class="badge badge-success">是</span>
                            </c:if>
                            <c:if test="${!semester.isCurrent}">
                                <span class="badge badge-secondary">否</span>
                            </c:if>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/semester/edit/${semester.id}" class="btn btn-sm btn-primary btn-margin">编辑</a>
                            <a href="${pageContext.request.contextPath}/semester/delete/${semester.id}" class="btn btn-sm btn-danger btn-margin" onclick="return confirm('确定要删除该学期吗？')">删除</a>
                            <c:if test="${!semester.isCurrent}">
                                <a href="${pageContext.request.contextPath}/semester/setCurrent/${semester.id}" class="btn btn-sm btn-success btn-margin" onclick="return confirm('确定要将此学期设为当前学期吗？')">设为当前学期</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 