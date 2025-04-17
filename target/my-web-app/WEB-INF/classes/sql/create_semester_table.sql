-- 创建学期表
CREATE TABLE IF NOT EXISTS `semesters` (
  `semester_id` INT NOT NULL AUTO_INCREMENT,
  `semester_name` VARCHAR(50) NOT NULL COMMENT '如：2023-2024-1',
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `is_current` BOOLEAN DEFAULT FALSE COMMENT '是否是当前学期',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`semester_id`),
  UNIQUE KEY `uk_semester_name` (`semester_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学期信息表';

-- 插入初始数据
INSERT INTO `semesters` (`semester_name`, `start_date`, `end_date`, `is_current`) VALUES
('2022-2023-1', '2022-09-01', '2023-01-15', FALSE),
('2022-2023-2', '2023-02-20', '2023-07-10', FALSE),
('2023-2024-1', '2023-09-01', '2024-01-15', TRUE); 