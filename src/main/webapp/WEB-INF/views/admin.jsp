<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员控制面板 - 学生信息管理系统</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e0eafc 100%);
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            min-height: 100vh;
        }
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(180deg, #3f51b5 0%, #1a237e 100%);
            padding-top: 20px;
            box-shadow: 3px 0 10px rgba(0, 0, 0, 0.1);
            z-index: 100;
            position: fixed;
            width: 16.666667%;
        }
        .sidebar .nav-link {
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 8px;
            border-radius: 5px;
            padding: 10px 15px;
            transition: all 0.3s;
        }
        .sidebar .nav-link:hover {
            color: #fff;
            background-color: rgba(255, 255, 255, 0.1);
            transform: translateX(5px);
        }
        .sidebar .nav-link.active {
            background-color: #ff5722;
            color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .content-wrapper {
            margin-left: 16.666667%;
            width: 83.333333%;
            padding: 0;
        }
        .content-header {
            padding: 20px;
            background-color: white;
            border-bottom: 1px solid #dee2e6;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            margin-bottom: 20px;
        }
        .main-content {
            padding: 0 20px 20px 20px;
        }
        .card {
            border: none;
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 25px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
        }
        .card-header {
            background: linear-gradient(45deg, #3f51b5, #5c6bc0);
            color: white;
            border-bottom: none;
            padding: 15px 20px;
        }
        .card-title {
            margin-bottom: 0;
            font-weight: 600;
        }
        .card-body {
            padding: 20px;
        }
        .table th {
            background-color: #f8f9fa;
            border-top: none;
            color: #333;
            font-weight: 600;
        }
        .table-hover tbody tr:hover {
            background-color: #f1f4ff;
        }
        .action-btn {
            margin-right: 5px;
            border-radius: 50%;
            width: 32px;
            height: 32px;
            padding: 0;
            line-height: 32px;
            text-align: center;
            transition: all 0.3s;
        }
        .action-btn:hover {
            transform: scale(1.1);
        }
        .btn-info {
            background-color: #03a9f4;
            border-color: #03a9f4;
        }
        .btn-warning {
            background-color: #ff9800;
            border-color: #ff9800;
        }
        .btn-danger {
            background-color: #f44336;
            border-color: #f44336;
        }
        .search-area {
            margin-bottom: 20px;
            padding: 15px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }
        .pagination .page-item.active .page-link {
            background-color: #3f51b5;
            border-color: #3f51b5;
        }
        .pagination .page-link {
            color: #3f51b5;
        }
        .modal-content {
            border: none;
            border-radius: 10px;
            overflow: hidden;
        }
        .modal-header {
            background: linear-gradient(45deg, #3f51b5, #5c6bc0);
            color: white;
            border-bottom: none;
        }
        .modal-title {
            font-weight: 600;
        }
        .modal-footer {
            border-top: 1px solid #eee;
        }
        .form-group label {
            font-weight: 500;
            color: #555;
        }
        .btn-primary {
            background-color: #3f51b5;
            border-color: #3f51b5;
        }
        .btn-primary:hover {
            background-color: #303f9f;
            border-color: #303f9f;
        }
        .btn-outline-secondary:hover {
            background-color: #e0e0e0;
            color: #333;
        }
        .system-title {
            font-size: 22px;
            font-weight: bold;
            color: #3f51b5;
        }
        .user-welcome {
            display: flex;
            align-items: center;
        }
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
            background-color: #e0e0e0;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #3f51b5;
            font-weight: bold;
        }
        .summary-card {
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 20px;
            height: 100px;
        }
        .summary-icon {
            width: 30%;
            background-color: rgba(255, 255, 255, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
        }
        .summary-info {
            width: 70%;
            padding: 15px;
        }
        .summary-value {
            font-size: 1.5rem;
            font-weight: bold;
        }
        .students-summary {
            background: linear-gradient(45deg, #3f51b5, #5c6bc0);
            color: white;
        }
        .courses-summary {
            background: linear-gradient(45deg, #ff5722, #ff7043);
            color: white;
        }
        .scores-summary {
            background: linear-gradient(45deg, #4caf50, #66bb6a);
            color: white;
        }
        .awards-summary {
            background: linear-gradient(45deg, #ff9800, #ffb74d);
            color: white;
        }
    </style>
</head>
<body>
    <!-- 侧边栏 -->
    <div class="sidebar col-md-2 col-lg-2 d-md-block">
        <div class="text-center mb-4">
            <h4 class="text-white mb-3">管理员控制面板</h4>
            <div class="px-3">
                <div class="bg-white text-dark p-2 rounded">
                    <i class="fas fa-user mr-2"></i>欢迎，管理员
                </div>
            </div>
        </div>
        <div class="nav flex-column px-3">
            <a class="nav-link active" href="#student-management" data-toggle="tab">
                <i class="fas fa-user-graduate mr-2"></i>学生管理
            </a>
            <a class="nav-link" href="#course-management" data-toggle="tab">
                <i class="fas fa-book mr-2"></i>课程管理
            </a>
            <a class="nav-link" href="#score-management" data-toggle="tab">
                <i class="fas fa-chart-line mr-2"></i>成绩管理
            </a>
            <a class="nav-link" href="#award-management" data-toggle="tab">
                <i class="fas fa-trophy mr-2"></i>获奖信息管理
            </a>
            <a class="nav-link" href="#system-settings" data-toggle="tab">
                <i class="fas fa-cog mr-2"></i>系统设置
            </a>
            <a class="nav-link mt-4 bg-danger text-white" href="/logout">
                <i class="fas fa-sign-out-alt mr-2"></i>退出登录
            </a>
        </div>
    </div>

    <!-- 主内容区 -->
    <div class="content-wrapper">
        <!-- 页面标题 -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-sm-6">
                        <div class="system-title">
                            <i class="fas fa-graduation-cap mr-2"></i>学生信息管理系统
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="user-welcome float-right">
                            <div class="user-avatar">
                                <i class="fas fa-user"></i>
                            </div>
                            <div>
                                <small class="text-muted d-block">管理员账户</small>
                                <span class="font-weight-bold">root</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tab内容 -->
        <div class="main-content">
            <!-- 数据概览 -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="d-flex students-summary summary-card">
                        <div class="summary-icon">
                            <i class="fas fa-user-graduate"></i>
                        </div>
                        <div class="summary-info">
                            <div class="summary-value">128</div>
                            <div>学生总数</div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="d-flex courses-summary summary-card">
                        <div class="summary-icon">
                            <i class="fas fa-book"></i>
                        </div>
                        <div class="summary-info">
                            <div class="summary-value">45</div>
                            <div>课程总数</div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="d-flex scores-summary summary-card">
                        <div class="summary-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <div class="summary-info">
                            <div class="summary-value">532</div>
                            <div>成绩记录</div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="d-flex awards-summary summary-card">
                        <div class="summary-icon">
                            <i class="fas fa-trophy"></i>
                        </div>
                        <div class="summary-info">
                            <div class="summary-value">74</div>
                            <div>获奖记录</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="tab-content">
                <!-- 学生管理 -->
                <div class="tab-pane fade show active" id="student-management">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="card-title">
                                <i class="fas fa-user-graduate mr-2"></i>学生信息管理
                            </h5>
                            <button class="btn btn-light" data-toggle="modal" data-target="#addStudentModal">
                                <i class="fas fa-plus mr-1"></i>添加学生
                            </button>
                        </div>
                        <div class="card-body">
                            <div class="search-area">
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="按姓名、学号搜索...">
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-secondary" type="button">
                                            <i class="fas fa-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>学号</th>
                                            <th>姓名</th>
                                            <th>性别</th>
                                            <th>年级</th>
                                            <th>班级</th>
                                            <th>专业</th>
                                            <th>操作</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>20230001</td>
                                            <td>张三</td>
                                            <td>男</td>
                                            <td>2023</td>
                                            <td>计算机1班</td>
                                            <td>计算机科学与技术</td>
                                            <td>
                                                <button class="btn btn-sm btn-info action-btn">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                                <button class="btn btn-sm btn-warning action-btn">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button class="btn btn-sm btn-danger action-btn">
                                                    <i class="fas fa-trash-alt"></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>20230002</td>
                                            <td>李四</td>
                                            <td>女</td>
                                            <td>2023</td>
                                            <td>计算机2班</td>
                                            <td>软件工程</td>
                                            <td>
                                                <button class="btn btn-sm btn-info action-btn">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                                <button class="btn btn-sm btn-warning action-btn">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button class="btn btn-sm btn-danger action-btn">
                                                    <i class="fas fa-trash-alt"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            
                            <!-- 分页 -->
                            <nav>
                                <ul class="pagination justify-content-center">
                                    <li class="page-item disabled">
                                        <a class="page-link" href="#" tabindex="-1">上一页</a>
                                    </li>
                                    <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                                    <li class="page-item">
                                        <a class="page-link" href="#">下一页</a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
                
                <!-- 其他管理面板 -->
                <div class="tab-pane fade" id="course-management">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="card-title">
                                <i class="fas fa-book mr-2"></i>课程管理
                            </h5>
                            <button class="btn btn-light">
                                <i class="fas fa-plus mr-1"></i>添加课程
                            </button>
                        </div>
                        <div class="card-body">
                            <p>此处显示课程管理界面...</p>
                        </div>
                    </div>
                </div>
                
                <div class="tab-pane fade" id="score-management">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-title">
                                <i class="fas fa-chart-line mr-2"></i>成绩管理
                            </h5>
                        </div>
                        <div class="card-body">
                            <p>此处显示成绩管理界面...</p>
                        </div>
                    </div>
                </div>
                
                <div class="tab-pane fade" id="award-management">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-title">
                                <i class="fas fa-trophy mr-2"></i>获奖信息管理
                            </h5>
                        </div>
                        <div class="card-body">
                            <p>此处显示获奖信息管理界面...</p>
                        </div>
                    </div>
                </div>
                
                <div class="tab-pane fade" id="system-settings">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-title">
                                <i class="fas fa-cog mr-2"></i>系统设置
                            </h5>
                        </div>
                        <div class="card-body">
                            <p>此处显示系统设置界面...</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 添加学生模态框 -->
    <div class="modal fade" id="addStudentModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">添加学生信息</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="studentForm">
                        <div class="row">
                            <div class="col-md-6 form-group">
                                <label>学号</label>
                                <input type="text" class="form-control" name="studentId" required>
                            </div>
                            <div class="col-md-6 form-group">
                                <label>姓名</label>
                                <input type="text" class="form-control" name="name" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 form-group">
                                <label>性别</label>
                                <select class="form-control" name="gender">
                                    <option value="男">男</option>
                                    <option value="女">女</option>
                                </select>
                            </div>
                            <div class="col-md-6 form-group">
                                <label>出生日期</label>
                                <input type="date" class="form-control" name="birthDate">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 form-group">
                                <label>年级</label>
                                <select class="form-control" name="grade">
                                    <option value="2020">2020级</option>
                                    <option value="2021">2021级</option>
                                    <option value="2022">2022级</option>
                                    <option value="2023">2023级</option>
                                </select>
                            </div>
                            <div class="col-md-6 form-group">
                                <label>班级</label>
                                <input type="text" class="form-control" name="className">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 form-group">
                                <label>专业</label>
                                <select class="form-control" name="major">
                                    <option value="计算机科学与技术">计算机科学与技术</option>
                                    <option value="软件工程">软件工程</option>
                                    <option value="人工智能">人工智能</option>
                                    <option value="数据科学与大数据技术">数据科学与大数据技术</option>
                                </select>
                            </div>
                            <div class="col-md-6 form-group">
                                <label>学院</label>
                                <input type="text" class="form-control" name="college" value="信息学院">
                            </div>
                        </div>
                        <div class="form-group">
                            <label>联系电话</label>
                            <input type="tel" class="form-control" name="phone">
                        </div>
                        <div class="form-group">
                            <label>电子邮箱</label>
                            <input type="email" class="form-control" name="email">
                        </div>
                        <div class="form-group">
                            <label>家庭住址</label>
                            <textarea class="form-control" name="address" rows="2"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary">保存</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- JavaScript脚本 -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function() {
            // 表格行点击事件
            $('.table tbody tr').click(function() {
                $(this).toggleClass('table-active');
            });
            
            // 删除确认
            $('.btn-danger').click(function(e) {
                e.stopPropagation();
                if(confirm('确定要删除该学生信息吗？')) {
                    // 执行删除操作
                    alert('删除成功！');
                }
            });
        });
    </script>
</body>
</html> 