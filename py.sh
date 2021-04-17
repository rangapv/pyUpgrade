#! /bin/bash
set -E
li=$(uname -s)

if [ $(echo "$li" | grep Linux) ]
then
  mac=""
else
  mac=$(sw_vers | grep Mac)
fi


if [ -z "$mac" ]
then
  u1=$(cat /etc/*-release | grep ubuntu)
  f1=$(cat /etc/*-release | grep ID= | grep fedora)
  c1=$(cat /etc/*-release | grep ID= | grep centos)
  s1=$(cat /etc/*-release | grep suse)
  d1=$(cat /etc/*-release | grep ID= | grep debian)
else 
  echo "Mac is not empty"
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
        cm11="add-apt-repository"
   	cm2="apt-key"
        sudo $cm11 -y ppa:deadsnakes/ppa
        sudo $cm1 -y update
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
        sudo yum install -y https://repo.ius.io/ius-release-el7.rpm
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
        piver33=$( echo "${piver31}" | awk '{split($0,a,".");print a[2]}')
	
        case ${piver12} in
		2)
			echo "Python Version 2 upgrading to 3"
		;;
		3)
		 	echo "Python Version 3"
                        if [[ $piver33 = "5" ]]
                        then
                         sudo $cm1 install -y python3.6
                         sudo ln -sf /usr/bin/python3.6 /usr/bin/python3
                        echo "Inside 5"
                        fi
                        if [[ $piver33 = "6" ]]
                        then
                         sudo $cm1 install -y python3.7
                         sudo ln -sf /usr/bin/python3.7 /usr/bin/python3
                        echo "Inside 6"
                        fi
		;;
		*)
			echo "No Python Installed in this BOX"
                        eval "sudo $cm1 update"
                        eval "sudo $cm1 install -y python3.6"
                        eval "sudo ln -sf /usr/bin/python3.6 /usr/bin/python3"
                        eval "sudo $cm1 -y upgrade"
	        ;;
	esac
             declare -i pipver1
             pipv=$(pip3 --version)
             pipver=$( echo "$pipv" | awk '{split($0,a," ");print a[2]}')
             pipver1=$( echo "$pipver}" | awk '{split($0,a,".");print a[1]}')
        
          #    echo "eval $(declare -p pipver1)"
          #    echo "the value of pipver is $pipver1"
  
              if [[ $pipver1 < 21 ]]
              then
                eval "sudo $cm1 install -y wget"
                eval "wget https://bootstrap.pypa.io/get-pip.py -O ./get-pip.py"
                eval "python3 ./get-pip.py"
              else
              echo "pipver is >21"
              fi

              eval "sudo $cm1 update"
              eval "sudo ln -sf /usr/bin/python3 /usr/bin/python"
              eval "sudo $cm1 -y upgrade"
              eval "sudo python3 -m pip install --user --upgrade pip"
	      eval "sudo $cm1 install -y python3-pip"
              eval "sudo pip3 install --upgrade pip"
              eval "sudo pip3 install awscli"
              eval "sudo pip3 install boto"
              eval "sudo pip3 install boto3"
              eval "sudo $cm1 install -y python-boto"
              eval "sudo $cm1 install -y python-boto3"

   echo "Success"
   echo `python -V`
   echo `pip3 -V`
fi
