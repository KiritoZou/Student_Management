@echo off
echo 正在初始化数据库...

REM 设置MySQL连接信息
SET MYSQL_USER=root
SET MYSQL_PASS=zby2766485803
SET MYSQL_HOST=localhost
SET MYSQL_PORT=3306

REM 验证MySQL客户端是否存在
where /q mysql
IF %ERRORLEVEL% NEQ 0 (
  echo 错误: MySQL客户端未找到，请确保MySQL已安装并添加到PATH中。
  goto :EOF
)

REM 执行SQL初始化脚本
echo 创建数据库和表...
mysql -u%MYSQL_USER% -p%MYSQL_PASS% -h%MYSQL_HOST% -P%MYSQL_PORT% < src/main/sql/stu.sql

REM 添加root用户
echo 添加root管理员用户...
mysql -u%MYSQL_USER% -p%MYSQL_PASS% -h%MYSQL_HOST% -P%MYSQL_PORT% student_management < src/main/sql/add_root_user.sql

IF %ERRORLEVEL% NEQ 0 (
  echo 错误: 数据库初始化失败！
) ELSE (
  echo 数据库初始化成功！
)

pause 