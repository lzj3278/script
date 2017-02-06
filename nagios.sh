#! /bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

####################################
clear
echo ""
echo "#############################################################"
echo "# One click Install nagios被监控端配置       #"
echo "#############################################################"
echo ""


####################################
function rootness(){
    if [[ $EUID -ne 0 ]]; then
       echo "Error:This script must be run as root!" 1>&2
       exit 1
    fi
}

function gcc_check(){
	yum install openssl-devel openssl -y
	rpm -q gcc
	if [[ $? -ne 0 ]]; then
		yum install gcc -y
	fi
}

function xinetd_check(){
	rpm -q xinetd
	if [[ $? -ne 0 ]]; then
		yum install xinetd -y
	fi
}

function create_user_nagios(){
    echo "Please input password for nagios:"
    read -p "(Default password: viziner):" nagiospwd
    [ -z "$nagiospwd" ] && nagiospwd="viziner"
    echo ""
    echo "---------------------------"
    echo "password = $nagiospwd"
    echo "---------------------------"
    echo ""
    id nagios > /dev/null 2>&1
    if [[ $? -ne 0 ]]; then
    	useradd nagios
    	echo "$nagiospwd" | passwd --stdin "nagios" > /dev/null 2>&1
    else 
    	echo "$nagiospwd" | passwd --stdin "nagios" > /dev/null 2>&1
    fi
}

function nagios_install(){
	cd /opt/
	wget http://nagios-plugins.org/download/nagios-plugins-2.1.1.tar.gz
	tar -vxf nagios-plugins-2.1.1.tar.gz
	cd nagios-plugins-2.1.1
	gcc_check
	./configure --prefix=/usr/local/nagios
	if [[ $? -eq 0 ]]; then
		make && make install
		if [[ $? -eq 0 ]]; then
			echo "install nagios success."
		else
			echo "install nagios failed! Please check Error."
            exit 1
		fi
	else
		echo "please check the error and retry!"
		exit 1
	fi
	chown nagios.nagios /usr/local/nagios
	chown -R nagios.nagios /usr/local/nagios/libexec	
}

function nrpe_install(){
	cd /opt/
	wget http://prdownloads.sourceforge.net/sourceforge/nagios/nrpe-2.13.tar.gz
	tar -xvf nrpe-2.13*
	cd nrpe-2.13

	gcc_check
	./configure
	if [[ $? -eq 0 ]]; then
		make all
		if [[ $? -eq 0 ]]; then
			echo "install nrpe success."
		else
			echo "install nrpe failed! Please check Error."
            exit 1
		fi
	else
		echo "please check the error and retry!"
		exit 1
	fi
	make install-plugin && make install-daemon && make install-daemon-config 
	xinetd_check
	make install-xinetd
	if [[ $? -eq 0 ]]; then
		 sed -i '/\<only_from\>/d' /etc/xinetd.d/nrpe
		 echo "nrpe 		5666/tcp 		#nrpe" >> /etc/services
	fi
	service xinetd restart
	netstat -an|grep 5666
	sleep 10
	if [[ $? -ne 0 ]]; then
		echo 'xinetd configure error,please check'
		exit 1
	fi
	/usr/local/nagios/libexec/check_nrpe -H localhost
	if [[ $? -eq 0 ]]; then
		echo 'install xinetd success. '
	else
		echo "install nrpe failed! Pleease check Error."
        exit 1	
	fi
}

function nrpe_configure(){
	panfu=$(df -h | sed -n '2p' | awk '{print $1}' | cut -d "/" -f 3)
	cd /usr/local/nagios/etc
	if [[ -f nrpe.cfg ]]; then
		sed -i"s/sda1/$panfu/g" nrpe.cfg
	else 
		echo "nrpe is wrong"
		exit 1
	fi
	
}

function install(){
	rootness
	create_user_nagios
	nagios_install
	nrpe_install
	nrpe_configure
	echo ""
    echo "Congratulations, nagios install completed!"
    echo -e "Your nagios password: \033[41;37m ${nagiospwd} \033[0m"
    echo -e "please open Port: \033[41;37m 5666 \033[0m"
    echo ""
    exit 0
}
#############################

action=$1
[  -z $1 ] && action=install
case "$action" in
install)
    install
    ;;
*)
    echo "Arguments error! [${action} ]"
    echo "Usage: `basename $0` {install}"
    ;;
esac
