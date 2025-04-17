-- 创建数据库
CREATE DATABASE IF NOT EXISTS student_management DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE student_management;

-- 用户表
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    real_name VARCHAR(50),
    email VARCHAR(100),
    gender VARCHAR(10),
    status INT DEFAULT 1,  -- 0: 禁用, 1: 正常
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 初始用户数据
INSERT INTO users (username, password, real_name, email, gender, status) VALUES
('root', '3a4aa304f868e32597cbcfe0bda96f08', '系统管理员', 'admin@example.com', '男', 1); -- 密码: zby2766485803 (MD5加密)

-- 学校表
CREATE TABLE IF NOT EXISTS schools (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(200),
    website VARCHAR(100),
    description TEXT
);

-- 专业表
CREATE TABLE IF NOT EXISTS majors (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    school_id BIGINT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    FOREIGN KEY (school_id) REFERENCES schools(id)
);

-- 课程表
CREATE TABLE IF NOT EXISTS courses (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(20) NOT NULL,
    name VARCHAR(100) NOT NULL,
    credit INT,
    description TEXT,
    teacher VARCHAR(50),
    semester VARCHAR(20),
    status INT DEFAULT 1 -- 0: 未开始, 1: 进行中, 2: 已结束
);

-- 课程成绩表
CREATE TABLE IF NOT EXISTS course_scores (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT,
    course_id BIGINT,
    course_name VARCHAR(100),
    score DECIMAL(5,2),
    ranking INT,
    semester VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

-- 奖项类型表
CREATE TABLE IF NOT EXISTS award_types (
    type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL
);

-- 奖项级别表
CREATE TABLE IF NOT EXISTS award_levels (
    level_id INT AUTO_INCREMENT PRIMARY KEY,
    level_name VARCHAR(50) NOT NULL
);

-- 获奖信息表
CREATE TABLE IF NOT EXISTS awards (
    award_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT,
    award_name VARCHAR(100) NOT NULL,
    type_id INT,
    level_id INT,
    award_date DATE,
    organization VARCHAR(100),
    certificate_no VARCHAR(50),
    description TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (type_id) REFERENCES award_types(type_id),
    FOREIGN KEY (level_id) REFERENCES award_levels(level_id)
);

-- 初始化奖项类型
INSERT INTO award_types (type_name) VALUES 
('学术竞赛'), ('科研成果'), ('社会实践'), ('文体活动'), ('志愿服务');

-- 初始化奖项级别
INSERT INTO award_levels (level_name) VALUES 
('国家级'), ('省级'), ('市级'), ('校级'), ('院级');

-- 添加一些测试数据
INSERT INTO schools (name, address, website, description) VALUES
('示范大学', '北京市海淀区', 'www.example-university.edu.cn', '一所知名综合性大学');

INSERT INTO majors (school_id, name, description) VALUES
(1, '计算机科学与技术', '培养计算机领域的高级专业人才');

INSERT INTO courses (course_code, name, credit, description, teacher, semester, status) VALUES
('CS101', '计算机导论', 3, '计算机基础课程', '张教授', '2023-2024-1', 2),
('CS201', '数据结构', 4, '介绍基本数据结构和算法', '李教授', '2023-2024-1', 2),
('CS301', '数据库系统', 4, '数据库设计与应用', '王教授', '2023-2024-2', 1),
('CS401', '软件工程', 3, '软件开发生命周期', '刘教授', '2023-2024-2', 1);

-- 添加一些成绩数据
INSERT INTO course_scores (user_id, course_id, course_name, score, ranking, semester) VALUES
(1, 1, '计算机导论', 92.5, 1, '2023-2024-1'),
(1, 2, '数据结构', 88.0, 2, '2023-2024-1');

-- 添加一些奖项数据
INSERT INTO awards (user_id, award_name, type_id, level_id, award_date, organization, certificate_no, description) VALUES
(1, '优秀学生干部', 3, 4, '2023-06-15', '示范大学', 'XS20230615', '表现突出的学生干部'),
(1, '程序设计大赛三等奖', 1, 2, '2023-05-20', '省教育厅', 'JS20230520', '省级程序设计大赛获奖'); 