#!/bin/bash
wget http://www.freedesktop.org/software/systemd/systemd-214.tar.xz
tar xf systemd-214.tar.xz
yum -y install gcc intltool gperf glib2-devel  libcap-devel xz-devel
cd ./systemd-214
./configure
make
make install
systemctl --version