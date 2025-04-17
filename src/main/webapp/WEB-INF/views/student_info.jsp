<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>学生信息管理系统 - 学生信息查看</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            min-height: 100vh;
            padding-bottom: 60px;
        }
        .navbar {
            background-color: #3f51b5;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }
        .navbar-brand {
            font-weight: bold;
            color: white !important;
        }
        .nav-link {
            color: rgba(255, 255, 255, 0.8) !important;
        }
        .nav-link:hover {
            color: white !important;
        }
        .nav-link.active {
            color: white !important;
            font-weight: bold;
        }
        .admin-link {
            background-color: #ff5722;
            color: white !important;
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: bold;
            margin-left: 15px;
            transition: all 0.3s;
        }
        .admin-link:hover {
            background-color: #e64a19;
            transform: scale(1.05);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .main-container {
            padding-top: 30px;
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }
        .card-header {
            background-color: #f8f9fa;
            border-bottom: 1px solid #e9ecef;
            padding: 15px 20px;
            border-radius: 10px 10px 0 0 !important;
        }
        .card-title {
            margin-bottom: 0;
            color: #3f51b5;
            font-weight: bold;
        }
        .card-body {
            padding: 20px;
        }
        .table {
            margin-bottom: 0;
        }
        .table th {
            border-top: none;
            background-color: #f8f9fa;
            color: #495057;
        }
        .badge {
            font-size: 90%;
            padding: 6px 10px;
        }
        .badge-pill {
            border-radius: 20px;
        }
        .bg-info-light {
            background-color: #e3f2fd;
            color: #0d47a1;
        }
        .bg-warning-light {
            background-color: #fff8e1;
            color: #ff6f00;
        }
        .bg-success-light {
            background-color: #e8f5e9;
            color: #2e7d32;
        }
        .footer {
            position: fixed;
            bottom: 0;
            width: 100%;
            background-color: #3f51b5;
            color: white;
            padding: 15px 0;
            text-align: center;
        }
        .student-avatar {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 50%;
            border: 5px solid #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .student-info {
            padding: 20px;
        }
        .student-info h4 {
            margin-bottom: 5px;
            color: #3f51b5;
        }
        .student-info p {
            color: #6c757d;
            margin-bottom: 5px;
        }
        .student-info .label {
            font-weight: bold;
            display: inline-block;
            width: 100px;
        }
        .progress {
            height: 10px;
            margin-bottom: 15px;
        }
        .highlight-row {
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>
    <!-- 导航栏 -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-graduation-cap mr-2"></i>学生信息管理系统
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp">
                            <i class="fas fa-home mr-1"></i>首页
                        </a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="#">
                            <i class="fas fa-user-graduate mr-1"></i>学生信息
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="fas fa-book mr-1"></i>课程管理
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="fas fa-chart-line mr-1"></i>成绩查询
                        </a>
                    </li>
                </ul>
                <div class="navbar-nav">
                    <a class="nav-link" href="#">
                        <i class="fas fa-user mr-1"></i>${username != null ? username : '游客'}
                    </a>
                    <a class="nav-link admin-link" href="${pageContext.request.contextPath}/admin">
                        <i class="fas fa-cog mr-1"></i>控制面板
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- 主内容区 -->
    <div class="container main-container">
        <!-- 页面标题 -->
        <div class="row mb-4">
            <div class="col-12">
                <h2 class="text-center mb-4" style="color:#3f51b5;font-weight:bold;">
                    <i class="fas fa-address-card mr-2"></i>学生基本信息
                </h2>
            </div>
        </div>

        <!-- 学生卡片 -->
        <div class="row">
            <!-- 学生基本信息卡片 -->
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <div class="d-flex align-items-center justify-content-between">
                            <h5 class="card-title">
                                <i class="fas fa-id-card mr-2"></i>个人基本信息
                            </h5>
                            <a href="${pageContext.request.contextPath}/admin" class="btn btn-danger btn-sm">
                                <i class="fas fa-cog mr-1"></i>进入控制面板
                            </a>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-3 text-center">
                                <img src="https://via.placeholder.com/150" alt="学生照片" class="student-avatar mb-3">
                                <h5>张三</h5>
                                <span class="badge badge-pill bg-info-light mb-2">计算机科学与技术</span>
                                <div class="text-center mt-3">
                                    <a href="#" class="btn btn-outline-primary btn-sm">
                                        <i class="fas fa-edit mr-1"></i>编辑资料
                                    </a>
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="row">
                                    <div class="col-md-6 student-info">
                                        <p><span class="label">学号:</span> 20230001</p>
                                        <p><span class="label">姓名:</span> 张三</p>
                                        <p><span class="label">性别:</span> 男</p>
                                        <p><span class="label">出生日期:</span> 2000-01-01</p>
                                        <p><span class="label">民族:</span> 汉族</p>
                                    </div>
                                    <div class="col-md-6 student-info">
                                        <p><span class="label">年级:</span> 2023级</p>
                                        <p><span class="label">班级:</span> 计算机1班</p>
                                        <p><span class="label">专业:</span> 计算机科学与技术</p>
                                        <p><span class="label">学院:</span> 信息学院</p>
                                        <p><span class="label">学籍状态:</span> <span class="badge badge-success">在读</span></p>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-md-6 student-info">
                                        <p><span class="label">联系电话:</span> 13800138000</p>
                                        <p><span class="label">电子邮箱:</span> zhangsan@example.com</p>
                                    </div>
                                    <div class="col-md-6 student-info">
                                        <p><span class="label">家庭住址:</span> 北京市海淀区XX路XX号</p>
                                        <p><span class="label">入学时间:</span> 2023-09-01</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 课程成绩卡片 -->
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title">
                            <i class="fas fa-chart-bar mr-2"></i>课程成绩信息
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>课程编号</th>
                                        <th>课程名称</th>
                                        <th>学期</th>
                                        <th>学分</th>
                                        <th>成绩</th>
                                        <th>绩点</th>
                                        <th>排名</th>
                                        <th>状态</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>CS101</td>
                                        <td>计算机导论</td>
                                        <td>2023年秋季</td>
                                        <td>3</td>
                                        <td>92</td>
                                        <td>4.0</td>
                                        <td>5/60</td>
                                        <td><span class="badge bg-success-light">通过</span></td>
                                    </tr>
                                    <tr class="highlight-row">
                                        <td>CS102</td>
                                        <td>C语言程序设计</td>
                                        <td>2023年秋季</td>
                                        <td>4</td>
                                        <td>88</td>
                                        <td>3.7</td>
                                        <td>10/60</td>
                                        <td><span class="badge bg-success-light">通过</span></td>
                                    </tr>
                                    <tr>
                                        <td>CS103</td>
                                        <td>数据结构</td>
                                        <td>2023年秋季</td>
                                        <td>4</td>
                                        <td>95</td>
                                        <td>4.0</td>
                                        <td>2/60</td>
                                        <td><span class="badge bg-success-light">通过</span></td>
                                    </tr>
                                    <tr class="highlight-row">
                                        <td>CS104</td>
                                        <td>离散数学</td>
                                        <td>2023年秋季</td>
                                        <td>3</td>
                                        <td>85</td>
                                        <td>3.3</td>
                                        <td>15/60</td>
                                        <td><span class="badge bg-success-light">通过</span></td>
                                    </tr>
                                    <tr>
                                        <td>CS105</td>
                                        <td>计算机组成原理</td>
                                        <td>2023年春季</td>
                                        <td>4</td>
                                        <td>90</td>
                                        <td>4.0</td>
                                        <td>8/60</td>
                                        <td><span class="badge bg-success-light">通过</span></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="row mt-4">
                            <div class="col-md-6">
                                <h6 class="mb-3">学期绩点统计</h6>
                                <p><strong>2023年秋季学期平均绩点:</strong> 3.75</p>
                                <p><strong>总平均绩点:</strong> 3.80</p>
                                <p><strong>已修学分:</strong> 18/150</p>
                            </div>
                            <div class="col-md-6">
                                <h6 class="mb-3">绩点分布</h6>
                                <div class="progress-info">
                                    <div class="d-flex justify-content-between mb-1">
                                        <span>4.0 (优秀)</span>
                                        <span>60%</span>
                                    </div>
                                    <div class="progress">
                                        <div class="progress-bar bg-success" style="width: 60%"></div>
                                    </div>
                                </div>
                                <div class="progress-info">
                                    <div class="d-flex justify-content-between mb-1">
                                        <span>3.0-3.9 (良好)</span>
                                        <span>40%</span>
                                    </div>
                                    <div class="progress">
                                        <div class="progress-bar bg-info" style="width: 40%"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 获奖信息卡片 -->
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title">
                            <i class="fas fa-trophy mr-2"></i>获奖信息
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>奖项名称</th>
                                        <th>获奖等级</th>
                                        <th>获奖日期</th>
                                        <th>颁奖单位</th>
                                        <th>奖项说明</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>国家奖学金</td>
                                        <td><span class="badge bg-warning-light">国家级</span></td>
                                        <td>2023-12-01</td>
                                        <td>教育部</td>
                                        <td>学习成绩优异，综合表现突出</td>
                                    </tr>
                                    <tr class="highlight-row">
                                        <td>程序设计大赛</td>
                                        <td><span class="badge bg-info-light">校级</span></td>
                                        <td>2023-10-15</td>
                                        <td>计算机学院</td>
                                        <td>获得校级程序设计大赛二等奖</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 页脚 -->
    <footer class="footer">
        <div class="container">
            <div class="text-center">
                <span>© 2023 学生信息管理系统 - 版权所有</span>
            </div>
        </div>
    </footer>

    <!-- JavaScript脚本 -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 