#!/bin/bash

userdel sa_wildfly
groupdel sa_wildfly
rm -rf /home/sa_wildfly

systemctl stop wildfly
chkconfig --del wildfly
rm -f /etc/init.d/wildfly /etc/default/wildfly /etc/profile.d/wildfly
rm -rf /app /srv/wildfly
rm -f /root/wildflyslave.userkey
