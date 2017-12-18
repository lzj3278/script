# -*- coding:utf-8 -*-

import xlrd
import os

data = xlrd.open_workbook('test.xlsx')
# sh = data.sheets()[0]
scripts = []
for sh in data.sheets():
    # print(sh.name, sh.nrows, sh.ncols)
    sql_list = []
    for rx in range(1, sh.nrows):
        # print(sh.col_values(rx))
        if sh.row_values(rx)[1] == 'DATETIME':
            type_length = sh.row_values(rx)[1]
        else:
            type_length = '{}({})'.format(sh.row_values(rx)[1], sh.row_values(rx)[2])
        if sh.ncols == 6 and sh.row_values(rx)[5] != '':
            sql = "`{}` {} {} COMMENT '{}' DEFAULT '{}',".format(sh.row_values(rx)[0], type_length,
                                                                 sh.row_values(rx)[3],
                                                                 sh.row_values(rx)[4], sh.row_values(rx)[5])
        else:
            sql = "`{}` {} {} COMMENT '{}',".format(sh.row_values(rx)[0], type_length,
                                                    sh.row_values(rx)[3],
                                                    sh.row_values(rx)[4])
        sql_list.append(sql)
    script = """
    CREATE TABLE `{}` (
      {}
      PRIMARY KEY (`{}`)
    ) ENGINE=InnoDB  DEFAULT CHARSET=utf8;
    """.format(sh.name, '\n'.join(sql_list), sh.row_values(1)[0])
    scripts.append(script)

if os.path.exists('mysql_dump.sql'):
    os.remove('mysql_dump.sql')
with open('mysql_dump.sql', 'a') as f:
    f.write('\n'.join(scripts))
