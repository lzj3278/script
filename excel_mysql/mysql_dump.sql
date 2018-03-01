
    CREATE TABLE `vi_appointment` (
      `id` INT(11.0) Not Null COMMENT '自增长',
`created_at` DATETIME  COMMENT '创建记录的时间',
`updated_at` DATETIME  COMMENT '最后修改记录的时间',
`updated_by` INT(11.0)  COMMENT '最后修改人',
`created_by` INT(11.0)  COMMENT '创建人',
`deleted` TINYINT(1.0)  COMMENT '是否被删除的标记 0：未删除 1：删除' DEFAULT '0.0',
`user_id` INT(11.0)  COMMENT '用户id',
`plan_id` INT(11.0)  COMMENT '用户使用套餐id',
`shop_id` INT(11.0)  COMMENT '店铺id',
`room_id` INT(11.0)  COMMENT '房间id',
`user_realname` VARCHAR(100.0)  COMMENT '用户姓名',
`user_tel` VARCHAR(25.0)  COMMENT '用户电话',
`user_email` VARCHAR(100.0)  COMMENT '用户邮箱',
`plan_name` VARCHAR(100.0)  COMMENT '用户套餐名称',
`shop_name` VARCHAR(100.0)  COMMENT '店铺名称',
`room_name` VARCHAR(100.0)  COMMENT '房间名称',
`app_date` DATE()  COMMENT '预约日期',
`app_time_start_h` TINYINT(2.0)  COMMENT '预约时间段起时间 小时',
`app_time_start_m` TINYINT(2.0)  COMMENT '预约时间段起时间 分钟',
`app_time_end_h` TINYINT(2.0)  COMMENT '预约时间段止时间 小时',
`app_time_end_m` TINYINT(2.0)  COMMENT '预约时间段止时间 分钟',
`time_m` TINYINT(4.0)  COMMENT '预约时间段 单位：分',
`person_n` TINYINT(4.0)  COMMENT '预约总人数',
`remark` TEXT()  COMMENT '备注信息',
`status` TINYINT(1.0)  COMMENT '预约状态，常值数组 1：预约中 2：已取消 3：已完成 4：店铺占用 5:运营端取消' DEFAULT '1.0',
`app_time_end_dt` DATETIME  COMMENT '预约截止时间 格式化，比对预约单状态使用',
`app_time_clean_end` char(4.0)  COMMENT '包含打扫结束时间的预约结束时间',
`user_num` TINYINT(2.0)  COMMENT '预约会员人数',
`not_user_num` TINYINT(2.0)  COMMENT '预约非会员人数',
`is_coupon` TINYINT(1.0)  COMMENT '是否使用了优惠券 0 否  1是' DEFAULT '0.0',
`coupon_id` INT(11.0)  COMMENT '优惠券id',
`is_drink` TINYINT(1.0)  COMMENT '是否必须点饮品 0 否  1是' DEFAULT '0.0',
`longitude` double(20.0)  COMMENT '预约时候gps信息经度',
`latitude` double(20.0)  COMMENT '预约时候gps信息纬度',
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB  DEFAULT CHARSET=utf8;
    

    CREATE TABLE `vi_collect` (
      `id` INT(11.0) Not Null COMMENT '自增长',
`created_at` DATETIME  COMMENT '创建记录的时间',
`updated_at` DATETIME  COMMENT '最后修改记录的时间',
`updated_by` INT(11.0)  COMMENT '最后修改人',
`created_by` INT(11.0)  COMMENT '创建人',
`shop_id` INT(11.0) Not Null COMMENT '店铺id',
`user_id` INT(11.0) Not Null COMMENT '用户名',
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB  DEFAULT CHARSET=utf8;
    

    CREATE TABLE `vi_option` (
      `id` INT(11.0) Not Null COMMENT '自增长',
`created_at` DATETIME  COMMENT '创建记录的时间',
`updated_at` DATETIME  COMMENT '最后修改记录的时间',
`updated_by` INT(11.0)  COMMENT '最后修改人',
`created_by` INT(11.0)  COMMENT '创建人',
`deleted` TINYINT(1.0)  COMMENT '是否被删除的标记 0：未删除 1：删除' DEFAULT '0.0',
`name` VARCHAR(100.0)  COMMENT '房间选项名称',
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB  DEFAULT CHARSET=utf8;
    

    CREATE TABLE `hp_size` (
      `id` INT(11.0) Not Null COMMENT '自增长',
`created_at` DATETIME  COMMENT '创建记录的时间',
`updated_at` DATETIME  COMMENT '最后修改记录的时间',
`updated_by` INT(11.0)  COMMENT '最后修改人',
`created_by` INT(11.0)  COMMENT '创建人',
`deleted` TINYINT(1.0)  COMMENT '是否被删除的标记 0：未删除 1：删除' DEFAULT '0.0',
`name` VARCHAR(100.0)  COMMENT '房间大小选项名称',
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB  DEFAULT CHARSET=utf8;
    