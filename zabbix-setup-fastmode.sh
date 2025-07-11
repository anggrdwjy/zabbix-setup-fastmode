#!/bin/bash
#===============================================================#
# Script Name   : zabbix-ubuntu-install                         #
# Description   : Script Install Zabbix on Ubuntu	             #
# Author        : Anggarda Saputra Wijaya                       #
# Github        : https://github.com/anggrdwjy.                 #
#===============================================================#
again='y'
while [[ $again == 'Y' ]] || [[ $again == 'y' ]] ; do
clear   
echo "     ____      __   __   _        ____                                ";
echo "    /_  /___ _/ /  / /  (_)_ __  / __/__ _____  _____ ____            ";
echo "     / // _  / _ \/ _ \/ /\ \ / _\ \/ -_) __/ |/ / -_) __/            ";
echo "    /___|_,_/_.__/_.__/_//_\_\ /___/\__/_/  |___/\__/_/               ";
echo "      ____    __              ____        __                __        ";
echo "     / __/__ / /___ _____    / __/__ ____/ /___ _  ___  ___/ /__      ";
echo "    _\ \/ -_) __/ // / _ \  / _// _  (_-< __/    \/ _ \/ _  / -_)     ";
echo "   /___/\__/\__/\_,_/ .__/ /_/  \_,_/___|__/_/_/_/\___/\_,_/\__/      ";
echo "                   /_/                                                ";
echo "												                                  ";
echo "   Version: 1.0.3 - 06/01/2025                            	          ";
echo "   Developer: https://github.com/anggrdwjy              	             ";
echo "   Support OS : Ubuntu 24.10                      	                   ";
echo "   __________________________________________________	  ";                                                            
echo "                                                	     ";
echo "   Options List :                                		  ";
echo "   1) Install Zabbix Server 7.0 Fastmode     		     ";
echo "   2) Reboot Server	                   		           ";
echo "   3) Exit         	                   		           ";
echo "   __________________________________________________   ";
echo "                                                        ";
read -p "   Enter a number the options listed: " choice;
echo "                                                    	  ";
case $choice in              

1) read -p "   Install Zabbix Fastmode ? y/n :" -n 1 -r
   echo "                                                  ";
   echo "                                                  ";
   if [[ ! $REPLY =~ ^[Nn]$ ]] 
   then
   apt update
   timedatectl set-timezone Asia/Jakarta
   timedatectl set-ntp on
   apt install software-properties-common -y
   apt install wget unzip fping apache2 -y
   apt install locales -y && echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen
   apt install php php-{snmp,cgi,mbstring,common,net-socket,gd,xml-util,mysql,bcmath,imap} -y
   apt install mariadb-server mariadb-client-compat libapache2-mod-php -y
   apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent -y
   wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-2%2Bubuntu24.04_all.deb
   mv zabbix-release_7.0-2+ubuntu24.04_all.deb zabbix-release_7.0-2_all.deb
   dpkg -i zabbix-release_7.0-2_all.deb
   apt update
   a2enconf php8.3-cgi
   systemctl restart apache2
   systemctl enable --now mariadb
   mysql -e "CREATE DATABASE zabbix DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;"            
   mysql -e "GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost' IDENTIFIED BY 'baseball';"
   mysql -e "GRANT SELECT ON mysql.time_zone_name TO zabbix@localhost;"
   mysql -e "FLUSH PRIVILEGES;"
   zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql -u root zabbix
   mv /etc/php/8.3/apache2/php.ini /home/apache2-php.ini
   cp support/apache2-php.ini /etc/php/8.3/apache2/php.ini
   cp support/server.conf /etc/zabbix/zabbix_server.conf
   systemctl enable --now zabbix-server zabbix-agent
   systemctl restart apache2 mariadb zabbix-server zabbix-agent
   echo "                                                  ";
   echo "   ======== Zabbix Success Installing Done ======== 	   ";
   echo "                                                  ";
   fi
   ;;
   
2) read -p "   Reboot Your Server ? y/n :" -n 1 -r
   echo "                                                  ";
   echo "                                                  ";
   if [[ ! $REPLY =~ ^[Nn]$ ]] 
   then
   reboot
   fi
   ;;
   
3) exit
   ;;

*)    echo "Sorry, Your Choice Not Available"
esac
echo "                                                  ";
echo -n "Back to Menu? [y/n]: ";
echo "                                                  ";
read again;
while [[ $again != 'Y' ]] && [[ $again != 'y' ]] && [[ $again != 'N' ]] && [[ $again != 'n' ]];
do
echo " Variable Not Available in Menu ";
echo "                                                  ";
echo -n "Back to Menu? [y/n]: ";
echo "                                                  ";
read again;
done
done 
