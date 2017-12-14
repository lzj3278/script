#! /bin/bash
###########################
# log_path like tomcat log home
# day_num: like 1 2 is delete 2day ago logs
###########################
log_path=${1}
day_num=${2}
date1=$(date +%Y-%m-%d)
delete_log=/opt/shell/deletelog/log_delete_record.log
zip -r ${log_path}/backuplogs_$date1.zip ${log_path}/*
aws s3 cp ${log_path}/backuplogs_$date1.zip s3://viziner/backup_logs/
if [ -n ${log_path}/backuplog* ];then
        rm -rf  ${log_path}/backuplog*
fi
deletelog()
{
inner_num=${1}
#find log
echo "[`date`] >> start delete logs---" >> $delete_log

find ${log_path} -mtime ${inner_num} -type f -name "*-*" -exec rm -rf {} \;

echo "[`date`] >> end delete logs---" >> $delete_log
}

makedr()
{
mkdir -p /opt/shell/deletelog
}

main()
{
makedr
if [ -z ${log_path} ];then
echo "[`date`] >> error log_path not exist--" >> $delete_log
return
fi
base_day_num=+7
if [[ -n ${day_num} ]] && [[ ${day_num} -ge 1 ]] ; then
base_day_num=+${day_num}
fi
deletelog ${base_day_num}
}
main
