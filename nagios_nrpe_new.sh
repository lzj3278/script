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
	tar -vxf nagios-plugins-2.2.1.tar.gz
	cd nagios-plugins-2.2.1
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
	tar -xvf nrpe-3.2.1.tar.gz
	cd nrpe-3.2.1

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

	make install-groups-users && make install && make install-config
	if [[ $? -eq 0 ]]; then
		 echo "nrpe 		5666/tcp 		#nrpe" >> /etc/services
	fi
	make install-init
	systemctl enable nrpe.service
	firewall-cmd --zone=public --add-port=80/tcp --permanent
	firewall-cmd --zone=public --add-port=8000/tcp --permanent
	firewall-cmd --zone=public --add-port=5666/tcp --permanent
	firewall-cmd --reload
	sed -i '/^allowed_hosts=/s/$/,192.168.1.28/' /usr/local/nagios/etc/nrpe.cfg
	sed -i 's/^dont_blame_nrpe=.*/dont_blame_nrpe=1/g' /usr/local/nagios/etc/nrpe.cfg
	systemctl start nrpe.service
	netstat -an|grep 5666
	sleep 10
	if [[ $? -ne 0 ]]; then
		echo 'nrpe configure error,please check'
		exit 1
	fi
	/usr/local/nagios/libexec/check_nrpe -H localhost
	if [[ $? -eq 0 ]]; then
		echo 'install nrpe success. '
	else
		echo "install nrpe failed! Pleease check Error."
        exit 1	
	fi
}

function nrpe_configure(){
	panfu=$(df -h | sed -n '2p' | awk '{print $1}')
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
	nagios_install
	nrpe_install
	echo ""
    echo "Congratulations, nagios install completed!"
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
