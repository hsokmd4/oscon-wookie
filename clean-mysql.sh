#!/bin/bash

userdel mysql
groupdel mysql
rm -rf /home/mysql

for S in mgmt data api
do
  if [ -f /etc/init.d/mysql-${S} ]
  then
    service mysql-${S} stop
    chkconfig --del mysql-${S}
  fi
done
rm -f /etc/default/mysql

rm -rf /srv/mysql
rm -rf /app
rm -rf /etc/mysql
rm -rf /var/log/mysql
rm -f /etc/profile.d/mysql
rm -rf /srv/mysql
rm -f /usr/local/mysql

if [ -d /mysql/data ]
then
  umount /mysql/data
  (cat /etc/fstab | grep -v /mysql/data >/tmp/fstab.new) && cat /tmp/fstab.new >/etc/fstab
  lvremove lv_mysql
  vgchange -an vg_data
  vgremove -f vg_data
  pvremove /dev/sdb
fi

