#!/bin/sh
# tomcat启动程序(这里注意tomcat实际安装的路径)  
StartTomcat=/opt/tomcat8/bin/startup.sh 
# 定义要监控的页面地址  
WebUrl=http://54.169.8.122:5712/
# 日志输出 
TomcatMonitorLog=/tmp/TomcatMonitor.log  

Monitor() 
{  
  echo "[info]开始监控tomcat...[$(date +'%F %H:%M:%S')]"  
  TomcatID=$(ps -ef |grep tomcat8 | grep -v 'grep'|awk '{print $2}') 
  if [[ $TomcatID ]];then # 这里判断TOMCAT进程是否存在  
    echo "[info]当前tomcat进程ID为:$TomcatID,继续检测页面..."  
    # 检测是否启动成功(成功的话页面会返回状态"200")  
    TomcatServiceCode=$(curl -s -o /dev/null -m 10 --connect-timeout 10 $WebUrl -w %{http_code})  
    if [[ "$TomcatServiceCode" -eq 200 ]];then  
        echo "[info]页面返回码为$TomcatServiceCode,tomcat正常,页面正常......"  
    else 
    	echo "[info] 页面未响应 等待70秒......"
        sleep 70
		TomcatServiceCode2=$(curl -s -o /dev/null -m 10 --connect-timeout 10 $WebUrl -w %{http_code})
		if [[ "$TomcatServiceCode2" -eq 200 ]];then
			echo "[info]页面返回码为$TomcatServiceCode2,tomcat启动成功,页面正常......" 
		else
	    	echo "[error]tomcat页面出错,请注意......状态码为$TomcatServiceCode2"  
       	    	echo "[error]页面访问出错,开始重启tomcat"  
            	kill -9 $TomcatID  # 杀掉原tomcat进程  
            	sleep 3   
            	$StartTomcat  
		fi
    fi  
  else  
    echo "[error]tomcat进程不存在!tomcat开始自动重启..."  
    echo "[info]$StartTomcat,请稍候......"  
    $StartTomcat  
  fi  
  echo "------------------------------"  
}  
while true
	do
	Monitor>>$TomcatMonitorLog
	sleep 30
	done
