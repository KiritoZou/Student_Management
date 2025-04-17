<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>页面未找到</title>
    <style>
        body {
            font-family: 'Microsoft YaHei', sans-serif;
            text-align: center;
            padding: 40px;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            color: #333;
            height: 100vh;
            margin: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .error-container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            max-width: 600px;
            width: 100%;
        }
        h1 {
            color: #3498db;
            margin-bottom: 20px;
        }
        p {
            margin-bottom: 20px;
            line-height: 1.6;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #3f51b5;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #303f9f;
        }
        .error-code {
            font-size: 80px;
            font-weight: bold;
            color: #3498db;
            margin: 0;
            line-height: 1;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-code">404</div>
        <h1>页面未找到</h1>
        <p>抱歉，您请求的页面不存在或已被移除。</p>
        <p>请检查您输入的URL是否正确，或使用下面的链接返回首页。</p>
        
        <p>
            <a href="${pageContext.request.contextPath}/" class="btn">返回首页</a>
        </p>
    </div>
</body>
</html> 