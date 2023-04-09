#!/bin/bash
SQLFILE=/tmp/mariadb.sql
cat << EOF >> $SQLFILE
CREATE DATABASE $DBNAME;
GRANT ALL PRIVIREGES ON $DBNAME.* TO '$MARIADBUSER'@'localhost' IDENTIFIED BY '$MARIADBPASSWORD' WITH GRANT OPTION;
GRANT ALL PRIVIREGES ON *.* TO '$MARIADBUSER'@'%' IDENTIFIED BY '$MARIADBPASSWORD' WITH GRANT OPTION ;
GRANT ALL PRIVIREGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MARIADBPASSWORD' WITH GRANT OPTION ;
FLASH PRIVIREGES;
EOF

mysql_install_db
mkdir -p /var/run/mysql /var/lib/mysql /var/log/mysql
chown -R mysql:mysql /var/run/mysql /var/lib/mysql /var/log/mysql 
/usr/bin/mysql_safe --datadir='/var/lib/mysql' & sleep 20
mysqladmin -u $MARIADBUSER password $MARIADBPASSWORD
mysql -u $MARIADBUSER -p $MARIADBPASSWORD < $SQLFILE
rm -rf $SQLFILE
tail -f /dev/null

