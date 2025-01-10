## This Tools Fastmode Setup Zabbix Server

## Information

Before using this program, make sure to update the repository `sudo apt update` and install git `sudo apt install git -y` to maximize the running of the program. I am not responsible for any consequences caused by this program. It is recommended to use this script when a new server is installed with a minimum of 2CPUs. 4GB RAM and 20GB Disk. The program has been tested on Ubuntu 24.10.

## Features
* Setup Fastmode
* Web Server Apache2
* Database MariaDB 11.4
* PHP Language 8.3
* Zabbix Server 7.0

## Support OS
* Ubuntu 24.10

## Edit Username and Password

nano zabbix-setup-fastmode.sh
```
mysql -e "GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost' IDENTIFIED BY 'baseball';"      //Edit Username `zabbix` and Password `baseball`//
```
nano /usr/local/spine/etc/spine.conf
```
DBName=zabbix
DBUser=zabbix          //Edit Username//
DBPassword=baseball    //Edit Password//
```

## Installing Program
```
git clone https://github.com/anggrdwjy/zabbix-setup-fastmode.git
```
```
cd zabbix-setup-fastmode
```
```
chmod -R 777 *
```

## Running Program
```
./zabbix-setup-fastmode.sh
```

## Default Access Web Server Cacti

Username : `Admin` | Password : `zabbix`
```
http://ip-address/zabbix
```

## Support

* [:octocat: Follow me on GitHub](https://github.com/anggrdwjy)
* [🔔 Subscribe me on Youtube](https://www.youtube.com/@anggarda.wijaya)

## References

* https://www.zabbix.com/documentation/7.0/en/manual

## Bugs

Please open an issue on GitHub with as much information as possible if you found a bug.
* Your Distro Version
* All the logs and message outputted
* etc
