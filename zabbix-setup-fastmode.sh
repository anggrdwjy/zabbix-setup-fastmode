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
   sudo apt update
   sudo timedatectl set-timezone Asia/Jakarta
   sudo timedatectl set-ntp on
   sudo apt install wget unzip fping apache2 -y
   sudo apt install locales -y && echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen
   cp support/html-index.html /var/www/html/index.html
   systemctl --now enable apache2
   sudo apt install php php-{snmp,cgi,mbstring,common,net-socket,gd,xml-util,mysql,bcmath,imap} -y
   sudo apt install libapache2-mod-php
   cp support/apache2-php.ini /etc/php/*/apache2/php.ini
   sudo apt install mariadb-server mariadb-client-compat -y
   systemctl enable --now mariadb
   cp support/zabbix-release_7.0-2+ubuntu24.04_all.deb zabbix-release_7.0-2_all.deb
   sudo dpkg -i zabbix-release_7.0-2_all.deb
   sudo apt update
   sudo apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent -y
   sudo a2enconf php8.3-cgi
   sudo systemctl restart apache2
   mysql -e "CREATE DATABASE zabbix DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;"            
   mysql -e "GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost' IDENTIFIED BY 'baseball';"
   mysql -e "GRANT SELECT ON mysql.time_zone_name TO zabbix@localhost;"
   mysql -e "FLUSH PRIVILEGES;"
   zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql -u root zabbix
   cp support/zabbix_server.conf /etc/zabbix/zabbix_server.conf
   sudo systemctl enable --now zabbix-server zabbix-agent
   sudo systemctl restart apache2 mariadb zabbix-server zabbix-agent
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
