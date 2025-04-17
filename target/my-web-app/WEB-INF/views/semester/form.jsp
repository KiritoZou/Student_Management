<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${semester.id == null ? '添加学期' : '编辑学期'}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    <style>
        .container {
            margin-top: 30px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .error {
            color: red;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>${semester.id == null ? '添加学期' : '编辑学期'}</h2>
        
        <form:form action="${pageContext.request.contextPath}/semester/${semester.id == null ? 'add' : 'update'}" 
                  method="post" modelAttribute="semester">
            
            <c:if test="${semester.id != null}">
                <form:hidden path="id" />
            </c:if>
            
            <div class="form-group">
                <label for="name">学期名称:</label>
                <form:input path="name" class="form-control" required="true" />
                <form:errors path="name" cssClass="error" />
            </div>
            
            <div class="form-group">
                <label for="startDate">开始日期:</label>
                <form:input path="startDate" type="date" class="form-control" required="true" />
                <form:errors path="startDate" cssClass="error" />
            </div>
            
            <div class="form-group">
                <label for="endDate">结束日期:</label>
                <form:input path="endDate" type="date" class="form-control" required="true" />
                <form:errors path="endDate" cssClass="error" />
            </div>
            
            <div class="form-group form-check">
                <form:checkbox path="isCurrent" class="form-check-input" id="isCurrent" />
                <label class="form-check-label" for="isCurrent">设为当前学期</label>
            </div>
            
            <button type="submit" class="btn btn-primary">${semester.id == null ? '添加' : '更新'}</button>
            <a href="${pageContext.request.contextPath}/semester/list" class="btn btn-secondary">取消</a>
        </form:form>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 