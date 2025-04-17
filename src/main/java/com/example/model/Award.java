package com.example.model;

import lombok.Data;
import java.util.Date;

@Data
public class Award {
    private Long awardId;
    private Long userId;
    private String awardName;
    private Integer typeId;
    private Integer levelId;
    private Date awardDate;
    private String organization;
    private String certificateNo;
    private String description;
    private String typeName;    // 用于存储关联查询的奖项类型名称
    private String levelName;   // 用于存储关联查询的奖项级别名称
} 