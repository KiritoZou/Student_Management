-- 创建数据库
DROP DATABASE IF EXISTS student_management;
CREATE DATABASE student_management CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE student_management;

-- 用户表
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    real_name VARCHAR(50) NOT NULL,
    gender ENUM('男','女','其他') DEFAULT '男',
    birth_date DATE,
    email VARCHAR(100),
    phone VARCHAR(20),
    avatar VARCHAR(255) COMMENT '头像URL',
    status TINYINT DEFAULT 1 COMMENT '1-活跃, 0-禁用',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_username (username),
    INDEX idx_email (email),
    INDEX idx_phone (phone)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户信息表';

-- 学历信息表（从小学到大学）
CREATE TABLE education (
    education_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    education_level ENUM('小学','初中','高中','大学','硕士','博士') NOT NULL,
    school_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    major VARCHAR(100) COMMENT '专业（大学及以上填写）',
    class_name VARCHAR(50) COMMENT '班级名称',
    description TEXT COMMENT '其他描述信息',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user_education (user_id, education_level)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学历信息表';

-- 课程表
CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_code VARCHAR(20) NOT NULL COMMENT '课程编号',
    course_name VARCHAR(100) NOT NULL,
    credit DECIMAL(3,1) NOT NULL COMMENT '学分',
    course_hours INT COMMENT '课时',
    course_type ENUM('必修','选修','公共课','专业课') DEFAULT '必修',
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_course_code (course_code),
    INDEX idx_course_name (course_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='课程信息表';

-- 学期表
CREATE TABLE semesters (
    semester_id INT PRIMARY KEY AUTO_INCREMENT,
    semester_name VARCHAR(50) NOT NULL COMMENT '如：2023-2024-1',
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_current BOOLEAN DEFAULT FALSE COMMENT '是否是当前学期',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_semester_name (semester_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学期信息表';

-- 课程成绩表
CREATE TABLE course_scores (
    score_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    course_id INT NOT NULL,
    semester_id INT NOT NULL,
    score DECIMAL(5,2) COMMENT '成绩',
    grade_point DECIMAL(3,2) COMMENT '绩点',
    ranking INT COMMENT '班级排名',
    teacher_comment TEXT COMMENT '教师评语',
    exam_date DATE COMMENT '考试日期',
    status ENUM('正常','补考','重修','免修') DEFAULT '正常',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (semester_id) REFERENCES semesters(semester_id),
    UNIQUE KEY uk_user_course_semester (user_id, course_id, semester_id),
    INDEX idx_score (score),
    INDEX idx_semester (semester_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='课程成绩表';

-- 获奖类型表
CREATE TABLE award_types (
    type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(50) NOT NULL COMMENT '如：学术类、体育类',
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_type_name (type_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='获奖类型表';

-- 获奖级别表
CREATE TABLE award_levels (
    level_id INT PRIMARY KEY AUTO_INCREMENT,
    level_name VARCHAR(50) NOT NULL COMMENT '如：国家级、省级',
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_level_name (level_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='获奖级别表';

-- 获奖情况表
CREATE TABLE awards (
    award_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    award_name VARCHAR(100) NOT NULL,
    type_id INT COMMENT '获奖类型',
    level_id INT COMMENT '获奖级别',
    award_date DATE NOT NULL,
    organization VARCHAR(100) NOT NULL COMMENT '颁奖机构',
    description TEXT COMMENT '获奖描述',
    certificate_no VARCHAR(50) COMMENT '证书编号',
    certificate_url VARCHAR(255) COMMENT '证书图片URL',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (type_id) REFERENCES award_types(type_id),
    FOREIGN KEY (level_id) REFERENCES award_levels(level_id),
    INDEX idx_award_date (award_date),
    INDEX idx_organization (organization)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='获奖情况表';

-- 插入初始数据 - 获奖类型
INSERT INTO award_types (type_name, description) VALUES
('学术类', '各类学术竞赛、科研获奖'),
('体育类', '体育比赛获奖'),
('艺术类', '音乐、美术等艺术类比赛获奖'),
('社会实践', '社会实践、志愿者活动获奖'),
('其他', '其他类型奖项');

-- 插入初始数据 - 获奖级别
INSERT INTO award_levels (level_name, description) VALUES
('国际级', '国际性比赛或奖项'),
('国家级', '国家教育部或同等机构颁发的奖项'),
('省级', '省级教育部门颁发的奖项'),
('市级', '市级教育部门颁发的奖项'),
('校级', '学校颁发的奖项'),
('院系级', '学院或系部颁发的奖项');

-- 插入初始数据 - 学期
INSERT INTO semesters (semester_name, start_date, end_date, is_current) VALUES
('2022-2023-1', '2022-09-01', '2023-01-15', FALSE),
('2022-2023-2', '2023-02-20', '2023-07-10', FALSE),
('2023-2024-1', '2023-09-01', '2024-01-15', TRUE);

-- 插入初始数据 - 课程
INSERT INTO courses (course_code, course_name, credit, course_hours, course_type) VALUES
('MATH101', '高等数学', 4.0, 64, '必修'),
('PHYS101', '大学物理', 3.5, 56, '必修'),
('ENG101', '大学英语', 3.0, 48, '必修'),
('CS101', '计算机科学导论', 2.0, 32, '选修'),
('PE101', '体育', 1.0, 32, '公共课'),
('CHEM101', '普通化学', 3.0, 48, '专业课');



SHOW TABLES;
SELECT * FROM users;
SELECT * FROM education;
SELECT * FROM courses;
SELECT * FROM awards;


-- 使用已创建的数据库
USE student_management;

-- 清空现有数据（谨慎操作，仅用于初始化）
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE users;
TRUNCATE TABLE education;
TRUNCATE TABLE course_scores;
TRUNCATE TABLE awards;
SET FOREIGN_KEY_CHECKS = 1;

-- 插入用户数据
INSERT INTO users (username, password, real_name, gender, birth_date, email, phone) VALUES
('zhangsan', 'e10adc3949ba59abbe56e057f20f883e', '张三', '男', '1998-05-15', 'zhangsan@example.com', '13800138001'),
('lisi', 'e10adc3949ba59abbe56e057f20f883e', '李四', '男', '1999-03-22', 'lisi@example.com', '13800138002'),
('xiaolan', 'e10adc3949ba59abbe56e057f20f883e', '小兰', '女', '2000-07-30', 'xiaolan@example.com', '13800138003'),
('wangwu', 'e10adc3949ba59abbe56e057f20f883e', '王五', '男', '1999-11-18', 'wangwu@example.com', '13800138004'),
('zhaoliu', 'e10adc3949ba59abbe56e057f20f883e', '赵六', '男', '2000-01-25', 'zhaoliu@example.com', '13800138005'),
('xiaohong', 'e10adc3949ba59abbe56e057f20f883e', '小红', '女', '2001-04-05', 'xiaohong@example.com', '13800138006');

-- 插入学历信息（从小学到大学）
INSERT INTO education (user_id, education_level, school_name, start_date, end_date, major, class_name, description)
VALUES 
(1, '小学', '实验小学', '2000-09-01', '2006-07-01', NULL, '1班', '小学教育阶段'),
(1, '初中', '实验中学', '2006-09-01', '2009-07-01', NULL, '2班', '初中教育阶段'),
(1, '高中', '实验高中', '2009-09-01', '2012-07-01', '理科', '3班', '高中教育阶段'),
(1, '本科', '某某大学', '2012-09-01', '2016-07-01', '计算机科学', '计算机1班', '本科教育阶段');

-- 插入课程成绩数据
INSERT INTO course_scores (user_id, course_id, semester_id, score, grade_point, ranking, teacher_comment, exam_date) VALUES
-- 张三的成绩
(1, 1, 3, 85.5, 3.7, 10, '表现良好，作业完成认真', '2023-12-20'),
(1, 2, 3, 78.0, 3.0, 15, '实验部分表现突出', '2023-12-22'),
(1, 3, 3, 92.0, 4.0, 5, '英语表达能力优秀', '2023-12-18'),
(1, 4, 3, 88.5, 3.7, 8, '编程作业完成质量高', '2023-12-15'),

-- 李四的成绩
(2, 1, 3, 76.5, 2.7, 25, '需要加强基础练习', '2023-12-20'),
(2, 3, 3, 95.0, 4.0, 3, '英语口语特别优秀', '2023-12-18'),
(2, 5, 3, 90.0, 4.0, 2, '体育特长，篮球校队成员', '2023-12-10'),
(2, 6, 3, 82.0, 3.3, 12, '实验操作规范', '2023-12-16'),

-- 小兰的成绩
(3, 1, 3, 94.0, 4.0, 2, '数学思维能力强', '2023-12-20'),
(3, 2, 3, 89.5, 3.7, 7, '物理实验设计有创意', '2023-12-22'),
(3, 4, 3, 91.0, 4.0, 4, '算法实现能力突出', '2023-12-15'),
(3, 6, 3, 87.0, 3.7, 9, '化学实验报告撰写规范', '2023-12-16'),

-- 王五的成绩
(4, 1, 3, 81.0, 3.3, 18, '解题思路清晰', '2023-12-20'),
(4, 3, 3, 88.0, 3.7, 10, '英语写作能力较强', '2023-12-18'),
(4, 5, 3, 85.0, 3.7, 8, '羽毛球专项优秀', '2023-12-10'),
(4, 6, 3, 76.0, 2.7, 22, '需要加强理论学习', '2023-12-16'),

-- 赵六的成绩
(5, 2, 3, 92.5, 4.0, 3, '物理理论掌握扎实', '2023-12-22'),
(5, 3, 3, 84.0, 3.3, 14, '英语阅读能力较强', '2023-12-18'),
(5, 4, 3, 89.0, 3.7, 6, '编程逻辑思维优秀', '2023-12-15'),
(5, 5, 3, 78.0, 3.0, 16, '体能测试达标', '2023-12-10'),

-- 小红的成绩
(6, 1, 3, 90.5, 4.0, 5, '数学解题方法多样', '2023-12-20'),
(6, 2, 3, 85.0, 3.7, 11, '实验操作规范', '2023-12-22'),
(6, 3, 3, 93.0, 4.0, 4, '英语演讲比赛获奖', '2023-12-18'),
(6, 6, 3, 88.0, 3.7, 8, '化学实验设计新颖', '2023-12-16');

-- 插入获奖情况数据
INSERT INTO awards (user_id, award_name, type_id, level_id, award_date, organization, description, certificate_no) VALUES
-- 张三的获奖
(1, '全国大学生数学建模竞赛一等奖', 1, 2, '2020-11-15', '中国工业与应用数学学会', '团队合作完成复杂数学建模问题', 'MCM202011001'),
(1, '校级三好学生', 5, 5, '2021-06-20', '清华大学', '连续两年获得校级三好学生称号', 'THU202106001'),

-- 李四的获奖
(2, 'ACM国际大学生程序设计竞赛亚洲区银奖', 1, 1, '2020-10-25', 'ACM国际组织', '算法设计与实现能力突出', 'ACM202010002'),
(2, '全国大学生英语演讲比赛特等奖', 1, 2, '2021-05-18', '教育部高等学校大学外语教学指导委员会', '英语演讲与即兴问答表现优异', 'NECCS202105001'),
(2, '校级优秀学生干部', 5, 5, '2021-06-15', '北京大学', '担任班级学习委员，工作认真负责', 'PKU202106002'),

-- 小兰的获奖
(3, '全国电子设计竞赛一等奖', 1, 2, '2021-08-12', '教育部高等教育司', '设计并实现智能家居控制系统', 'NEDC202108003'),
(3, '浙江省大学生运动会女子100米冠军', 2, 3, '2020-10-08', '浙江省教育厅', '打破校运动会记录', 'ZJGY202010001'),
(3, '国家奖学金', 1, 2, '2021-11-10', '教育部', '学业成绩与综合素质表现优异', 'NSS202111001'),

-- 王五的获奖
(4, '全国大学生金融挑战赛二等奖', 1, 2, '2020-12-05', '中国金融学会', '金融数据分析与投资策略设计', 'NFC202012002'),
(4, '上海市大学生创业大赛金奖', 4, 3, '2021-04-20', '上海市教育委员会', '校园二手交易平台创业项目', 'SHCY202104001'),

-- 赵六的获奖
(5, '全国大学生物理学术竞赛一等奖', 1, 2, '2021-07-15', '中国物理学会', '物理问题研究与实验设计', 'CUPT202107001'),
(5, '校级优秀共青团员', 5, 5, '2021-05-04', '南京大学', '积极参与团组织活动', 'NJU202105003'),

-- 小红的获奖
(6, '全国大学生生物医学工程创新设计大赛特等奖', 1, 2, '2021-09-18', '教育部高等学校生物医学工程专业教学指导委员会', '设计便携式医疗检测设备', 'BME202109001'),
(6, '校级十佳歌手冠军', 3, 5, '2020-12-25', '上海交通大学学生会', '校园文化艺术节表演', 'SJTU202012001');

-- 查看小兰的完整信息
SELECT * FROM users WHERE real_name = '小兰';
SELECT * FROM education WHERE user_id = (SELECT user_id FROM users WHERE real_name = '小兰');
SELECT * FROM course_scores WHERE user_id = (SELECT user_id FROM users WHERE real_name = '小兰');
SELECT * FROM awards WHERE user_id = (SELECT user_id FROM users WHERE real_name = '小兰');

-- 查看所有学生的大学信息
SELECT u.real_name, e.school_name, e.major 
FROM education e
JOIN users u ON e.user_id = u.user_id
WHERE e.education_level = '大学';

-- 查看获奖最多的学生
SELECT u.real_name, COUNT(a.award_id) as award_count
FROM users u
LEFT JOIN awards a ON u.user_id = a.user_id
GROUP BY u.user_id
ORDER BY award_count DESC;