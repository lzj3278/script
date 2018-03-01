
    CREATE TABLE `vi_appointment` (
      `id` INT(11.0) Not Null COMMENT '������',
`created_at` DATETIME  COMMENT '������¼��ʱ��',
`updated_at` DATETIME  COMMENT '����޸ļ�¼��ʱ��',
`updated_by` INT(11.0)  COMMENT '����޸���',
`created_by` INT(11.0)  COMMENT '������',
`deleted` TINYINT(1.0)  COMMENT '�Ƿ�ɾ���ı�� 0��δɾ�� 1��ɾ��' DEFAULT '0.0',
`user_id` INT(11.0)  COMMENT '�û�id',
`plan_id` INT(11.0)  COMMENT '�û�ʹ���ײ�id',
`shop_id` INT(11.0)  COMMENT '����id',
`room_id` INT(11.0)  COMMENT '����id',
`user_realname` VARCHAR(100.0)  COMMENT '�û�����',
`user_tel` VARCHAR(25.0)  COMMENT '�û��绰',
`user_email` VARCHAR(100.0)  COMMENT '�û�����',
`plan_name` VARCHAR(100.0)  COMMENT '�û��ײ�����',
`shop_name` VARCHAR(100.0)  COMMENT '��������',
`room_name` VARCHAR(100.0)  COMMENT '��������',
`app_date` DATE()  COMMENT 'ԤԼ����',
`app_time_start_h` TINYINT(2.0)  COMMENT 'ԤԼʱ�����ʱ�� Сʱ',
`app_time_start_m` TINYINT(2.0)  COMMENT 'ԤԼʱ�����ʱ�� ����',
`app_time_end_h` TINYINT(2.0)  COMMENT 'ԤԼʱ���ֹʱ�� Сʱ',
`app_time_end_m` TINYINT(2.0)  COMMENT 'ԤԼʱ���ֹʱ�� ����',
`time_m` TINYINT(4.0)  COMMENT 'ԤԼʱ��� ��λ����',
`person_n` TINYINT(4.0)  COMMENT 'ԤԼ������',
`remark` TEXT()  COMMENT '��ע��Ϣ',
`status` TINYINT(1.0)  COMMENT 'ԤԼ״̬����ֵ���� 1��ԤԼ�� 2����ȡ�� 3������� 4������ռ�� 5:��Ӫ��ȡ��' DEFAULT '1.0',
`app_time_end_dt` DATETIME  COMMENT 'ԤԼ��ֹʱ�� ��ʽ�����ȶ�ԤԼ��״̬ʹ��',
`app_time_clean_end` char(4.0)  COMMENT '������ɨ����ʱ���ԤԼ����ʱ��',
`user_num` TINYINT(2.0)  COMMENT 'ԤԼ��Ա����',
`not_user_num` TINYINT(2.0)  COMMENT 'ԤԼ�ǻ�Ա����',
`is_coupon` TINYINT(1.0)  COMMENT '�Ƿ�ʹ�����Ż�ȯ 0 ��  1��' DEFAULT '0.0',
`coupon_id` INT(11.0)  COMMENT '�Ż�ȯid',
`is_drink` TINYINT(1.0)  COMMENT '�Ƿ�������Ʒ 0 ��  1��' DEFAULT '0.0',
`longitude` double(20.0)  COMMENT 'ԤԼʱ��gps��Ϣ����',
`latitude` double(20.0)  COMMENT 'ԤԼʱ��gps��Ϣγ��',
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB  DEFAULT CHARSET=utf8;
    

    CREATE TABLE `vi_collect` (
      `id` INT(11.0) Not Null COMMENT '������',
`created_at` DATETIME  COMMENT '������¼��ʱ��',
`updated_at` DATETIME  COMMENT '����޸ļ�¼��ʱ��',
`updated_by` INT(11.0)  COMMENT '����޸���',
`created_by` INT(11.0)  COMMENT '������',
`shop_id` INT(11.0) Not Null COMMENT '����id',
`user_id` INT(11.0) Not Null COMMENT '�û���',
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB  DEFAULT CHARSET=utf8;
    

    CREATE TABLE `vi_option` (
      `id` INT(11.0) Not Null COMMENT '������',
`created_at` DATETIME  COMMENT '������¼��ʱ��',
`updated_at` DATETIME  COMMENT '����޸ļ�¼��ʱ��',
`updated_by` INT(11.0)  COMMENT '����޸���',
`created_by` INT(11.0)  COMMENT '������',
`deleted` TINYINT(1.0)  COMMENT '�Ƿ�ɾ���ı�� 0��δɾ�� 1��ɾ��' DEFAULT '0.0',
`name` VARCHAR(100.0)  COMMENT '����ѡ������',
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB  DEFAULT CHARSET=utf8;
    

    CREATE TABLE `hp_size` (
      `id` INT(11.0) Not Null COMMENT '������',
`created_at` DATETIME  COMMENT '������¼��ʱ��',
`updated_at` DATETIME  COMMENT '����޸ļ�¼��ʱ��',
`updated_by` INT(11.0)  COMMENT '����޸���',
`created_by` INT(11.0)  COMMENT '������',
`deleted` TINYINT(1.0)  COMMENT '�Ƿ�ɾ���ı�� 0��δɾ�� 1��ɾ��' DEFAULT '0.0',
`name` VARCHAR(100.0)  COMMENT '�����Сѡ������',
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB  DEFAULT CHARSET=utf8;
    