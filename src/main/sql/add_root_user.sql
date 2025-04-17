-- 添加 root 管理员用户
INSERT INTO users (username, password, real_name, gender, status) 
SELECT 'root', '48342404d1939793948948862488556b', '系统管理员', '男', 1
WHERE NOT EXISTS (SELECT 1 FROM users WHERE username = 'root');

-- 注意：密码是 zby2766485803 的 MD5 值
-- 这个脚本会检查 root 用户是否已存在，如果不存在则添加