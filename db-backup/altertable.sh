#!/bin/sh
mysql -u root -pxxxxxxxx --database=zabbix <<eof
alter table history ENGINE=INNODB;
alter table history_uint ENGINE=INNODB;
alter table trends ENGINE=INNODB;
alter table trends_uint ENGINE=INNODB;
eof

