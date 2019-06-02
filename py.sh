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
	piver=$(python -V 2>&1)
	piver1=$( echo "${piver}" | awk '{split($0,a," ");print a[2]}')
	piver12=$( echo "${piver1}" | awk '{split($0,a,".");print a[1]}')
	piver2=$(python2 -V 2>&1)
	piver21=$( echo "${piver2}" | awk '{split($0,a," ");print a[2]}')
	piver22=$( echo "${piver21}" | awk '{split($0,a,".");print a[1]}')
	piver3=$(python3 -V 2>&1)
	piver31=$( echo "${piver3}" | awk '{split($0,a," ");print a[2]}')
	piver32=$( echo "${piver31}" | awk '{split($0,a,".");print a[1]}')

	case ${piver12} in
		2)
			echo "Python Version 2 upgrading to 3"
			sudo ln -sf /usr/bin/python3 /usr/bin/python
         		sudo apt-get -y upgrade
         	        sudo apt-get update
 			sudo apt-get install -y python3-pip
         		sudo pip3 install --upgrade pip
         		sudo pip3 install awscli
         		sudo pip3 install boto
         		sudo pip3 install boto3	
			sudo apt-get install -y python-boto
			sudo apt-get install -y python-boto3 
		;;
		3)
		 	echo "Python Version 3"
			sudo ln -sf /usr/bin/python3 /usr/bin/python
         		sudo apt-get -y upgrade
			sudo apt-get update
         		sudo apt-get install -y python3-pip
         		sudo pip3 install --upgrade pip
         		sudo pip3 install awscli
         		sudo pip3 install boto
         		sudo pip3 install boto3
			sudo apt-get install -y python-boto
                        sudo apt-get install -y python-boto3
		;;
		*)
			echo "No Python Installed in this BOX"
		;;
	esac
       # echo "$(( $pyver / 3 ))"

fi
