<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>教育管理信息系统 - 用户登录</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        .login-container {
            max-width: 450px;
            width: 90%;
            padding: 50px;
        }
        
        .login-container h2 {
            font-size: 38px;
            margin-bottom: 35px;
        }
        
        .form-group input {
            padding: 16px 18px;
            font-size: 17px;
        }
        
        .form-group button {
            padding: 18px;
            font-size: 20px;
            margin-top: 10px;
        }
        
        .login-help {
            margin-top: 25px;
            text-align: center;
            color: #555;
            font-size: 14px;
        }
        
        .login-help p {
            margin-bottom: 5px;
        }
        
        .login-help strong {
            color: #1E90FF;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>用户登录</h2>
        <c:if test="${not empty error}">
            <div class="error-message">
                ${error}
            </div>
        </c:if>
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label for="username">用户名：</label>
                <input type="text" id="username" name="username" required placeholder="请输入用户名">
            </div>
            <div class="form-group">
                <label for="password">密码：</label>
                <input type="password" id="password" name="password" required placeholder="请输入密码">
            </div>
            <div class="form-group">
                <button type="submit">登录系统</button>
            </div>
            <div class="form-group">
                <a href="${pageContext.request.contextPath}/register">还没有账号？立即注册</a>
            </div>
        </form>
        
        <div class="login-help">
            <p>管理员账号：<strong>root</strong></p>
            <p>默认密码：<strong>zby2766485803</strong></p>
        </div>
    </div>
</body>
</html>