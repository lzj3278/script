
    CREATE TABLE `table_name` (
      `admin_id` mediumint(8) NOT NULL COMMENT '',
`user_name` varchar(20) NOT NULL COMMENT '�û�����' DEFAULT 'lzj',
`passwd` varchar(128) NOT NULL COMMENT '�û�����',
`true_name` varchar(20) NOT NULL COMMENT '�û�����' DEFAULT '���ҽ�',
`telephone` varchar(40) NOT NULL COMMENT '�û��绰',
      PRIMARY KEY (`admin_id`)
    ) ENGINE=InnoDB  DEFAULT CHARSET=utf8;
    

    CREATE TABLE `table_name2` (
      `admin_id` mediumint(8) NOT NULL COMMENT '',
`user_name` varchar(20) NOT NULL COMMENT '�û�����',
`passwd` varchar(128) NOT NULL COMMENT '�û�����',
`true_name` varchar(20) NOT NULL COMMENT '�û�����',
`telephone` varchar(40) NOT NULL COMMENT '�û��绰',
      PRIMARY KEY (`admin_id`)
    ) ENGINE=InnoDB  DEFAULT CHARSET=utf8;
    