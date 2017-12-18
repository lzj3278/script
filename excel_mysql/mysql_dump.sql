
    CREATE TABLE `table_name` (
      `admin_id` mediumint(8) NOT NULL COMMENT '',
`user_name` varchar(20) NOT NULL COMMENT '用户名称' DEFAULT 'lzj',
`passwd` varchar(128) NOT NULL COMMENT '用户密码',
`true_name` varchar(20) NOT NULL COMMENT '用户真名' DEFAULT '李忠杰',
`telephone` varchar(40) NOT NULL COMMENT '用户电话',
      PRIMARY KEY (`admin_id`)
    ) ENGINE=InnoDB  DEFAULT CHARSET=utf8;
    

    CREATE TABLE `table_name2` (
      `admin_id` mediumint(8) NOT NULL COMMENT '',
`user_name` varchar(20) NOT NULL COMMENT '用户名称',
`passwd` varchar(128) NOT NULL COMMENT '用户密码',
`true_name` varchar(20) NOT NULL COMMENT '用户真名',
`telephone` varchar(40) NOT NULL COMMENT '用户电话',
      PRIMARY KEY (`admin_id`)
    ) ENGINE=InnoDB  DEFAULT CHARSET=utf8;
    