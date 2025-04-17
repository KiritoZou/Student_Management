<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>图片浏览</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #333;
            text-align: center;
        }
        .image-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .image-item {
            border: 1px solid #ddd;
            border-radius: 5px;
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .image-item img {
            width: 100%;
            height: auto;
            display: block;
        }
        .image-caption {
            padding: 10px;
            background-color: #f9f9f9;
            border-top: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>系统截图浏览</h1>
        
        <div class="image-grid">
            <div class="image-item">
                <img src="${pageContext.request.contextPath}/static/images/屏幕截图(80).png" alt="屏幕截图(80)">
                <div class="image-caption">屏幕截图(80)</div>
            </div>
            
            <div class="image-item">
                <img src="${pageContext.request.contextPath}/static/images/屏幕截图(81).png" alt="屏幕截图(81)">
                <div class="image-caption">屏幕截图(81)</div>
            </div>
            
            <div class="image-item">
                <img src="${pageContext.request.contextPath}/static/images/屏幕截图(82).png" alt="屏幕截图(82)">
                <div class="image-caption">屏幕截图(82)</div>
            </div>
            
            <div class="image-item">
                <img src="${pageContext.request.contextPath}/static/images/屏幕截图(83).png" alt="屏幕截图(83)">
                <div class="image-caption">屏幕截图(83)</div>
            </div>
            
            <div class="image-item">
                <img src="${pageContext.request.contextPath}/static/images/屏幕截图(84).png" alt="屏幕截图(84)">
                <div class="image-caption">屏幕截图(84)</div>
            </div>
            
            <div class="image-item">
                <img src="${pageContext.request.contextPath}/static/images/屏幕截图(85).png" alt="屏幕截图(85)">
                <div class="image-caption">屏幕截图(85)</div>
            </div>
            
            <div class="image-item">
                <img src="${pageContext.request.contextPath}/static/images/屏幕截图(86).png" alt="屏幕截图(86)">
                <div class="image-caption">屏幕截图(86)</div>
            </div>
            
            <div class="image-item">
                <img src="${pageContext.request.contextPath}/static/images/屏幕截图(87).png" alt="屏幕截图(87)">
                <div class="image-caption">屏幕截图(87)</div>
            </div>
            
            <div class="image-item">
                <img src="${pageContext.request.contextPath}/static/images/campus-background.jpg" alt="校园背景">
                <div class="image-caption">校园背景</div>
            </div>
            
            <div class="image-item">
                <img src="${pageContext.request.contextPath}/static/images/boyuan.jpg" alt="头像">
                <div class="image-caption">头像</div>
            </div>
        </div>
    </div>
</body>
</html> 