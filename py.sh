#! /bin/bash
li=$(uname -s)

mac=$(sw_vers | grep Mac)
if [ -z "$mac" ]
then
u1=$(cat /etc/*-release | grep ubuntu)
f1=$(cat /etc/*-release | grep ID= | grep fedora)
c1=$(cat /etc/*-release | grep ID= | grep centos)
s1=$(cat /etc/*-release | grep suse)
d1=$(cat /etc/*-release | grep ID= | grep debian)
fi

count=0

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
	count=1
	fi
elif [ ! -z "$d1" ]
then
	cm1="apt-get"
	cm2="apt-key"
	echo "IT IS DEbian"
        count=1

elif [ ! -z "$f1" ]
then
	ji=$(cat /etc/*-release | grep '^ID=' |awk '{split($0,a,"=");print a[2]}')
        ki="${ji,,}"
        echo " it is fedora"
	count=1

elif [ ! -z "$c1" ]
then
	echo "it is a centos"
        ji=$(cat /etc/*-release | grep '^ID=' |awk '{split($0,a,"\"");print a[2]}')
        ki="${ji,,}"
        cm1="yum -y"
	count=1

elif [ ! -z "$mac" ]
then
	echo "It is a Mac"
	cm1="brew"
	count=1
else
	echo "The distribution cannot be determined"
fi
if [ count > 0 ]
then
	pi=$(python --version)
        #pi1="${pi,,}"
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
		;;
		3)
		 	echo "Python Version 3"
		;;
		*)
			echo "No Python Installed in this BOX"
			sudo $cm1 install -y python
                        sudo $cm1 -y upgrade
	        ;;
	esac

       # echo "$(( $pyver / 3 ))"

                     

              sudo ln -sf /usr/bin/python3 /usr/bin/python
              sudo $cm1 -y upgrade
              sudo $cm1 update
              sudo $cm1 install -y python3-pip
              sudo pip3 install --upgrade pip
              sudo pip3 install awscli
              sudo pip3 install boto
              sudo pip3 install boto3
              sudo $cm1 install -y python-boto
              sudo $cm1 install -y python-boto3

  
              sudo $cm1 install -y wget
              wget https://bootstrap.pypa.io/get-pip.py -O ./get-pip.py
              python3 ./get-pip.py

   echo "Success"
   echo `python -V`
   echo `pip -V`

fi
