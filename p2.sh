#!/bin/bash

pyupgrade() {
pargs="$#"
args=("$@")
echo "pargs,args,args1 is $pargs,${args[$((pargs-2))]},${args[$((pargs-1))]},${args[$((pargs-3))]}"
echo "New is ${args[$((pargs-$((pargs-2))))]}"
echo "New is ${args[$((pargs-$((pargs-1))))]}"
echo "New is ${args[$((pargs-$((pargs))))]}"
first=${args[$((pargs-$((pargs))))]}
second=${args[$((pargs-$((pargs-1))))]}
third=${args[$((pargs-$((pargs-2))))]}
var3="/"
var34="https://www.python.org/ftp/python/3.8.7/Python-3.8.7.tgz"
total="$first$second$var3$third"
echo "total is $total"
var4="Python-3.7.9.tgz"
se1=$( echo "${var4}" | awk '{split($0,a,".");print a[1]"."a[2]"."a[3]}')
se2=$( echo "${var34}" | awk '{split($0,a,"/");print a[6]}')
se3=$( echo "${se2}" | awk '{split($0,a,".");print a[1]"."a[2]}')
echo "$se1"
echo "$se2"
echo "$se3"

sudo ln -sf "/home/ec2-user/$se3" "/home/ec2-user/sdf"
}

pyupgrade1() {
pargs="$#"
args=("$@")
arg1=${args[$((pargs-1))]}
#sudo yum -y install gcc make openssl-devel bzip2-devel libffi-devel zlib-devel wget
pyver=${args[$((pargs-pargs))]}
pyver2=${args[$((pargs-$((pargs-1))))]}
pyver3=${args[$((pargs-$((pargs-2))))]}
var3="/"
wg=$pyver$pyver2$var3$pyver3
echo "WG is $wg"
sudo wget "$wg"
echo "pver3 is $pyver3"
tar xzf $pyver3
se1=$( echo "${pyver3}" | awk '{split($0,a,".");print a[1]"."a[2]"."a[3]}')
se2=$( echo "${pyver3}" | awk '{split($0,a,".");print a[1]"."a[2]}')
se3=$( echo "${pyver2}" | awk '{split($0,a,".");print a[1]"."a[2]}')
echo "se1 is $se1"
cd $se1
#sudo ./configure --enable-optimizations
#sudo make altinstall
slpy="python$se3"
sudo ln -sf "/home/ec2-user/$slpy" /home/ec2-user/python1

}

pyupgrade hello ranga swamy

pyupgrade1 https://www.python.org/ftp/python/ 3.10.0 Python-3.10.0a6.tgz
