#!/bin/bash

systemctl stop rabbitmq-server
killall rabbitmq-server
chkconfig --del rabbitmq-server

sleep 2

service epmd stop
killall epmd
chkconfig --del epmd

if [ -d /rabbitmq ]
then
  umount /rabbitmq
  (cat /etc/fstab | grep -v /rabbitmq >/tmp/fstab.new) && cat /tmp/fstab.new >/etc/fstab
  lvremove lv_rabbitmq
  vgchange -an vg_data
  vgremove -f vg_data
  pvremove /dev/sdb
fi

rm -rf /etc/rabbitmq /var/log/rabbitmq /srv/rabbitmq /srv/util /usr/sbin/rabbitmqadmin
zypper --non-interactive remove erlang erlang-epmd rabbitmq-server
rm -f /etc/sysconfig/erlang

