<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>注册审核中 - 学生信息管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        body {
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Microsoft YaHei', 'Segoe UI', sans-serif;
            background: #ff6b6b;
            position: relative;
            overflow: hidden;
        }

        /* 像素风格背景 */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: 
                linear-gradient(45deg, #ff6b6b 25%, transparent 25%) -50px 0,
                linear-gradient(-45deg, #ff6b6b 25%, transparent 25%) -50px 0,
                linear-gradient(45deg, transparent 75%, #ff6b6b 75%),
                linear-gradient(-45deg, transparent 75%, #ff6b6b 75%);
            background-size: 100px 100px;
            background-color: #fa5252;
            opacity: 0.1;
            z-index: -1;
            animation: slide 20s linear infinite;
        }

        @keyframes slide {
            0% {
                background-position: 0 0;
            }
            100% {
                background-position: 100px 100px;
            }
        }

        .pending-container {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            text-align: center;
            max-width: 500px;
            width: 90%;
            position: relative;
            z-index: 1;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .pending-icon {
            width: 100px;
            height: 100px;
            margin: 0 auto 30px;
            background: #ff6b6b;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% {
                transform: scale(1);
                box-shadow: 0 0 0 0 rgba(255, 107, 107, 0.4);
            }
            70% {
                transform: scale(1.05);
                box-shadow: 0 0 0 20px rgba(255, 107, 107, 0);
            }
            100% {
                transform: scale(1);
                box-shadow: 0 0 0 0 rgba(255, 107, 107, 0);
            }
        }

        .pending-icon svg {
            width: 50px;
            height: 50px;
            fill: none;
            stroke: white;
            stroke-width: 2;
            stroke-linecap: round;
            stroke-linejoin: round;
        }

        h1 {
            color: #343a40;
            font-size: 28px;
            margin-bottom: 20px;
            font-weight: 600;
        }

        p {
            color: #666;
            font-size: 16px;
            line-height: 1.6;
            margin-bottom: 30px;
        }

        .back-button {
            display: inline-block;
            padding: 12px 30px;
            background: linear-gradient(135deg, #ff6b6b, #ff8787);
            color: white;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .back-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
        }

        /* 像素艺术装饰元素 */
        .pixel-decoration {
            position: absolute;
            width: 20px;
            height: 20px;
            background: rgba(255, 255, 255, 0.1);
            z-index: 0;
        }

        .pixel-1 { top: 20%; left: 10%; animation: float 6s infinite; }
        .pixel-2 { top: 70%; right: 15%; animation: float 8s infinite; }
        .pixel-3 { bottom: 15%; left: 20%; animation: float 7s infinite; }
        .pixel-4 { top: 40%; right: 25%; animation: float 5s infinite; }

        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(10deg); }
        }
    </style>
</head>
<body>
    <!-- 像素装饰元素 -->
    <div class="pixel-decoration pixel-1"></div>
    <div class="pixel-decoration pixel-2"></div>
    <div class="pixel-decoration pixel-3"></div>
    <div class="pixel-decoration pixel-4"></div>

    <div class="pending-container">
        <div class="pending-icon">
            <svg viewBox="0 0 24 24">
                <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm-1-13h2v6h-2zm0 8h2v2h-2z"></path>
            </svg>
        </div>
        <h1>注册申请已提交</h1>
        <p>您的注册申请已成功提交！我们的管理员将尽快审核您的申请。<br>审核通过后，您将收到通知并可以使用账号登录系统。</p>
        <a href="${pageContext.request.contextPath}/login" class="back-button">返回登录页面</a>
    </div>
</body>
</html> 