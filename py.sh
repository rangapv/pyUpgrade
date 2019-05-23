#! /bin/bash
li=$(uname -s)
li2="${li,,}"

u1=$(cat /etc/*-release | grep ubuntu)
f1=$(cat /etc/*-release | grep ID= | grep fedora)
c1=$(cat /etc/*-release | grep ID= | grep centos)
s1=$(cat /etc/*-release | grep suse)

if [ ! -z "$u1" ]
then 
	mi=$(lsb_release -cs)
	mi2="${mi,,}"
	ji=$(cat /etc/*-release | grep DISTRIB_ID | awk '{split($0,a,"=");print a[2]}')
	ki="${ji,,}"

	if [ "$ki" == "ubuntu" ]
	then
   	echo "IT IS UBUNTU"
   	cm1="apt-get"
   	cm2="apt-key"
	fi
        pi=$(python --version)
        pi1="${pi,,}"
        f1=$(>t2.txt)
        mod=$(chmod 777 t2.txt)
        python -V > ./t2.txt 2>&1
        pyver=$(cat ./t2.txt | awk '{split($0,a," ");print a[2]}') 
        echo "${pyver}"
        piver=$( echo "${pyver}" | awk '{split($0,a,".");print a[1]}')
        echo "${piver}"
       # echo "$(( $pyver / 3 ))"
      
       if [ "${piver}" == "2" ]
       then
         echo "BINGO"
         sudo apt-get -y upgrade
         sudo apt-get install -y python3-pip
         sudo pip3 install --upgrade pip
         sudo ln -sf /usr/bin/python3 /usr/bin/python
       elif [ "${piver}" == "3" ]
       then
         echo "BINGO it is 3"
       else
         echo "Python Not installed"
       fi

fi
