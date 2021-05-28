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

sslupdate() {
cm1="$@"
sudo $cm1 -y install build-essential checkinstall libreadline-gplv2-dev libncursesw5-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
curl https://www.openssl.org/source/openssl-1.0.2o.tar.gz | tar xz
cd openssl-1.0.2o
sudo ./config shared --prefix=/usr/local
sudo make
sudo make install
}

pipupgrade () {
      pipargs="$#"
      pargs=("$@")
      pargs1=${pargs[$((pipargs-pipargs))]}
      piver=$(python -V 2>&1)
      piver1=$( echo "${piver}" | awk '{split($0,a," ");print a[2]}')
      piver12=$( echo "${piver1}" | awk '{split($0,a,".");print a[1]}')
      piver33=$( echo "${piver}" | awk '{split($0,a,".");print a[2]}')

      if [ $piver12 = "2" ]
      then
	 sudo $pargs1 install -y python-pip
         sudo pip install --upgrade pip
	 piprelease
      elif [ $piver12 = "3" ]
      then
         sudo $pargs1 install -y python3-pip
	 sudo pip3 install --upgrade pip
	 piprelease 3
      else
	 echo "This should not happen"
      fi
}



susepyup(){
sudo zypper -y install git

} 

zlibadd() {
	sudo wget http://www.zlib.net/zlib-1.2.11.tar.gz 
        tar -xzf ./zlib-1.2.11.tar.gz
        cd zlib-1.2.11
        sudo make distclean
        sudo ./configure
        sudo make
        sudo make install
        echo "export LDFLAGS=${LDFLAGS} -L/usr/local/lib" >> ~/.bashrc  
	echo "export CPPFLAGS=${CPPFLAGS} -I/usr/local/include" >> ~/.bashrc
	echo "export PKG_CONFIG_PATH=${PKG_CONFIG_PATH} /usr/local/lib/pkgconfig" >> ~/.bashrc
}

lbrelease() {
file1="/usr/bin/lsb_release"
piver=$(python -V 2>&1)
piver1=$( echo "${piver}" | awk '{split($0,a," ");print a[2]}')
piver12=$( echo "${piver1}" | awk '{split($0,a,".");print a[1]}')
piver33=$( echo "${piver}" | awk '{split($0,a,".");print a[2]}')
pyvert=$( echo "${piver1}" | awk '{split($0,a,"."); for (i=1; i<2 ; i++) print a[i]"."a[i+1]; }')

line1="#!/usr/local/bin/python${pyvert}"
sudo sed -i "1s|^.*|${line1}|" $file1 

sudo ln -s /usr/share/pyshared/lsb_release.py /usr/local/lib/python${pyvert}/site-packages/lsb_release.py
}

piprelease() {
pargs="$#"
args=("$@")
#args2=${args[$((pargs-1))]}
args1=${args[$((pargs-pargs))]}
newpip="pip${args1}"
file2=$( echo `which ${newpip}`)
piver=$(python -V 2>&1)
piver1=$( echo "${piver}" | awk '{split($0,a," ");print a[2]}')
piver12=$( echo "${piver1}" | awk '{split($0,a,".");print a[1]}')
piver112=$( echo "${piver1}" | awk '{split($0,a,"."); for (i=1; i<2 ; i++) print a[i]"."a[i+1]; }')
piver33=$( echo "${piver}" | awk '{split($0,a,".");print a[2]}')
if [[ $pargs -eq 0 ]]
then
piver112="2"
line1="#!/usr/local/bin/python3.6"
else
line1="#!/usr/local/bin/python${piver112}"
fi

sudo sed -i "1s|^.*|${line1}|" $file2 
#sudo sed -i '1s/.*/\#\!\/usr\/bin\/python3.7/' $file1
line3="pip._internal.cli.main"
line4="pip._internal"
sudo sed -i "s|${line3}|${line4}|g" $file2

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
  a1=$(cat /etc/*-release | grep ID= | grep amzn)
  c1=$(cat /etc/*-release | grep ID= | grep centos)
  s1=$(cat /etc/*-release | grep ID= | grep sles)
  d1=$(cat /etc/*-release | grep ID= | grep debian)
  fc1=$(cat /etc/*-release | grep ID= | grep flatcar)
else 
  echo "Mac is not empty"
fi

count=0

if [ ! -z "$u1" ]
then 
	mi=$(lsb_release -cs)
	lsb=$(echo "$?")
	if [[ ( $lsb > 0 ) ]]
        then
		lbrelease
	fi
	mi2="${mi,,}"
	ji=$(cat /etc/*-release | grep DISTRIB_ID | awk '{split($0,a,"=");print a[2]}')
	ki="${ji,,}"

	if [ "$ki" = "ubuntu" ]
	then
   	echo "IT IS UBUNTU"
   	cm1="apt-get"
        cm11="add-apt-repository"
   	cm2="apt-key"
        sudo $cm11 -y ppa:deadsnakes/ppa
        sudo ln -sf /usr/lib/python3/dist-packages/apt_pkg.cpython-38-x86_64-linux-gnu.so /usr/lib/python3/dist-packages/apt_pkg.so
        sudo $cm1 -y install gcc make wget
	sudo $cm1 -y update
	zlibadd
	count=1
	fi
elif [ ! -z "$d1" ]
then
	mi=$(lsb_release -cs)
	lsb=$(echo "$?")
	if [[ ( $lsb > 0 ) ]]
        then
		lbrelease
	fi
	mi2="${mi,,}"
	ji=$(cat /etc/*-release | grep ^ID= | grep -v "\"" | awk '{split($0,a,"=");print a[2]}')
	ki="${ji,,}"
	if [ "$ki" = "debian" ]
	then
	echo "IT IS Debian"
	cm1="apt-get"
	cm2="apt-key"
	sudo $cm1 -y update
	sudo $cm1 -y upgrade
	sudo $cm1 -y install gcc make wget
        zlibadd
	sslupdate $cm1 
        count=1
        fi

elif [ ! -z "$f1" ]
then
	ji=$(cat /etc/*-release | grep '^ID=' |awk '{split($0,a,"\"");print a[2]}')
        ki="${ji,,}"
        if [ $ki = "fedora" ]
        then
        echo " it is fedora"
        cm1="dnf"
        sudo $cm1 -y install gcc make openssl-devel bzip2-devel libffi-devel zlib-devel wget
	count=1
        fi
elif [ ! -z "$s1" ]
then
	ji=$(cat /etc/*-release | grep '^ID=' |awk '{split($0,a,"\"");print a[2]}')
        ki="${ji,,}"
        if [ $ki = "sles" ]
        then
        echo " it is SUSE"
        sudo zypper install -y gcc make openssl-devel libffi-devel zlib-devel wget
	count=1
        fi
elif [ ! -z "$fc1" ]
then
	ji=$(cat /etc/*-release | grep '^ID=' |awk '{split($0,a,"\"");print a[2]}')
        ki="${ji,,}"
        if [ $ki = "flatcar" ]
        then
          echo "It is Flat Car Linux"
        fi
	count=0

elif [[ ! -z "$c1" || ! -z "$r1" || ! -z "$a1" ]]
then
        ji=$(cat /etc/*-release | grep '^ID=' |awk '{split($0,a,"\"");print a[2]}')
        ki="${ji,,}"
	if [ $ki = "amzn" ]
	then
	   echo "It is amazon AMI"
	   count=1
	elif [ $ki = "rhel" ]
	then 
	   echo "It is RHEL"
	   count=1
	elif [ $ki = "centos" ]
	then
	   echo "It is centos"
           count=1
	else
	   echo "OS flavor cant be determined"
	fi
        cm1="yum"
	if  [[ $count = 1 ]] 
	then
        link=$(readlink -f `which /usr/bin/python`)
	sudo ln -sf /usr/bin/python2 /usr/bin/python
	sudo $cm1 -y update
        sudo $cm1 -y install wget
	sudo $cm1 -y install gcc make openssl-devel bzip2-devel libffi-devel zlib-devel wget
        sudo $cm1 -y install @development
	sudo ln -sf $link /usr/bin/python 
	fi

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
if [[ $count > 0 ]] 
then

        if [[ $ret < 1 ]]
	then	
	pi=$(python --version)
        #pi1="${pi,,}"
	piver=$(python -V 2>&1)
	piver1=$( echo "${piver}" | awk '{split($0,a," ");print a[2]}')
	piver12=$( echo "${piver1}" | awk '{split($0,a,".");print a[1]}')
        piver33=$( echo "${piver}" | awk '{split($0,a,".");print a[2]}')
 #       pipupgrade $cm1
        else
             pyupgrade https://www.python.org/ftp/python/ 3.6.12 Python-3.6.12.tgz
 	     lbrelease 
        fi
         piver=$(python -V 2>&1)
         piver1=$( echo "${piver}" | awk '{split($0,a," ");print a[2]}')
         piver12=$( echo "${piver1}" | awk '{split($0,a,".");print a[1]}')
         piver33=$( echo "${piver}" | awk '{split($0,a,".");print a[2]}')
        
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
	     lbrelease
 	     pipupgrade $cm1
             declare -i pipver1
              
             piver=$(python -V 2>&1)
             piver11=$( echo "${piver}" | awk '{split($0,a," ");print a[2]}')
             piver12=$( echo "${piver11}" | awk '{split($0,a,".");print a[1]}')
             piver33=$( echo "${piver}" | awk '{split($0,a,".");print a[2]}')
             pipadd="pip3.${piver33}"
	     pipv=$( echo "$pipadd --version")
             pipret=$( echo "$?" )
	     pipver1=100
	     if [[ $pipret < 1 ]]
             then
	     pipver=$( echo "$pipv" | awk '{split($0,a," ");print a[2]}')
             pipver1=$( echo "$pipver" | awk '{split($0,a,".");print a[1]}')
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
              piverec=$(echo "$?")
	      piver34=$( echo "${piver}" | awk '{split($0,a,".");print a[2]}')
	      piverwh=$(which python)
	      piverwhec=$(echo "$?")
	      if [[ ( ! -z "$u1" || ! -z "$d1" ) && ( $piver34 = "6" ) && ( $piverwhec < 1) && ($piverec < 1) ]]
              then
              eval "sudo ln -sf /usr/local/bin/python3.6 /usr/bin/python3"
              eval "sudo ln -sf /usr/bin/python3 /usr/bin/python"
	      fi
	      if [[ ! -z "$c1" || ! -z "$r1" || ! -z "$a1" ]]
	      then
              link=$(readlink -f `which /usr/bin/python`)
	      sudo ln -sf /usr/bin/python2 /usr/bin/python
	      eval "sudo $cm1 install -y python3-pip"
              eval "pip install --upgrade pip"
              eval "pip install awscli"
              eval "pip install boto"
              eval "pip install boto3"
              eval "sudo $cm1 install -y python-boto"
              eval "sudo $cm1 install -y python-boto3"
	      sudo ln -sf $link /usr/bin/python 
	      else     
	      eval "sudo $cm1 install -y python3-pip"
	      eval "pip3.${piver33} install --upgrade pip"
              eval "pip3.${piver33} install awscli"
              eval "pip3.${piver33} install boto"
              eval "pip3.${piver33} install boto3"
              eval "sudo $cm1 install -y python-boto"
              eval "sudo $cm1 install -y python-boto3"
	      fi
              echo "Success"

	      echo `python -V`
	      pipver=$( echo "pip -V")
	      pipech=$( echo "$?" )
	      if [ $pipech > 0 ]
	      then
		   piprelease
	      fi
	      piprelease 3
	      nw="pip3"
	      ne="."
              newpip="${nw}${ne}${piver33}"
	      piprelease "${piver12}${ne}${piver33}"
 	      echo `${newpip} -V`
fi
