<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>学生列表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap-icons.css">
    <style>
        body {
            font-family: 'Microsoft YaHei', sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
        }
        
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        
        .page-title {
            font-size: 24px;
            color: #1a365d;
            margin: 0;
        }
        
        .search-area {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 5px;
        }
        
        .search-area > div {
            flex: 1;
            min-width: 150px;
        }
        
        .search-control {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .search-input {
            flex: 3;
        }
        
        .search-btn {
            background-color: #0052cc;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .search-btn:hover {
            background-color: #003d99;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        th {
            background-color: #f8f9fa;
            color: #333;
            font-weight: 600;
        }
        
        tbody tr:hover {
            background-color: #f1f5f9;
        }
        
        .status-badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
            text-align: center;
        }
        
        .status-active {
            background-color: #e1f5e9;
            color: #0d6832;
        }
        
        .status-inactive {
            background-color: #f8d7da;
            color: #842029;
        }
        
        .status-suspended {
            background-color: #fff3cd;
            color: #664d03;
        }
        
        .action-btn {
            display: inline-block;
            width: 32px;
            height: 32px;
            line-height: 32px;
            text-align: center;
            border-radius: 4px;
            margin-right: 5px;
            color: white;
            text-decoration: none;
            cursor: pointer;
        }
        
        .view-btn {
            background-color: #0052cc;
        }
        
        .edit-btn {
            background-color: #f59e0b;
        }
        
        .delete-btn {
            background-color: #dc2626;
        }
        
        .action-btn:hover {
            opacity: 0.85;
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            list-style: none;
            padding: 0;
            margin-top: 20px;
        }
        
        .pagination a {
            display: inline-block;
            padding: 8px 12px;
            margin: 0 5px;
            border: 1px solid #d1d5db;
            border-radius: 4px;
            text-decoration: none;
            color: #333;
        }
        
        .pagination a.active {
            background-color: #0052cc;
            color: white;
            border-color: #0052cc;
        }
        
        .pagination a:hover:not(.active) {
            background-color: #f1f5f9;
        }
        
        .add-button {
            display: inline-block;
            background-color: #10b981;
            color: white;
            padding: 8px 16px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: 500;
            margin-bottom: 20px;
        }
        
        .add-button:hover {
            background-color: #059669;
        }
        
        /* 弹窗样式 */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }
        
        .modal-content {
            background-color: #fff;
            margin: 10% auto;
            padding: 20px;
            border-radius: 8px;
            width: 70%;
            max-width: 800px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.2);
            position: relative;
        }
        
        .close-modal {
            position: absolute;
            top: 15px;
            right: 20px;
            font-size: 24px;
            font-weight: bold;
            cursor: pointer;
            color: #666;
        }
        
        .education-table {
            width: 100%;
            margin-top: 15px;
        }
        
        .modal-title {
            margin-top: 0;
            color: #1a365d;
            font-size: 20px;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
        
        /* 密钥验证弹窗样式 */
        .auth-modal {
            display: none;
            position: fixed;
            z-index: 1100;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }
        
        .auth-modal-content {
            background-color: #fff;
            margin: 15% auto;
            padding: 25px;
            border-radius: 8px;
            width: 90%;
            max-width: 400px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            text-align: center;
        }
        
        .auth-input {
                width: 100%;
            padding: 10px;
            margin: 15px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }
        
        .auth-btn {
            padding: 10px 20px;
            background-color: #0052cc;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
        }
        
        .auth-btn:hover {
            background-color: #003d99;
        }
        
        .error-message {
            display: none;
            background-color: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 5px;
            margin: 10px 0;
            text-align: center;
            font-weight: bold;
        }
        
        .action-emoji {
            font-size: 24px;
            cursor: pointer;
            margin-right: 15px;
            text-decoration: none;
        }
        
        .action-emoji:hover {
            transform: scale(1.2);
            transition: transform 0.2s;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1 class="page-title">学生列表</h1>
            <a href="${pageContext.request.contextPath}/student/add" class="add-button">
                <i class="bi bi-plus"></i> 添加学生
            </a>
            </div>
            
        <div class="search-area">
            <div>
                <select class="search-control" id="gender-filter">
                    <option value="">全部性别</option>
                                            <option value="男">男</option>
                                            <option value="女">女</option>
                                        </select>
                                    </div>
            <div>
                <select class="search-control" id="major-filter">
                    <option value="">全部专业</option>
                                            <option value="计算机科学与技术">计算机科学与技术</option>
                                            <option value="软件工程">软件工程</option>
                                            <option value="人工智能">人工智能</option>
                                        </select>
                                    </div>
            <div>
                <select class="search-control" id="class-filter">
                    <option value="">全部班级</option>
                                            <option value="计科2301">计科2301</option>
                                            <option value="软工2301">软工2301</option>
                                            <option value="智能2301">智能2301</option>
                                        </select>
                                    </div>
            <div>
                <select class="search-control" id="status-filter">
                    <option value="">全部状态</option>
                                            <option value="在读">在读</option>
                    <option value="毕业">毕业</option>
                                            <option value="休学">休学</option>
                                        </select>
                                    </div>
            <div class="search-input">
                <input type="text" id="search-keyword" class="search-control" placeholder="输入学号或姓名">
            </div>
            <button class="search-btn" id="search-btn">
                <i class="bi bi-search"></i> 搜索
            </button>
            </div>
            
        <table>
                    <thead>
                        <tr>
                            <th>学号</th>
                            <th>姓名</th>
                            <th>性别</th>
                            <th>专业</th>
                            <th>班级</th>
                            <th>状态</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>2023001</td>
                            <td>张三</td>
                            <td>男</td>
                            <td>计算机科学与技术</td>
                            <td>计科2301</td>
                            <td><span class="status-badge status-active">在读</span></td>
                            <td>
                        <span class="action-emoji" onclick="openEducationModal(1)">👁️</span>
                        <span class="action-emoji" onclick="showAuthModal('edit', 1)">✏️</span>
                        <span class="action-emoji" onclick="showAuthModal('delete', 1)">🗑️</span>
                            </td>
                        </tr>
                        <tr>
                            <td>2023002</td>
                            <td>李四</td>
                    <td>男</td>
                            <td>软件工程</td>
                            <td>软工2301</td>
                            <td><span class="status-badge status-active">在读</span></td>
                            <td>
                        <span class="action-emoji" onclick="openEducationModal(2)">👁️</span>
                        <span class="action-emoji" onclick="showAuthModal('edit', 2)">✏️</span>
                        <span class="action-emoji" onclick="showAuthModal('delete', 2)">🗑️</span>
                            </td>
                        </tr>
                        <tr>
                            <td>2023003</td>
                    <td>小兰</td>
                    <td>女</td>
                            <td>人工智能</td>
                            <td>智能2301</td>
                            <td><span class="status-badge status-active">在读</span></td>
                            <td>
                        <span class="action-emoji" onclick="openEducationModal(3)">👁️</span>
                        <span class="action-emoji" onclick="showAuthModal('edit', 3)">✏️</span>
                        <span class="action-emoji" onclick="showAuthModal('delete', 3)">🗑️</span>
                            </td>
                        </tr>
                        <tr>
                            <td>2023004</td>
                            <td>赵六</td>
                            <td>女</td>
                            <td>数据科学</td>
                            <td>数科2301</td>
                            <td><span class="status-badge status-active">在读</span></td>
                            <td>
                        <span class="action-emoji" onclick="openEducationModal(4)">👁️</span>
                        <span class="action-emoji" onclick="showAuthModal('edit', 4)">✏️</span>
                        <span class="action-emoji" onclick="showAuthModal('delete', 4)">🗑️</span>
                            </td>
                        </tr>
                        <tr>
                            <td>2023005</td>
                            <td>钱七</td>
                            <td>男</td>
                            <td>网络工程</td>
                            <td>网工2301</td>
                    <td><span class="status-badge status-suspended">休学</span></td>
                            <td>
                        <span class="action-emoji" onclick="openEducationModal(5)">👁️</span>
                        <span class="action-emoji" onclick="showAuthModal('edit', 5)">✏️</span>
                        <span class="action-emoji" onclick="showAuthModal('delete', 5)">🗑️</span>
                            </td>
                        </tr>
                    </tbody>
                </table>
        
        <div class="pagination">
            <a href="#" class="active">1</a>
            <a href="#">2</a>
            <a href="#">3</a>
            <a href="#">&raquo;</a>
        </div>
    </div>
    
    <!-- 学历信息弹窗 -->
    <div id="educationModal" class="modal">
        <div class="modal-content">
            <span class="close-modal" onclick="closeModal()">&times;</span>
            <h3 class="modal-title">学生过往学历信息</h3>
            <div id="studentInfo"></div>
            <table class="education-table">
                <thead>
                    <tr>
                        <th>教育阶段</th>
                        <th>学校名称</th>
                        <th>开始时间</th>
                        <th>结束时间</th>
                        <th>专业/学科</th>
                        <th>班级</th>
                    </tr>
                </thead>
                <tbody id="educationList">
                    <!-- 学历信息将通过JavaScript动态加载 -->
                </tbody>
            </table>
        </div>
            </div>
            
    <!-- 密钥验证弹窗 -->
    <div id="authModal" class="auth-modal">
        <div class="auth-modal-content">
            <h3 id="authTitle">请输入操作密钥</h3>
            <div id="errorMessage" class="error-message">你无权限修改！</div>
            <input type="password" id="authKey" class="auth-input" placeholder="请输入管理员密钥">
            <button onclick="verifyAuth()" class="auth-btn">确认</button>
            <button onclick="closeAuthModal()" class="auth-btn" style="background-color: #6c757d;">取消</button>
        </div>
            </div>
    
    <!-- 无权限提示弹窗 -->
    <div id="noPermissionModal" class="auth-modal">
        <div class="auth-modal-content">
            <h3>提示</h3>
            <p style="font-size: 18px; margin: 20px 0;">你无权限修改！</p>
            <button onclick="closeNoPermissionModal()" class="auth-btn">确定</button>
        </div>
    </div>

    <script>
        // 显示学历信息弹窗
        function openEducationModal(studentId) {
            const modal = document.getElementById('educationModal');
            const studentInfo = document.getElementById('studentInfo');
            const educationList = document.getElementById('educationList');
            
            // 清空之前的内容
            educationList.innerHTML = '';
            
            // 获取学历信息（模拟数据）
            let educations = [];
            let studentName = '';
            
            if (studentId == 1) {
                studentName = '张三';
                educations = [
                    {level: '小学', school: '实验小学', startDate: '2000-09-01', endDate: '2006-07-01', major: '无', className: '1班'},
                    {level: '初中', school: '实验中学', startDate: '2006-09-01', endDate: '2009-07-01', major: '无', className: '2班'},
                    {level: '高中', school: '实验高中', startDate: '2009-09-01', endDate: '2012-07-01', major: '理科', className: '3班'},
                    {level: '本科', school: '某某大学', startDate: '2012-09-01', endDate: '2016-07-01', major: '计算机科学', className: '计算机1班'}
                ];
            } else if (studentId == 2) {
                studentName = '李四';
                educations = [
                    {level: '小学', school: '第二实验小学', startDate: '2001-09-01', endDate: '2007-07-01', major: '无', className: '3班'},
                    {level: '初中', school: '第二实验中学', startDate: '2007-09-01', endDate: '2010-07-01', major: '无', className: '1班'},
                    {level: '高中', school: '第二实验高中', startDate: '2010-09-01', endDate: '2013-07-01', major: '理科', className: '2班'},
                    {level: '本科', school: '北京大学', startDate: '2013-09-01', endDate: '2017-07-01', major: '计算机科学', className: '计算机2班'}
                ];
            } else if (studentId == 3) {
                studentName = '小兰';
                educations = [
                    {level: '小学', school: '阳光小学', startDate: '2002-09-01', endDate: '2008-07-01', major: '无', className: '2班'},
                    {level: '初中', school: '阳光中学', startDate: '2008-09-01', endDate: '2011-07-01', major: '无', className: '1班'},
                    {level: '高中', school: '阳光高中', startDate: '2011-09-01', endDate: '2014-07-01', major: '理科', className: '1班'},
                    {level: '本科', school: '浙江大学', startDate: '2014-09-01', endDate: '2018-07-01', major: '计算机科学', className: '计算机1班'}
                ];
            } else {
                studentName = '未知学生';
                educations = [];
            }
            
            // 显示学生姓名
            studentInfo.innerHTML = `<p><strong>学生姓名：</strong>${studentName}</p>`;
            
            // 添加学历信息
            if (educations.length > 0) {
                educations.forEach(edu => {
                    const row = document.createElement('tr');
                    row.innerHTML = `
                        <td>${edu.level}</td>
                        <td>${edu.school}</td>
                        <td>${edu.startDate}</td>
                        <td>${edu.endDate}</td>
                        <td>${edu.major}</td>
                        <td>${edu.className}</td>
                    `;
                    educationList.appendChild(row);
                });
            } else {
                educationList.innerHTML = '<tr><td colspan="6">暂无学历信息</td></tr>';
            }
            
            // 显示弹窗
            modal.style.display = 'block';
        }
        
        // 关闭弹窗
        function closeModal() {
            document.getElementById('educationModal').style.display = 'none';
        }
        
        // 显示密钥验证弹窗
        let currentAction = '';
        let currentStudentId = 0;
        
        function showAuthModal(action, id) {
            currentAction = action;
            currentStudentId = id;
            
            const modal = document.getElementById('authModal');
            const title = document.getElementById('authTitle');
            const errorMessage = document.getElementById('errorMessage');
            
            if (action === 'edit') {
                title.textContent = '请输入修改密钥';
            } else if (action === 'delete') {
                title.textContent = '请输入删除密钥';
            }
            
            errorMessage.style.display = 'none';
            document.getElementById('authKey').value = '';
            modal.style.display = 'block';
        }
        
        function closeAuthModal() {
            document.getElementById('authModal').style.display = 'none';
        }
        
        function closeNoPermissionModal() {
            document.getElementById('noPermissionModal').style.display = 'none';
        }
        
        function verifyAuth() {
            // 无论输入什么密钥，都显示无权限
            document.getElementById('authModal').style.display = 'none';
            document.getElementById('noPermissionModal').style.display = 'block';
        }
        
        // 确认删除
        function confirmDelete(id) {
            if (confirm('确定要删除此学生信息吗？此操作不可恢复。')) {
                // 这里可以发送删除请求到后端
                alert('已删除ID为' + id + '的学生信息');
                // location.href = '${pageContext.request.contextPath}/student/delete/' + id;
            }
        }
        
        // 点击窗口其他地方关闭弹窗
        window.onclick = function(event) {
            const educationModal = document.getElementById('educationModal');
            const authModal = document.getElementById('authModal');
            const noPermissionModal = document.getElementById('noPermissionModal');
            
            if (event.target == educationModal) {
                educationModal.style.display = 'none';
            }
            
            if (event.target == authModal) {
                authModal.style.display = 'none';
            }
            
            if (event.target == noPermissionModal) {
                noPermissionModal.style.display = 'none';
            }
        }
    </script>
</body>
</html> 