<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>教育管理信息系统 - 学生信息管理系统</title>
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: 'Microsoft YaHei', Arial, sans-serif;
        }
        
        body {
            /* 使用CSS渐变创建蓝天主题背景 */
            background: linear-gradient(135deg, #1e90ff, #87ceeb, #4169e1, #00bfff);
            background-size: 400% 400%;
            animation: gradient 15s ease infinite;
            display: flex;
            flex-direction: column;
            position: relative;
            overflow: hidden;
        }
        
        /* 添加飞机云朵装饰元素 */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: 
                radial-gradient(circle at 20% 30%, rgba(255, 255, 255, 0.4) 0%, rgba(255, 255, 255, 0) 10%),
                radial-gradient(circle at 70% 60%, rgba(255, 255, 255, 0.4) 0%, rgba(255, 255, 255, 0) 12%),
                radial-gradient(circle at 40% 80%, rgba(255, 255, 255, 0.4) 0%, rgba(255, 255, 255, 0) 15%);
            z-index: 0;
        }

        /* 背景动画 */
        @keyframes gradient {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        
        .header {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 10px 20px;
            display: flex;
            align-items: center;
            position: relative;
            z-index: 1;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .logo {
            height: 50px;
            margin-right: 10px;
        }
        
        .header-text {
            color: #0047AB; /* 航空蓝 */
            border-left: 1px solid #ccc;
            padding-left: 20px;
            font-size: 20px;
            font-weight: bold;
        }
        
        .content {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            height: 100%;
            padding-right: 5%;
            position: relative;
            z-index: 1;
        }
        
        .login-box {
            background-color: rgba(255, 255, 255, 0.95);
            width: 360px;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .login-tabs {
            display: flex;
            margin-bottom: 20px;
            border-bottom: 1px solid #e0e0e0;
        }
        
        .login-tab {
            flex: 1;
            text-align: center;
            padding: 10px 0;
            cursor: pointer;
            position: relative;
            font-weight: bold;
            transition: color 0.3s;
        }
        
        .login-tab.active {
            color: #0047AB; /* 航空蓝 */
        }
        
        .login-tab.active::after {
            content: '';
            display: block;
            position: absolute;
            bottom: -1px;
            left: 0;
            width: 100%;
            height: 2px;
            background-color: #0047AB; /* 航空蓝 */
        }
        
        .input-group {
            position: relative;
            margin-bottom: 20px;
        }
        
        .input-group input {
            width: 100%;
            padding: 12px 12px 12px 40px;
            border: 1px solid #e0e0e0;
            border-radius: 6px;
            font-size: 14px;
            box-sizing: border-box;
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        
        .input-group input:focus {
            border-color: #0047AB;
            box-shadow: 0 0 0 2px rgba(0, 71, 171, 0.2);
            outline: none;
        }
        
        .input-group i {
            position: absolute;
            left: 15px;
            top: 14px;
            color: #aaa;
        }
        
        .remember-me {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            font-size: 14px;
            color: #555;
        }
        
        .remember-me input {
            margin-right: 5px;
        }
        
        .forgot-password {
            float: right;
            font-size: 14px;
            color: #0047AB;
            text-decoration: none;
        }
        
        .forgot-password:hover {
            text-decoration: underline;
        }
        
        .login-button {
            width: 100%;
            padding: 12px 0;
            background-color: #0047AB; /* 航空蓝 */
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
            box-shadow: 0 4px 8px rgba(0, 71, 171, 0.2);
        }
        
        .login-button:hover {
            background-color: #003d99;
        }
        
        .back-home {
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
            color: #555;
        }
        
        .back-home a {
            color: #0047AB;
            text-decoration: none;
        }
        
        .back-home a:hover {
            text-decoration: underline;
        }
        
        .footer {
            background-color: rgba(0, 0, 0, 0.5);
            color: #fff;
            text-align: center;
            padding: 10px 0;
            font-size: 12px;
            margin-top: auto;
            position: relative;
            z-index: 1;
        }
        
        .error-message {
            color: #e74c3c;
            font-size: 14px;
            margin-bottom: 15px;
            text-align: center;
            background-color: rgba(231, 76, 60, 0.1);
            padding: 8px;
            border-radius: 4px;
            border-left: 3px solid #e74c3c;
        }
        
        /* 添加飞机动画 */
        .plane {
            position: absolute;
            width: 50px;
            height: 50px;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='white'%3E%3Cpath d='M22,16.5L10.5,13L2,17.5L22,16.5z M10,9.5L2,7L10,9.5z M2,17.5L22,11.5L10,7L2,17.5z'/%3E%3C/svg%3E");
            background-size: contain;
            background-repeat: no-repeat;
            left: -50px;
            top: 100px;
            animation: fly 20s linear infinite;
            z-index: 0;
            opacity: 0.6;
        }
        
        @keyframes fly {
            0% { 
                left: -50px; 
                transform: translateY(0);
            }
            50% { 
                transform: translateY(30px);
            }
            100% { 
                left: 100%; 
                transform: translateY(0);
            }
        }

        /* 添加更多动态元素的样式 */
        .decoration-container {
            position: absolute;
            width: 100%;
            height: 100%;
            overflow: hidden;
            pointer-events: none;
            z-index: 0;
        }

        /* 风车样式 */
        .windmill {
            position: absolute;
            bottom: 100px;
            left: 10%;
            width: 60px;
            height: 100px;
        }

        .windmill-pole {
            position: absolute;
            bottom: 0;
            left: 50%;
            width: 8px;
            height: 80px;
            background: #fff;
            transform: translateX(-50%);
        }

        .windmill-head {
            position: absolute;
            top: 0;
            left: 50%;
            width: 60px;
            height: 60px;
            transform: translateX(-50%);
            animation: rotate 8s linear infinite;
        }

        .windmill-blade {
            position: absolute;
            width: 25px;
            height: 8px;
            background: #fff;
            transform-origin: right center;
        }

        .windmill-blade:nth-child(1) { transform: rotate(0deg); }
        .windmill-blade:nth-child(2) { transform: rotate(90deg); }
        .windmill-blade:nth-child(3) { transform: rotate(180deg); }
        .windmill-blade:nth-child(4) { transform: rotate(270deg); }

        @keyframes rotate {
            from { transform: translateX(-50%) rotate(0deg); }
            to { transform: translateX(-50%) rotate(360deg); }
        }

        /* 云朵样式 */
        .cloud {
            position: absolute;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 50px;
            animation: float-cloud linear infinite;
            filter: drop-shadow(0 5px 15px rgba(0, 0, 0, 0.1));
        }

        .cloud::before,
        .cloud::after {
            content: '';
            position: absolute;
            background: inherit;
            border-radius: 50%;
        }

        .cloud-1 {
            width: 120px;
            height: 50px;
            top: 20%;
            animation-duration: 40s;
        }

        .cloud-1::before {
            width: 80px;
            height: 80px;
            top: -30px;
            left: 25px;
        }

        .cloud-1::after {
            width: 60px;
            height: 60px;
            top: -20px;
            right: 25px;
        }

        .cloud-2 {
            width: 80px;
            height: 35px;
            top: 35%;
            animation-duration: 30s;
        }

        .cloud-2::before {
            width: 50px;
            height: 50px;
            top: -20px;
            left: 15px;
        }

        .cloud-2::after {
            width: 40px;
            height: 40px;
            top: -15px;
            right: 15px;
        }

        @keyframes float-cloud {
            from { left: -200px; }
            to { left: 100%; }
        }

        /* 校园元素 */
        .book {
            position: absolute;
            width: 40px;
            height: 50px;
            background: #fff;
            border-radius: 5px;
            bottom: 150px;
            right: 15%;
            transform-origin: center;
            animation: float-book 3s ease-in-out infinite;
        }

        .book::after {
            content: '';
            position: absolute;
            width: 80%;
            height: 3px;
            background: rgba(0, 0, 0, 0.1);
            left: 10%;
            top: 30%;
            box-shadow: 0 10px 0 rgba(0, 0, 0, 0.1);
        }

        @keyframes float-book {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(5deg); }
        }

        /* 改进飞机动画 */
        .plane {
            position: absolute;
            width: 60px;
            height: 60px;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='white'%3E%3Cpath d='M22,16.5L10.5,13L2,17.5L22,16.5z M10,9.5L2,7L10,9.5z M2,17.5L22,11.5L10,7L2,17.5z'/%3E%3C/svg%3E");
            background-size: contain;
            background-repeat: no-repeat;
            left: -60px;
            animation: fly-plane 15s linear infinite;
            filter: drop-shadow(2px 2px 3px rgba(0, 0, 0, 0.2));
        }

        @keyframes fly-plane {
            0% {
                left: -60px;
                top: 20%;
                transform: translateY(0) rotate(10deg);
            }
            25% {
                transform: translateY(30px) rotate(5deg);
            }
            50% {
                transform: translateY(0) rotate(10deg);
            }
            75% {
                transform: translateY(-30px) rotate(15deg);
            }
            100% {
                left: 100%;
                top: 40%;
                transform: translateY(0) rotate(10deg);
            }
        }

        /* 添加更多动态背景效果 */
        .shooting-star {
            position: absolute;
            width: 100px;
            height: 2px;
            background: linear-gradient(90deg, rgba(255,255,255,0) 0%, rgba(255,255,255,1) 50%, rgba(255,255,255,0) 100%);
            animation: shooting 3s linear infinite;
            opacity: 0;
        }

        .shooting-star:nth-child(1) { animation-delay: 0s; top: 20%; }
        .shooting-star:nth-child(2) { animation-delay: 1s; top: 35%; }
        .shooting-star:nth-child(3) { animation-delay: 2s; top: 50%; }

        @keyframes shooting {
            0% {
                left: -100px;
                opacity: 0;
                transform: rotate(45deg);
            }
            10% {
                opacity: 1;
            }
            20% {
                opacity: 1;
            }
            100% {
                left: 120%;
                opacity: 0;
                transform: rotate(45deg);
            }
        }

        /* 学生小人 */
        .student {
            position: absolute;
            bottom: 50px;
            left: 15%;
            width: 120px;
            height: 180px;
            background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 36'%3E%3Cpath fill='%23333' d='M12 2a5 5 0 1 0 0 10 5 5 0 0 0 0-10zM7 18c-1.1 0-2 .9-2 2v12h14V20c0-1.1-.9-2-2-2H7z'/%3E%3Cpath fill='%234169E1' d='M7 18v14h10V18H7zm5-8a3 3 0 1 0 0-6 3 3 0 0 0 0 6z'/%3E%3C/svg%3E") no-repeat center;
            background-size: contain;
            animation: student-move 10s infinite;
        }

        @keyframes student-move {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-20px); }
        }

        /* 小鸟 */
        .bird {
            position: absolute;
            width: 40px;
            height: 30px;
            background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='white' d='M22 16.92v3.08h-7V4l-2 2-2-2v16H4V9.92L1 12.92l5-5 5 5v7h2v-7l5-5z'/%3E%3C/svg%3E") no-repeat center;
            background-size: contain;
            animation: bird-fly 15s linear infinite;
        }

        .bird-1 { top: 15%; animation-delay: 0s; }
        .bird-2 { top: 25%; animation-delay: -5s; }
        .bird-3 { top: 20%; animation-delay: -10s; }

        @keyframes bird-fly {
            0% {
                left: -40px;
                transform: translateY(0) scale(1);
            }
            50% {
                transform: translateY(30px) scale(0.8);
            }
            100% {
                left: 100%;
                transform: translateY(0) scale(1);
            }
        }

        /* 大型客机 */
        .airplane {
            position: absolute;
            width: 150px;
            height: 100px;
            background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 576 512'%3E%3Cpath fill='white' d='M482.3 192c34.2 0 93.7 29 93.7 64c0 36-59.5 64-93.7 64l-116.6 0L265.2 495.9c-5.7 10-16.3 16.1-27.8 16.1l-56.2 0c-10.6 0-18.3-10.2-15.4-20.4l49-171.6L112 320 68.8 377.6c-3 4-7.8 6.4-12.8 6.4l-42 0c-7.8 0-14-6.3-14-14c0-1.3 .2-2.6 .5-3.9L32 256 .5 145.9c-.4-1.3-.5-2.6-.5-3.9c0-7.8 6.3-14 14-14l42 0c5 0 9.8 2.4 12.8 6.4L112 192l102.9 0-49-171.6C162.9 10.2 170.6 0 181.2 0l56.2 0c11.5 0 22.1 6.2 27.8 16.1L365.7 192l116.6 0z'/%3E%3C/svg%3E") no-repeat center;
            background-size: contain;
            animation: plane-fly 20s linear infinite;
            filter: drop-shadow(3px 3px 5px rgba(0, 0, 0, 0.3));
        }

        .airplane-1 { animation-delay: 0s; }
        .airplane-2 { animation-delay: -10s; transform: scale(0.7); }

        @keyframes plane-fly {
            0% {
                left: -150px;
                top: 30%;
                transform: translateY(0) rotate(5deg);
            }
            25% {
                transform: translateY(50px) rotate(2deg);
            }
            75% {
                transform: translateY(-50px) rotate(8deg);
            }
            100% {
                left: 100%;
                top: 40%;
                transform: translateY(0) rotate(5deg);
            }
        }

        /* 小狗 */
        .dog {
            position: absolute;
            bottom: 30px;
            right: 15%;
            width: 80px;
            height: 60px;
            background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 576 512'%3E%3Cpath fill='white' d='M309.6 158.5L332.7 19.8C334.6 8.4 344.5 0 356.1 0c7.5 0 14.5 3.5 19 9.5L392 32h52.1c12.7 0 24.9 5.1 33.9 14.1L496 64h56c13.3 0 24 10.7 24 24v24c0 44.2-35.8 80-80 80H464 448 426.7l-5.1 30.5-112-64zM416 256.1L416 480c0 17.7-14.3 32-32 32H352c-17.7 0-32-14.3-32-32V364.8c-24 12.3-51.2 19.2-80 19.2s-56-6.9-80-19.2V480c0 17.7-14.3 32-32 32H96c-17.7 0-32-14.3-32-32V249.8c-28.8-10.9-51.4-35.3-59.2-66.5L1 167.8c-4.3-17.1 6.1-34.5 23.3-38.8s34.5 6.1 38.8 23.3l3.9 15.5C70.5 182 83.3 192 98 192h30 16H303.8L416 256.1zM464 80a16 16 0 1 0 -32 0 16 16 0 1 0 32 0z'/%3E%3C/svg%3E") no-repeat center;
            background-size: contain;
            animation: dog-move 8s infinite;
        }

        @keyframes dog-move {
            0%, 100% { transform: translateX(0) scaleX(1); }
            25% { transform: translateX(30px) scaleX(1); }
            50% { transform: translateX(30px) scaleX(-1); }
            75% { transform: translateX(0) scaleX(-1); }
        }

        /* 小猫 */
        .cat {
            position: absolute;
            width: 50px;
            height: 40px;
            background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 576 512'%3E%3Cpath fill='white' d='M320 192h17.1c22.1 38.3 63.5 64 110.9 64c11 0 21.8-1.4 32.2-4.4c-8.9-15.6-13.8-33.3-13.8-51.6c0-61.9 50.1-112 112-112c8.9 0 17.6 1.1 26.1 3.2C537.1 30.1 500.7 0 458 0c-23.3 0-44.8 7.9-61.7 21.1C373.1 7.6 347.5 0 320 0s-53.1 7.6-76.3 21.1C226.8 7.9 205.3 0 182 0c-42.7 0-79.1 30.1-87.4 71.2c8.5-2.1 17.2-3.2 26.1-3.2c61.9 0 112 50.1 112 112c0 18.3-4.9 36-13.8 51.6c10.4 3 21.2 4.4 32.2 4.4c47.4 0 88.8-25.7 110.9-64H320zm-160 32c-35.3 0-64-28.7-64-64c0-35.3 28.7-64 64-64c35.3 0 64 28.7 64 64c0 35.3-28.7 64-64 64zM416 128c35.3 0 64-28.7 64-64c0-35.3-28.7-64-64-64c-35.3 0-64 28.7-64 64c0 35.3 28.7 64 64 64zM128 400c0 8.8-7.2 16-16 16s-16-7.2-16-16c0-53 43-96 96-96h32c53 0 96 43 96 96c0 8.8-7.2 16-16 16s-16-7.2-16-16c0-35.3-28.7-64-64-64H208c-35.3 0-64 28.7-64 64z'/%3E%3C/svg%3E") no-repeat center;
            background-size: contain;
            animation: cat-circle 8s linear infinite;
            filter: drop-shadow(2px 2px 3px rgba(0, 0, 0, 0.2));
            bottom: 40px;
            left: 50%;
            transform-origin: center;
        }

        @keyframes cat-circle {
            0% {
                transform: translate(-50%, 0) rotate(0deg);
            }
            25% {
                transform: translate(-50%, -50px) rotate(90deg);
            }
            50% {
                transform: translate(-50%, -100px) rotate(180deg);
            }
            75% {
                transform: translate(-50%, -50px) rotate(270deg);
            }
            100% {
                transform: translate(-50%, 0) rotate(360deg);
            }
        }

        /* 教学楼 - 使用虚线轮廓 */
        .school-building {
            position: absolute;
            bottom: 80px;
            left: 15%;
            width: 250px;
            height: 180px;
            background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 250 180'%3E%3Cpath fill='none' stroke='rgba(255, 255, 255, 0.6)' stroke-width='2' stroke-dasharray='5,5' d='M10 180h230v-150H10v150zM30 160h190v-110H30v110zM50 140h150v-70H50v70z'/%3E%3Ctext x='125' y='95' font-family='Arial' font-size='20' fill='rgba(255, 255, 255, 0.8)' text-anchor='middle'%3E计算机学院%3C/text%3E%3C/svg%3E") no-repeat center;
            background-size: contain;
        }

        /* 飞机编队 */
        .airplane-formation {
            position: absolute;
            top: 30%;
            left: -200px;
            animation: fly-formation 25s linear infinite;
            z-index: 1;
        }

        .airplane {
            position: absolute;
            width: 60px;
            height: 40px;
            background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 576 512'%3E%3Cpath fill='white' d='M482.3 192c34.2 0 93.7 29 93.7 64c0 36-59.5 64-93.7 64l-116.6 0L265.2 495.9c-5.7 10-16.3 16.1-27.8 16.1l-56.2 0c-10.6 0-18.3-10.2-15.4-20.4l49-171.6L112 320 68.8 377.6c-3 4-7.8 6.4-12.8 6.4l-42 0c-7.8 0-14-6.3-14-14c0-1.3 .2-2.6 .5-3.9L32 256 .5 145.9c-.4-1.3-.5-2.6-.5-3.9c0-7.8 6.3-14 14-14l42 0c5 0 9.8 2.4 12.8 6.4L112 192l102.9 0-49-171.6C162.9 10.2 170.6 0 181.2 0l56.2 0c11.5 0 22.1 6.2 27.8 16.1L365.7 192l116.6 0z'/%3E%3C/svg%3E") no-repeat center;
            background-size: contain;
            filter: drop-shadow(2px 2px 3px rgba(0, 0, 0, 0.2));
        }

        .airplane-lead {
            top: 0;
            left: 0;
        }

        .airplane-wing1 {
            top: 30px;
            left: -40px;
            transform: scale(0.8);
        }

        .airplane-wing2 {
            top: 30px;
            left: 40px;
            transform: scale(0.8);
        }

        .airplane-tail1 {
            top: 60px;
            left: -20px;
            transform: scale(0.7);
        }

        .airplane-tail2 {
            top: 60px;
            left: 20px;
            transform: scale(0.7);
        }

        @keyframes fly-formation {
            from {
                left: -200px;
                transform: translateY(0);
            }
            to {
                left: 100%;
                transform: translateY(0);
            }
        }

        /* 调整云朵样式和位置 */
        .cloud {
            opacity: 0.9;
            z-index: 2;
        }

        .cloud-1 {
            width: 120px;
            height: 50px;
            top: 15%;
            animation-duration: 40s;
        }

        .cloud-2 {
            width: 80px;
            height: 35px;
            top: 40%;
            animation-duration: 30s;
        }

        /* 草丛和花朵 */
        .nature-elements {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 40px;
            overflow: hidden;
        }

        .grass {
            position: absolute;
            bottom: 0;
            width: 100%;
            height: 30px;
            background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1000 30'%3E%3Cpath fill='rgba(76, 175, 80, 0.3)' d='M0 30 Q 50 10 100 30 Q 150 10 200 30 Q 250 10 300 30 Q 350 10 400 30 Q 450 10 500 30 Q 550 10 600 30 Q 650 10 700 30 Q 750 10 800 30 Q 850 10 900 30 Q 950 10 1000 30 L 1000 30 L 0 30'/%3E%3C/svg%3E") repeat-x;
            background-size: 200px 30px;
        }

        .flowers {
            position: absolute;
            bottom: 5px;
            width: 100%;
            height: 20px;
        }

        .flower {
            position: absolute;
            width: 12px;
            height: 12px;
            background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 12 12'%3E%3Ccircle cx='6' cy='6' r='3' fill='%23FFD700' /%3E%3Ccircle cx='6' cy='2' r='2' fill='white' /%3E%3Ccircle cx='6' cy='10' r='2' fill='white' /%3E%3Ccircle cx='2' cy='6' r='2' fill='white' /%3E%3Ccircle cx='10' cy='6' r='2' fill='white' /%3E%3C/svg%3E") no-repeat center;
            background-size: contain;
            animation: flower-sway 3s ease-in-out infinite;
        }

        .flower:nth-child(1) { left: 5%; animation-delay: -0.2s; }
        .flower:nth-child(2) { left: 15%; animation-delay: -0.9s; }
        .flower:nth-child(3) { left: 25%; animation-delay: -0.5s; }
        .flower:nth-child(4) { left: 85%; animation-delay: -0.7s; }
        .flower:nth-child(5) { left: 95%; animation-delay: -0.3s; }

        @keyframes flower-sway {
            0%, 100% { transform: rotate(-5deg); }
            50% { transform: rotate(5deg); }
        }

        /* 波浪效果 */
        .waves {
            position: absolute;
            bottom: 30px;
            left: 0;
            right: 0;
            height: 100px;
            z-index: 1;
            overflow: hidden;
        }

        .wave {
            position: absolute;
            width: 200%;
            height: 100%;
            background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1440 100'%3E%3Cpath fill='rgba(255, 255, 255, 0.15)' d='M0,50 C320,80 420,20 640,50 C860,80 960,20 1280,50 L1440,50 L1440,100 L0,100 Z'/%3E%3C/svg%3E") repeat-x;
            background-size: 50% 100%;
            background-position: 0 0;
            transform-origin: center bottom;
        }

        .wave-1 {
            animation: wave 12s linear infinite;
            opacity: 0.3;
        }

        .wave-2 {
            animation: wave 8s linear infinite;
            opacity: 0.2;
        }

        .wave-3 {
            animation: wave 6s linear infinite;
            opacity: 0.1;
        }

        @keyframes wave {
            0% { transform: translateX(0) scaleY(1); }
            50% { transform: translateX(-25%) scaleY(0.95); }
            100% { transform: translateX(-50%) scaleY(1); }
        }

        /* 调整飞机编队层级和位置 */
        .airplane-formation {
            position: absolute;
            top: 35%;
            left: -200px;
            animation: fly-formation 25s linear infinite;
            z-index: 2;
        }

        /* 调整云朵层级 */
        .cloud {
            opacity: 0.9;
            z-index: 3;
        }

        /* 调整花朵和草丛 */
        .nature-elements {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 40px;
            overflow: hidden;
            z-index: 4;
        }

        .grass {
            position: absolute;
            bottom: 0;
            width: 100%;
            height: 30px;
            background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1000 30'%3E%3Cpath fill='rgba(76, 175, 80, 0.3)' d='M0 30 Q 50 10 100 30 Q 150 10 200 30 Q 250 10 300 30 Q 350 10 400 30 Q 450 10 500 30 Q 550 10 600 30 Q 650 10 700 30 Q 750 10 800 30 Q 850 10 900 30 Q 950 10 1000 30 L 1000 30 L 0 30'/%3E%3C/svg%3E") repeat-x;
            background-size: 200px 30px;
        }
    </style>
</head>
<body>
    <!-- 添加装饰元素容器 -->
    <div class="decoration-container">
        <!-- 波浪 -->
        <div class="waves">
            <div class="wave wave-1"></div>
            <div class="wave wave-2"></div>
            <div class="wave wave-3"></div>
        </div>

        <!-- 飞机编队 -->
        <div class="airplane-formation">
            <div class="airplane airplane-lead"></div>
            <div class="airplane airplane-wing1"></div>
            <div class="airplane airplane-wing2"></div>
            <div class="airplane airplane-tail1"></div>
            <div class="airplane airplane-tail2"></div>
        </div>

        <!-- 云朵 -->
        <div class="cloud cloud-1"></div>
        <div class="cloud cloud-2"></div>

        <!-- 自然元素 -->
        <div class="nature-elements">
            <div class="grass"></div>
            <div class="flowers">
                <div class="flower"></div>
                <div class="flower"></div>
                <div class="flower"></div>
                <div class="flower"></div>
                <div class="flower"></div>
            </div>
        </div>
    </div>
    
    <div class="header">
        <img src="${pageContext.request.contextPath}/static/images/logo.png" alt="学校Logo" class="logo" onerror="this.src='data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MCIgaGVpZ2h0PSI1MCIgdmlld0JveD0iMCAwIDI0IDI0IiBmaWxsPSJub25lIiBzdHJva2U9IiMzMzMiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIj48cGF0aCBkPSJNMiAzaDIwdjE0YzAgMS4xLS45IDItMiAySDRjLTEuMSAwLTItLjktMi0yVjN6Ii8+PHBhdGggZD0iTTggMjFWMTloOHYyIi8+PHBhdGggZD0iTTEyIDdoLjAxIi8+PC9zdmc+'">
        <div class="header-text">学生信息管理系统</div>
    </div>
    
    <div class="content">
        <div class="login-box">
            <div class="login-tabs">
                <div class="login-tab active" data-tab="login">账号登录</div>
                <div class="login-tab" data-tab="register">注册账号</div>
            </div>
            
            <c:if test="${not empty param.error}">
                <div class="error-message">
                    ${param.error}
                </div>
            </c:if>
            
            <!-- 账号登录表单 -->
            <form action="${pageContext.request.contextPath}/login" method="post" id="loginForm" class="tab-content active">
                <div class="input-group">
                    <i>
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                            <circle cx="12" cy="7" r="4"></circle>
                        </svg>
                    </i>
                    <input type="text" name="username" placeholder="学号/工号" required>
                </div>
                
                <div class="input-group">
                    <i>
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                            <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                        </svg>
                    </i>
                    <input type="password" name="password" placeholder="密码" required>
                </div>
                
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                    <div class="remember-me">
                        <input type="checkbox" id="remember" name="remember">
                        <label for="remember">记住我</label>
                    </div>
                    <a href="#" class="forgot-password">忘记密码?</a>
                </div>
                
                <button type="submit" class="login-button">登录</button>
            </form>

            <!-- 注册账号表单 -->
            <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm" class="tab-content" style="display: none;">
                <div class="input-group">
                    <i>
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                            <circle cx="12" cy="7" r="4"></circle>
                        </svg>
                    </i>
                    <input type="text" name="username" placeholder="请输入用户名" required>
                </div>
                
                <div class="input-group">
                    <i>
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                            <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                        </svg>
                    </i>
                    <input type="password" name="password" placeholder="请输入密码" required>
                </div>

                <div class="input-group">
                    <i>
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                            <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                        </svg>
                    </i>
                    <input type="password" name="confirmPassword" placeholder="请确认密码" required>
                </div>

                <div class="input-group">
                    <i>
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M21 2l-2 2m-7.61 7.61a5.5 5.5 0 1 1-7.778 7.778 5.5 5.5 0 0 1 7.777-7.777zm0 0L15.5 7.5m0 0l3 3L22 7l-3-3m-3.5 3.5L19 4"></path>
                        </svg>
                    </i>
                    <input type="text" name="inviteCode" placeholder="请输入邀请码" required>
                </div>
                
                <button type="submit" class="login-button">注册</button>
            </form>
            
            <div class="back-home">
                <a href="${pageContext.request.contextPath}/">返回首页</a> | <a href="#">帮助中心</a>
            </div>
        </div>
    </div>
    
    <div class="footer">
        © 20220511195 学生信息管理系统 版权归邹某所有
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var tabs = document.querySelectorAll('.login-tab');
            var loginForm = document.getElementById('loginForm');
            var registerForm = document.getElementById('registerForm');
            
            tabs.forEach(function(tab) {
                tab.addEventListener('click', function() {
                    // 移除所有标签的active类
                    tabs.forEach(function(t) {
                        t.classList.remove('active');
                    });
                    
                    // 添加当前标签的active类
                    this.classList.add('active');
                    
                    // 切换表单显示
                    if(this.getAttribute('data-tab') === 'login') {
                        loginForm.style.display = 'block';
                        registerForm.style.display = 'none';
                    } else {
                        loginForm.style.display = 'none';
                        registerForm.style.display = 'block';
                    }
                });
            });
        });
    </script>
</body>
</html>