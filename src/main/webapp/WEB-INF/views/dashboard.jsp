<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>学生信息管理系统 - 仪表盘</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/dashboard.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/wave.css">
    <style>
        /* 防止修改的特殊样式，通过混淆和复杂选择器增加修改难度 */
        img[src*="boyuan"][data-auth="true"].user-avatar-img,
        img[src$="boyuan.jpg"][data-protected].user-avatar-img,
        .user-profile img[src*="boyuan.jpg"].user-avatar-img {
            pointer-events: none !important;
            user-select: none !important;
            -webkit-user-drag: none !important;
            -webkit-touch-callout: none !important;
        }
        
        /* 基础样式 */
        body {
            min-height: 100vh;
            font-family: 'Microsoft YaHei', 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
            display: block;
            background: linear-gradient(135deg, #f0f4f9 0%, #c3cfe2 100%);
            position: relative;
        }
        
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.2);
            z-index: -1;
        }
        
        .container {
            max-width: 1400px;
            width: 95%;
            margin: 0 auto;
            padding: 15px 0;
        }
        
        .header {
            background: linear-gradient(90deg, #1a365d 0%, #2a4b7c 50%, #1a365d 100%);
            color: white;
            padding: 25px 30px;
            text-align: center;
            margin-bottom: 20px;
            border-radius: 8px;
            width: 100%;
            box-sizing: border-box;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }
        
        .system-title {
            font-size: 2.8rem;
            font-weight: bold;
            margin: 0;
            letter-spacing: 5px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }
        
        .subtitle {
            text-align: center;
            color: rgba(255, 255, 255, 0.9);
            margin-top: 10px;
            font-style: italic;
            font-size: 1.2rem;
            letter-spacing: 2px;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
        }
        
        .content-wrapper {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        
        .sidebar {
            flex: 0 0 220px;
            background-color: white;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.1);
        }
        
        .main-content {
            flex: 1;
            min-width: 300px;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.1);
        }
        
        .user-info {
            text-align: center;
            margin-bottom: 20px;
        }
        
        .avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background-color: #4169E1;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            margin: 0 auto 8px;
            position: relative;
            overflow: hidden;
        }
        
        .avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .user-name {
            font-size: 18px;
            font-weight: bold;
            margin: 10px 0 5px;
        }
        
        .user-id {
            color: #666;
            font-size: 14px;
        }
        
        .menu {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .menu li {
            margin-bottom: 5px;
        }
        
        .menu-item {
            display: block;
            padding: 10px 15px;
            color: #333;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        
        .menu-item:hover, .menu-item.active {
            background-color: #f0f8ff;
            color: #4169E1;
        }
        
        .section {
            margin-bottom: 15px;
        }
        
        .section-title {
            border-left: 4px solid #4169E1;
            padding-left: 10px;
            margin-bottom: 10px;
            font-size: 16px;
            color: #333;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .section-title .more-link {
            font-size: 12px;
            color: #4169E1;
            text-decoration: none;
        }
        
        .table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .table th, .table td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        .table th {
            background-color: #f8f9fa;
            color: #333;
        }
        
        .table tr:hover {
            background-color: #f5f5f5;
        }
        
        .logout-btn {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #e74c3c;
            color: white;
            border: none;
            border-radius: 5px;
            text-align: center;
            cursor: pointer;
            margin-top: 20px;
            text-decoration: none;
        }
        
        .logout-btn:hover {
            background-color: #c0392b;
        }
        
        /* 待办事项样式 */
        .todo-list {
            list-style: none;
            padding: 0;
        }
        
        .todo-item {
            padding: 10px;
            border-bottom: 1px solid #eee;
            display: flex;
            align-items: center;
        }
        
        .todo-checkbox {
            margin-right: 10px;
            transform: scale(0.9);
        }
        
        .todo-content {
            flex: 1;
        }
        
        .todo-title {
            font-weight: bold;
            margin-bottom: 3px;
            font-size: 14px;
        }
        
        .todo-date {
            font-size: 12px;
            color: #777;
        }
        
        .todo-meta {
            font-size: 12px;
            color: #555;
            margin-top: 2px;
        }
        
        .todo-priority {
            padding: 3px 8px;
            border-radius: 3px;
            font-size: 12px;
            margin-left: 10px;
        }
        
        .priority-high {
            background-color: #ffebee;
            color: #d32f2f;
        }
        
        .priority-medium {
            background-color: #fff8e1;
            color: #ff8f00;
        }
        
        .priority-low {
            background-color: #e8f5e9;
            color: #388e3c;
        }
        
        .admin-badge {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 3px;
            font-size: 12px;
            background-color: #1a365d;
            color: white;
            margin-top: 5px;
        }
        
        .student-card {
            padding: 15px;
            border: 1px solid #eee;
            border-radius: 8px;
            margin-bottom: 15px;
            transition: all 0.3s ease;
            background-color: #fff;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            position: relative;
            overflow: hidden;
        }
        
        .student-card::after {
            content: '';
            position: absolute;
            width: 6px;
            top: 0;
            bottom: 0;
            left: 0;
            background: linear-gradient(to bottom, #4a90e2, #63b3ed);
        }
        
        .student-card:hover {
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transform: translateY(-3px);
        }
        
        .student-card .name {
            font-weight: bold;
            font-size: 16px;
            margin-bottom: 8px;
            color: #1a365d;
        }
        
        .student-card .info {
            color: #666;
            font-size: 14px;
            margin-bottom: 5px;
        }
        
        .student-card .links {
            margin-top: 12px;
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }
        
        .student-card .links a {
            margin-right: 10px;
            color: #4169E1;
            text-decoration: none;
            font-size: 13px;
            transition: color 0.3s;
        }
        
        .student-card .links a:hover {
            color: #1a365d;
            text-decoration: underline;
        }
        
        .admin-dashboard-layout {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        @media (max-width: 768px) {
            .admin-dashboard-layout {
                grid-template-columns: 1fr;
            }
        }
        
        .dashboard-card {
            background-color: #f8f9fa;
            border-radius: 8px;
            border: 1px solid #eaeaea;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            transition: box-shadow 0.3s ease;
        }
        
        .dashboard-card:hover {
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        
        .dashboard-card-header {
            padding: 12px 18px;
            border-bottom: 1px solid #eaeaea;
            font-weight: bold;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #f2f5f9;
            border-radius: 8px 8px 0 0;
        }
        
        .dashboard-card-body {
            padding: 15px 18px;
        }
        
        .dashboard-stats {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 25px;
        }
        
        .stat-card {
            background-color: #fff;
            border-radius: 8px;
            padding: 20px 15px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.08);
            text-align: center;
            transition: all 0.3s ease;
            border: 1px solid rgba(0,0,0,0.05);
            display: flex;
            flex-direction: column;
            align-items: center;
            position: relative;
            overflow: hidden;
        }
        
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #4a90e2, #63b3ed);
        }
        
        .stat-card:nth-child(2)::before {
            background: linear-gradient(90deg, #f6ad55, #ed8936);
        }
        
        .stat-card:nth-child(3)::before {
            background: linear-gradient(90deg, #48bb78, #38a169);
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .stat-number {
            font-size: 40px;
            font-weight: bold;
            color: #1a365d;
            margin-bottom: 10px;
            background: linear-gradient(135deg, #1a365d, #4a90e2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .stat-label {
            font-size: 14px;
            color: #555;
            font-weight: 500;
            letter-spacing: 1px;
        }
        
        /* 学生头像样式 */
        .student-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background-color: #e2e8f0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: #4a5568;
            margin: 0 auto 12px;
            flex-shrink: 0;
            overflow: hidden;
            box-shadow: 0 3px 8px rgba(0,0,0,0.1);
        }
        
        .student-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .student-info-wrapper {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            margin-bottom: 12px;
        }
        
        .student-details {
            width: 100%;
        }
    </style>
    <!-- 添加防止修改头像的脚本 -->
    <script>
        // 加密函数 - 简单示例，实际应用可使用更复杂的加密
        function generateSecurityHash() {
            const timestamp = new Date().getTime();
            const salt = "boyuan_special_20220511195";
            return btoa(timestamp + salt).replace(/=/g, '').substring(0, 12);
        }
        
        // 页面加载后锁定头像
        document.addEventListener('DOMContentLoaded', function() {
            lockAvatar();
            
            // 监听DOM变化，防止头像被动态修改
            const observer = new MutationObserver(function(mutations) {
                mutations.forEach(function(mutation) {
                    if (mutation.type === 'childList' || mutation.type === 'attributes') {
                        lockAvatar();
                    }
                });
            });
            
            observer.observe(document.body, {
                childList: true,
                subtree: true,
                attributes: true,
                attributeFilter: ['src']
            });
        });
        
        // 锁定头像函数
        function lockAvatar() {
            const avatarImg = document.querySelector('.user-avatar-img');
            if (avatarImg) {
                const hash = generateSecurityHash();
                
                // 设置特殊属性防止修改
                avatarImg.setAttribute('data-auth', 'true');
                avatarImg.setAttribute('data-protected', hash);
                avatarImg.setAttribute('draggable', 'false');
                
                // 防止右键菜单
                avatarImg.addEventListener('contextmenu', function(e) {
                    e.preventDefault();
                    return false;
                });
                
                // 防止拖拽
                avatarImg.addEventListener('dragstart', function(e) {
                    e.preventDefault();
                    return false;
                });
                
                // 替换被修改的图像
                if (!avatarImg.src.includes('boyuan.jpg')) {
                    avatarImg.src = '${pageContext.request.contextPath}/static/images/boyuan.jpg';
                }
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1 class="system-title">学生信息管理系统</h1>
            <div class="subtitle">知识改变命运 · 勤奋成就未来</div>
        </div>
        
        <div class="content-wrapper">
            <div class="sidebar">
                <div class="user-info">
                    <div class="avatar">
                        <c:choose>
                            <c:when test="${isAdmin}">
                                <img src="${pageContext.request.contextPath}/static/images/boyuan.jpg" alt="管理员头像" class="user-avatar-img">
                            </c:when>
                            <c:otherwise>
                                ${fn:substring(user.realName, 0, 1)}
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="user-name">${user.realName}</div>
                    <c:if test="${isAdmin}">
                        <div class="admin-badge">系统管理员</div>
                    </c:if>
                    <div class="user-id">
                        <c:choose>
                            <c:when test="${isAdmin}">
                                工号: ${user.studentId}
                            </c:when>
                            <c:otherwise>
                                学号: ${user.username}
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                
                <ul class="menu">
                    <li><a href="#" class="menu-item active">个人主页</a></li>
                    <c:if test="${isAdmin}">
                        <li><a href="${pageContext.request.contextPath}/student/list" class="menu-item">学生管理</a></li>
                        <li><a href="${pageContext.request.contextPath}/course/list" class="menu-item">课程管理</a></li>
                        <li><a href="${pageContext.request.contextPath}/student/score/list" class="menu-item">成绩管理</a></li>
                        <li><a href="${pageContext.request.contextPath}/student/award/list" class="menu-item">获奖管理</a></li>
                        <li><a href="#" class="menu-item">系统设置</a></li>
                    </c:if>
                    <c:if test="${!isAdmin}">
                        <li><a href="${pageContext.request.contextPath}/student_info" class="menu-item">学生信息</a></li>
                        <li><a href="${pageContext.request.contextPath}/student/score/view" class="menu-item">课程成绩</a></li>
                        <li><a href="${pageContext.request.contextPath}/student/award/view" class="menu-item">获奖情况</a></li>
                        <li><a href="${pageContext.request.contextPath}/account/settings" class="menu-item">账号设置</a></li>
                    </c:if>
                </ul>
                
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">退出登录</a>
            </div>
            
            <div class="main-content">
                <c:if test="${isAdmin}">
                    <!-- 管理员仪表盘内容 -->
                    <div class="dashboard-stats">
                        <div class="stat-card">
                            <div class="stat-number">156</div>
                            <div class="stat-label">在校学生</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">12</div>
                            <div class="stat-label">待办事项</div>
                        </div>
                    </div>
                    
                    <div class="admin-dashboard-layout">
                        <div class="dashboard-card">
                            <div class="dashboard-card-header">
                                工作待办事项
                                <a href="#" style="font-size: 12px; font-weight: normal; color: #4169E1;">查看全部</a>
                            </div>
                            <div class="dashboard-card-body">
                                <ul class="todo-list">
                                    <c:forEach items="${pendingTasks}" var="task">
                                        <li class="todo-item">
                                            <input type="checkbox" class="todo-checkbox">
                                            <div class="todo-content">
                                                <div class="todo-title">${task.title}</div>
                                                <div class="todo-date">截止时间: ${task.deadline}</div>
                                                <c:if test="${not empty task.course}">
                                                    <div class="todo-meta">课程: ${task.course} | 班级: ${task['class']}</div>
                                                </c:if>
                                                <c:if test="${not empty task.count}">
                                                    <div class="todo-meta">待处理数量: ${task.count}</div>
                                                </c:if>
                                                <c:if test="${not empty task.department}">
                                                    <div class="todo-meta">所属部门: ${task.department}</div>
                                                </c:if>
                                            </div>
                                            <span class="todo-priority priority-${task.priority}">
                                                <c:choose>
                                                    <c:when test="${task.priority eq 'high'}">高优先级</c:when>
                                                    <c:when test="${task.priority eq 'medium'}">中优先级</c:when>
                                                    <c:when test="${task.priority eq 'low'}">低优先级</c:when>
                                                    <c:otherwise>一般</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </li>
                                    </c:forEach>
                                    
                                    <c:if test="${empty pendingTasks}">
                                        <li class="todo-item">
                                            <div class="todo-content text-center">
                                                <div class="todo-title">暂无待办事项</div>
                                            </div>
                                        </li>
                                    </c:if>
                                </ul>
                            </div>
                        </div>
                        
                        <div class="dashboard-card">
                            <div class="dashboard-card-header">
                                近期系统公告
                                <a href="#" style="font-size: 12px; font-weight: normal; color: #4169E1;">管理公告</a>
                            </div>
                            <div class="dashboard-card-body">
                                <div class="announcement">
                                    <h4 style="font-size: 15px; margin-bottom: 5px;">2023年秋季学期即将开始</h4>
                                    <p style="font-size: 12px; color: #666; margin-bottom: 3px;">发布时间: 2023-08-20</p>
                                    <p style="font-size: 13px; margin-bottom: 10px;">请各位教师做好开学前准备工作，完成教学计划制定。</p>
                                </div>
                                
                                <div class="announcement">
                                    <h4 style="font-size: 15px; margin-bottom: 5px;">成绩录入系统升级通知</h4>
                                    <p style="font-size: 12px; color: #666; margin-bottom: 3px;">发布时间: 2023-08-15</p>
                                    <p style="font-size: 13px; margin-bottom: 0;">成绩录入系统将于8月25日进行升级维护，届时系统将暂停使用4小时。</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="dashboard-card">
                        <div class="dashboard-card-header">
                            学生信息一览
                            <a href="${pageContext.request.contextPath}/student/list" style="font-size: 12px; font-weight: normal; color: #4169E1;">查看全部学生</a>
                        </div>
                        <div class="dashboard-card-body">
                            <div class="student-list">
                                <c:forEach items="${students}" var="student">
                                    <div class="student-card">
                                        <div class="student-info-wrapper">
                                            <div class="student-avatar">
                                                <img src="${pageContext.request.contextPath}/static/images/${student.id % 3 == 0 ? '6.jpg' : (student.id % 2 == 0 ? '3.jpg' : '1.jpg')}" alt="${student.name}">
                                            </div>
                                            <div class="student-details">
                                                <div class="name">${student.name}</div>
                                                <div class="info">学号: ${student.studentId} | 专业: ${student.major}</div>
                                                <div class="info">年级: ${student.grade}级 | 平均绩点: ${student.gpa}</div>
                                            </div>
                                        </div>
                                        <div class="links">
                                            <a href="${pageContext.request.contextPath}/student/view/${student.id}">查看详情</a>
                                            <a href="${pageContext.request.contextPath}/student/education/${student.id}">学历信息</a>
                                            <a href="${pageContext.request.contextPath}/student/score/${student.id}">成绩管理</a>
                                            <a href="${pageContext.request.contextPath}/student/award/${student.id}">获奖信息</a>
                                        </div>
                                    </div>
                                </c:forEach>
                                
                                <c:if test="${empty students}">
                                    <div class="student-card">
                                        <div class="info text-center">暂无学生信息</div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${!isAdmin}">
                    <!-- 学生仪表盘内容 -->
                    <div class="section">
                        <h2 class="section-title">待办事项</h2>
                        
                        <ul class="todo-list">
                            <li class="todo-item">
                                <input type="checkbox" class="todo-checkbox">
                                <div class="todo-content">
                                    <div class="todo-title">数据结构期末作业提交</div>
                                    <div class="todo-date">截止时间: 2023-06-30</div>
                                </div>
                                <span class="todo-priority priority-high">高优先级</span>
                            </li>
                            <li class="todo-item">
                                <input type="checkbox" class="todo-checkbox">
                                <div class="todo-content">
                                    <div class="todo-title">计算机网络实验报告</div>
                                    <div class="todo-date">截止时间: 2023-07-05</div>
                                </div>
                                <span class="todo-priority priority-medium">中优先级</span>
                            </li>
                            <li class="todo-item">
                                <input type="checkbox" class="todo-checkbox">
                                <div class="todo-content">
                                    <div class="todo-title">参加创新创业大赛</div>
                                    <div class="todo-date">截止时间: 2023-07-15</div>
                                </div>
                                <span class="todo-priority priority-medium">中优先级</span>
                            </li>
                            <li class="todo-item">
                                <input type="checkbox" class="todo-checkbox">
                                <div class="todo-content">
                                    <div class="todo-title">提交学期总结报告</div>
                                    <div class="todo-date">截止时间: 2023-07-20</div>
                                </div>
                                <span class="todo-priority priority-low">低优先级</span>
                            </li>
                        </ul>
                    </div>
                    
                    <div class="section">
                        <h2 class="section-title">最近课程</h2>
                        
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>课程名称</th>
                                    <th>授课教师</th>
                                    <th>上课时间</th>
                                    <th>上课地点</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>数据结构</td>
                                    <td>张教授</td>
                                    <td>周一 08:00-09:40</td>
                                    <td>信息楼301</td>
                                </tr>
                                <tr>
                                    <td>计算机网络</td>
                                    <td>李教授</td>
                                    <td>周二 10:00-11:40</td>
                                    <td>信息楼205</td>
                                </tr>
                                <tr>
                                    <td>操作系统</td>
                                    <td>王教授</td>
                                    <td>周三 14:00-15:40</td>
                                    <td>信息楼402</td>
                                </tr>
                                <tr>
                                    <td>数据库原理</td>
                                    <td>刘教授</td>
                                    <td>周四 16:00-17:40</td>
                                    <td>信息楼103</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="section">
                        <h2 class="section-title">公告信息</h2>
                        
                        <div class="announcement">
                            <h4>2023年暑期课程安排已发布</h4>
                            <p>发布时间: 2023-06-15</p>
                            <p>请各位同学及时查看暑期课程安排，并做好相关准备工作。详情可在学院网站查看。</p>
                        </div>
                        
                        <div class="announcement">
                            <h4>关于评选优秀学生干部的通知</h4>
                            <p>发布时间: 2023-06-10</p>
                            <p>本学期优秀学生干部评选工作即将开始，请各班级做好相关推荐工作。</p>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <!-- 添加新的页脚 -->
    <div class="footer-wave-container">
        <div class="waves">
            <div class="wave wave1"></div>
            <div class="wave wave2"></div>
            <div class="wave wave3"></div>
        </div>
        <div class="footer-content">
            <p>© 20220511195 学生信息管理系统 版权归邹某所有</p>
        </div>
    </div>

    <script>
        // 可以添加一些交互效果
        document.addEventListener('DOMContentLoaded', function() {
            // 为成绩条添加动画效果
            const scoreFills = document.querySelectorAll('.score-fill');
            scoreFills.forEach(fill => {
                const width = fill.style.width;
                fill.style.width = '0';
                setTimeout(() => {
                    fill.style.width = width;
                }, 100);
            });
        });
    </script>
</body>
</html>