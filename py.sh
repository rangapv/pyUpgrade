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
        python3 -V > ./t3.txt 2>&1
	piver3=$(python3 -V 2>&1)
	piver31=$( echo "${piver3}" | awk '{split($0,a," ");print a[2]}')
	piver32=$( echo "${piver31}" | awk '{split($0,a,".");print a[1]}')
	echo "P1 + ${piver3}"
	echo "P2 + ${piver31}"
	echo "P3 + ${piver32}"
	pyver=$(cat ./t2.txt | awk '{split($0,a," ");print a[2]}') 
        echo "${pyver}"
        piver=$( echo "${pyver}" | awk '{split($0,a,".");print a[1]}')
        echo "${piver}"
       # echo "$(( $pyver / 3 ))"
      
       if [ "${piver}" == "2" ] || [ "${piver32}" == "3" ]
       then
         echo "BINGO"
         sudo ln -sf /usr/bin/python3 /usr/bin/python
         sudo apt-get -y upgrade
         sudo apt-get install -y python3-pip
         sudo pip3 install --upgrade pip
         sudo pip3 install awscli
         sudo pip3 install boto
         sudo pip3 install boto3
      
       elif [ "${piver32}" == "3" ]
       then
         echo "BINGO it is 3"
         sudo pip3 install awscli
         sudo pip3 install boto
         sudo pip3 install boto3
         sudo ln -sf /usr/bin/python3 /usr/bin/python
       else
         echo "Python Not installed"
       fi

fi
