<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>CSS测试</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/test.css">
    <style>
        .test-box {
            width: 300px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="test-box">
        <h1>CSS测试页面</h1>
        <p>如果你能看到这段文字背景是灰色的，说明CSS文件加载成功了。</p>
        <p>Context Path: ${pageContext.request.contextPath}</p>
    </div>
</body>
</html> 