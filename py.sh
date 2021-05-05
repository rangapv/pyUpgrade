#! /bin/bash
set -E
li=$(uname -s)

pyupgrade() {
pargs="$#"
args=("$@")
arg1=${args[$((pargs-1))]}
pyver=${args[$((pargs-pargs))]}
pyver2=${args[$((pargs-$((pargs-1))))]}
pyver3=${args[$((pargs-$((pargs-2))))]}
var3="/"
wg=$pyver$pyver2$var3$pyver3
sudo wget "$wg" 
tar xzf $pyver3
se1=$( echo "${pyver3}" | awk '{split($0,a,".");print a[1]"."a[2]"."a[3]}')
se2=$( echo "${pyver3}" | awk '{split($0,a,".");print a[1]"."a[2]}')
se3=$( echo "${pyver2}" | awk '{split($0,a,".");print a[1]"."a[2]}')
cd $se1 
sudo ./configure --enable-optimizations
sudo make altinstall
slpy="python$se3"
sudo ln -sf "/usr/local/bin/$slpy" /usr/bin/python
}


susepyup(){
sudo zypper -y install git

} 



if [ $(echo "$li" | grep Linux) ]
then
  mac=""
else
  mac=$(sw_vers | grep Mac)
fi


if [ -z "$mac" ]
then
  u1=$(cat /etc/*-release | grep ID= | grep ubuntu)
  f1=$(cat /etc/*-release | grep ID= | grep fedora)
  r1=$(cat /etc/*-release | grep ID= | grep rhel)
  c1=$(cat /etc/*-release | grep ID= | grep centos)
  s1=$(cat /etc/*-release | grep ID= | grep sles)
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
        sudo ln -sf /usr/lib/python3/dist-packages/apt_pkg.cpython-38-x86_64-linux-gnu.so /usr/lib/python3/dist-packages/apt_pkg.so
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
        cm1="dnf"
        sudo $cm1 -y install gcc make openssl-devel bzip2-devel libffi-devel zlib-devel wget
	count=1

elif [ ! -z "$s1" ]
then
	ji=$(cat /etc/*-release | grep '^ID=' |awk '{split($0,a,"=");print a[2]}')
        ki="${ji,,}"
        echo " it is SUSE"
        sudo zypper install gcc make openssl-devel libffi-devel zlib-devel wget
	count=1

elif [[ ! -z "$c1" || ! -z "$r1" ]]
then
	echo "it is a centos"
        ji=$(cat /etc/*-release | grep '^ID=' |awk '{split($0,a,"\"");print a[2]}')
        ki="${ji,,}"
        cm1="yum"
        sudo yum -y install gcc make openssl-devel bzip2-devel libffi-devel zlib-devel wget
        sudo yum -y install @development
	count=1

elif [ ! -z "$mac" ]
then
	echo "It is a Mac"
	cm1="brew"
	count=1
else
	echo "The distribution cannot be determined"
fi
pi=$(python --version)
ret=$( echo "$?")
if [ count > 0 ]
then

        if [[ $ret < 1 ]]
	then	
	pi=$(python --version)
        #pi1="${pi,,}"
	piver=$(python -V 2>&1)
	piver1=$( echo "${piver}" | awk '{split($0,a," ");print a[2]}')
	piver12=$( echo "${piver1}" | awk '{split($0,a,".");print a[1]}')
        piver33=$( echo "${piver}" | awk '{split($0,a,".");print a[2]}')
        else
          if [ ! -z "$r1" ]
          then
             pyupgrade https://www.python.org/ftp/python/ 3.6.12 Python-3.6.12.tgz
          elif [ ! -z "$u1" ]
          then 
             pyupgrade https://www.python.org/ftp/python/ 3.6.12 Python-3.6.12.tgz
          elif [ ! -z "$d1" ]
	  then
             pyupgrade https://www.python.org/ftp/python/ 3.6.12 Python-3.6.12.tgz
          elif [ ! -z "$s1" ]
          then
          echo "No python is suse" 
          else
          echo "THis should not occur"
          fi
         piver=$(python -V 2>&1)
         piver1=$( echo "${piver}" | awk '{split($0,a," ");print a[2]}')
         piver12=$( echo "${piver1}" | awk '{split($0,a,".");print a[1]}')
         piver33=$( echo "${piver}" | awk '{split($0,a,".");print a[2]}')
        fi
        case ${piver12} in
		3)
                        if [ $piver33 = "5" ]
                        then
                         pyupgrade https://www.python.org/ftp/python/ 3.6.12 Python-3.6.12.tgz
			fi
                        if [ $piver33 = "6" ]
                        then
                          pyupgrade https://www.python.org/ftp/python/ 3.7.9 Python-3.7.9.tgz
                        fi
                        if [ $piver33 = "7" ]
                        then
                          pyupgrade https://www.python.org/ftp/python/ 3.8.7 Python-3.8.7.tgz 
                        fi
                        if [ $piver33 = "8" ]
                        then
                          pyupgrade https://www.python.org/ftp/python/ 3.9.4 Python-3.9.4.tgz 
                        fi
                        if [ $piver33 = "9" ]
                        then
                          pyupgrade https://www.python.org/ftp/python/ 3.10.0 Python-3.10.0a6.tgz 
                        fi
		;;
                2)
			 echo "Upgrading Python Version 2"
                         pyupgrade https://www.python.org/ftp/python/ 3.6.12 Python-3.6.12.tgz
                ;;
           	*) 
			echo "Doing Nothing"
	esac
             declare -i pipver1
             pipv=$(pip3 --version)
             pipret=$( echo "$?" )
	     pipver1=100
	     if [[ $pipret < 1 ]]
	     then
	     pipver=$( echo "$pipv" | awk '{split($0,a," ");print a[2]}')
             pipver1=$( echo "$pipver}" | awk '{split($0,a,".");print a[1]}')
             fi 
          #    echo "eval $(declare -p pipver1)"
          #    echo "the value of pipver is $pipver1"
  
	     if (( $pipver1 < 21 || $pipret != 0 )) 
             then
                eval "sudo $cm1 install -y wget"
                eval "wget https://bootstrap.pypa.io/get-pip.py -O ./get-pip.py"
                eval "sudo python3 ./get-pip.py"
             else
              echo "pipver is >21"
             fi
              piver=$(python -V 2>&1)
              piver34=$( echo "${piver}" | awk '{split($0,a,".");print a[2]}')
	      if [[ ( ! -z "$u1" || ! -z "$d1" ) && ( $piver34 = "6" ) ]]
              then
              eval "sudo ln -sf /usr/local/bin/python3.6 /usr/bin/python3"
              eval "sudo ln -sf /usr/bin/python3 /usr/bin/python"
	      fi
              eval "sudo $cm1 install -y python3-pip"
              eval "sudo pip3 install --upgrade pip"
              eval "sudo pip3 install awscli"
              eval "sudo pip3 install boto"
              eval "sudo pip3 install boto3"
              eval "sudo $cm1 install -y python-boto"
              eval "sudo $cm1 install -y python-boto3"
	      if [[ ( ! -z "$u1" || ! -z "$d1" ) && ( $piver34 = "6" ) ]]
              then
              eval "sudo ln -sf /usr/local/bin/python3.6 /usr/bin/python3"
              eval "sudo ln -sf /usr/bin/python3 /usr/bin/python"
              fi
   echo "Success"
   echo `python -V`
   echo `pip3 -V`
fi

