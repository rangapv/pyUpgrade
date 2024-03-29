#!/usr/bin/env bash
set -E
li=$(uname -s)
pyt="t"

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
#se3="$pyver2"
cd $se1 
sudo ./configure --enable-optimizations
sudo make altinstall
slpy="python$se3"
`sudo ln -sf "/usr/local/bin/$slpy" /usr/bin/python`
echo "PYTHON is $(python -V)"
}

sslupdate() {
cm1="$@"
sudo $cm1 -y install build-essential checkinstall libreadline-gplv2-dev libncursesw5-dev libsqlite3-dev tk-dev libgdbm-dev bzip2* libc6-dev libbz2-dev
curl https://www.openssl.org/source/openssl-3.0.10.tar.gz | tar xz
cd openssl-3.0.10 
sudo ./config shared --prefix=/usr/local
sudo make
sudo make install
}

pipupgrade () {
      pipargs="$#"
      pargs=("$@")
      pargs1=${pargs[$((pipargs-pipargs))]}
      pythonwhich
      piver=$(pyt -V 2>&1)
      piver1=$( echo "${piver}" | awk '{split($0,a," ");print a[2]}')
      piver12=$( echo "${piver1}" | awk '{split($0,a,".");print a[1]}')
      piver33=$( echo "${piver}" | awk '{split($0,a,".");print a[2]}')

      if [ $piver12 = "2" ]
      then
	 sudo $pargs1 install python-pip
         sudo pip install --upgrade pip
	 piprelease
      elif [ $piver12 = "3" ]
      then
         sudo $pargs1 install python3-pip
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
	sudo wget http://www.zlib.net/zlib-1.3.tar.gz 
        tar -xzf ./zlib-1.3.tar.gz
        cd zlib-1.3
        sudo make distclean
        sudo ./configure
        sudo make
        sudo make install
        ld1=`cat $HOME/.bashrc | grep "export LDFLAGS="`
        if [[ ( ! -z "$ld1" ) ]]
	then
	echo "export LDFLAGS=${LDFLAGS} -L/usr/local/lib" >> ~/.bashrc  
        fi
       	ld2=`cat $HOME/.bashrc | grep "export CPPFLAGS="`
	if [[ ( ! -z "$ld2" ) ]]
	then
	echo "export CPPFLAGS=${CPPFLAGS} -I/usr/local/include" >> ~/.bashrc
    	fi
    	ld3=`cat $HOME/.bashrc | grep "export PKG_CONFIG_PATH="`
        if [[ ( ! -z "$ld3" ) ]]
	then
	echo "export PKG_CONFIG_PATH=${PKG_CONFIG_PATH} /usr/local/lib/pkgconfig" >> ~/.bashrc
	fi
}

lbrelease() {
file1="/usr/bin/lsb_release"
pythonwhich
#piver=$(python -V 2>&1)
piver1=$( echo "${piver}" | awk '{split($0,a," ");print a[2]}')
piver12=$( echo "${piver1}" | awk '{split($0,a,".");print a[1]}')
piver33=$( echo "${piver}" | awk '{split($0,a,".");print a[2]}')
pyvert=$( echo "${piver1}" | awk '{split($0,a,"."); for (i=1; i<2 ; i++) print a[i]"."a[i+1]; }')

line1="#!/usr/local/bin/python${pyvert}"
sudo sed -i "1s|^.*|${line1}|" $file1 

sudo ln -s /usr/share/pyshared/lsb_release.py /usr/local/lib/python${pyvert}/site-packages/lsb_release.py
}

pythonwhich() {
pywh3=`(which python3)`
pywh3s="$?"
pyt="t"
if [[(( $pywh3s -ne 0 )) ]]
then
   pywh2=`(which python)`
   piver=$(python -V 2>&1)
   pywh2s="$?"
   pyt="python"
else
  pyt="python3"
fi

}




lsbrelease() {
link=$(readlink -f `which /usr/bin/python`)
sudo ln -sf /usr/bin/python2 /usr/bin/python
if [[ ! -z $c1 ]]
then
sudo yum -y install redhat-lsb-core-4.1-27.el7.centos.1.x86_64
fi
if [[ ! -z $r1 ]]
then
sudo yum -y install redhat-lsb-core-4.1-27.el7.x86_64 
fi
if [[ ! -z $a1 ]]
then
sudo yum -y install system-lsb-core-4.1-27.amzn2.1.x86_64
fi
line10="#!/usr/bin/python2"
file11="/usr/libexec/urlgrabber-ext-down"
sudo sed -i "1s|^.*|${line10}|" $file11 

}

yummy() {
filey="/usr/bin/yum"
yum1="#!/usr/bin/python2"
sudo sed -i "1s|^.*|${yum1}|" $filey
filez="/bin/yum"
sudo sed -i "1s|^.*|${yum1}|" $filez
}


piprelease() {
pargs="$#"
args=("$@")
#args2=${args[$((pargs-1))]}
args1=${args[$((pargs-pargs))]}
newpip="pip${args1}"
file2=$( echo `which ${newpip}`)
pythonwhich
piver=`($pyt -V 2>&1)`

piver1=$( echo "${piver}" | awk '{split($0,a," ");print a[2]}')
piver12=$( echo "${piver1}" | awk '{split($0,a,".");print a[1]}')
piver112=$( echo "${piver1}" | awk '{split($0,a,"."); for (i=1; i<2 ; i++) print a[i]"."a[i+1]; }')
#piver33=$( echo "${piver}" | awk '{split($0,a,".");print a[2]}')

pythonwhich
pippy=`which $pyt`
stpippy=`echo "$pippy" | grep -oh "[a-z/]*"`
pyverpip=`$pyt -V | awk '{split($0,a," "); print a[2]}' | awk '{split($0,a,"."); for (i=1; i<2 ; i++) print a[1]"."a[2];}'`

if [[ $pargs -eq 0 ]]
then
piver112="2"
line1="#!$stpippy$pyverpip"
else
line1="#!$stpippy$pyverpip"
fi
line1="#!/usr/bin/python"
file1="/usr/local/bin/pip${args1}"
sudo sed -i "1s|^.*|${line1}|g" $file1
line21="from pip._internal.cli.main import main"
line22="from pip._internal import main"
sudo sed -i "s|${line22}|${line21}|g" $file1

#line3="#!$stpippy$pyverpip"
line3="#!/usr/bin/python"
file3="/usr/local/bin/pip"
sudo sed -i "1s|^.*|${line3}|" $file3
c1=$(cat /etc/*-release | grep ID= | grep centos)
if [[ ! -z $c1 || ! -z $r1 || ! -z $s1 ]]
then
line41="from pip._internal.cli.main import main"
line31="from pip._internal import main"
else
line31="from pip._internal.cli.main import main"
line41="from pip._internal import main"
fi
sudo sed -i "s|${line31}|${line41}|g" $file3

if [[ $piver112 = "3.6" && -z $c1 && -z $r1 ]]
then
sudo sed -i "1s|^.*|${line1}|" $file2 
line3="from pip._internal.cli.main import main"
line4="from pip._internal import main"
sudo sed -i "s|${line3}|${line4}|g" $file2
elif [[ $piver112 = "3.6" &&  ( ! -z $c1 || ! -z $r1 ) ]]
then
sudo sed -i "1s|^.*|${line1}|" $file2 
line4="from pip._internal.cli.main import main"
line3="from pip._internal import main"
sudo sed -i "s|${line3}|${line4}|g" $file2
fi
}

currentpy() {


pyc1=`which python`


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
        pc2=`which python`
	pc2s="$?"
	echo "python release is $pc2 and status is $pc2s"
	if [ "$pc2s" -ne 0 ]
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
	sslupdate $cm1 
	fi
	fi
	count=1
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
	sudo $cm1 -y install gcc make wget libffi-dev 
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
        sudo zypper install -y gcc make openssl-devel libffi-devel zlib-devel wget lsb-release
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
	mi=$(lsb_release -cs)
	lsb=$(echo "$?")
	if [[ ( $lsb > 0 ) ]]
        then
		lsbrelease
	fi
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
        yummy
        cm1="yum"
        link=$(readlink -f `which /usr/bin/python`)
	sudo ln -sf /usr/bin/python2 /usr/bin/python
	sudo $cm1 -y update
        sudo $cm1 -y install wget
	sudo $cm1 -y install gcc make openssl-devel bzip2-devel libffi-devel zlib-devel wget
        sudo $cm1 -y install @development
        sudo ln -sf $link /usr/bin/python 
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
echo "ret is $ret"
if [[ $count > 0 ]] 
then
	echo "inside count"
        echo "Python version is $pi"
        if [[ $ret < 1 ]]
	then	
	pi=$(python --version)
        #pi1="${pi,,}"
	pythonwhich
	piver=`(echo "$pyt" -V 2>&1)`
	piver1=$( echo "${piver}" | awk '{split($0,a," ");print a[2]}')
	piver12=$( echo "${piver1}" | awk '{split($0,a,".");print a[1]}')
        piver33=$( echo "${piver}" | awk '{split($0,a,".");print a[2]}')
        pipupgrade $cm1
 #        echo "inside ret "
        else
             pyupgrade https://www.python.org/ftp/python/ 3.6.12 Python-3.6.12.tgz
	     if [[ -z $r1 && -z $c1 && -z $a1 && ( ! -z $d1 || ! -z u1 ) ]]
             then
 	     lbrelease 
             fi
        fi
	 pythonwhich
	 #echo "pyt is $pyt"
         piver=`($pyt -V 2>&1)`
	 #echo "piver is $piver"
         piver1=$( echo "${piver}" | awk '{split($0,a," ");print a[2]}')
	 #echo "piver1 is $piver1"
         piver12=$( echo "${piver1}" | awk '{split($0,a,".");print a[1]}')
	 #echo "piver12 is $piver12"

         #piver33=$( echo "${piver}" | awk '{split($0,a,".");print a[2]}')

         piver33=$(echo "$piver" | awk '{l=index($0,"."); print substr($0,l+1)}')
	 #echo "piver33 is $piver33"
       
         echo "Current version of Python is $(python --version)"
	 echo "Pls input the version to upgrade to (available verison are 8.7/9.4/10.9/10.12/11.4/11.5/12.0)" 
         read -r inputpyver
         if [ ! -z "$inputpyver" ]
	 then
		 #echo "piver33 is $piver33"
		 piver33="$inputpyver"
	 fi

        case ${piver12} in
		3)
                        if [ $piver33 = "6.12" ]
                        then
                          pyupgrade https://www.python.org/ftp/python/ 3.8.7 Python-3.8.7.tgz 
                        fi
                        if [ $piver33 = "8.7" ]
                        then
                          pyupgrade https://www.python.org/ftp/python/ 3.9.4 Python-3.9.4.tgz 
                        fi
                        if [ $piver33 = "9.4" ]
                        then
                          pyupgrade https://www.python.org/ftp/python/ 3.10.9 Python-3.10.9.tgz
       			fi                 
			if [ $piver33 = "10.9" ]
                        then
                          pyupgrade https://www.python.org/ftp/python/ 3.10.12 Python-3.10.12.tgz 
                        fi
                        if [ $piver33 = "11.4" ]
                        then
                          pyupgrade https://www.python.org/ftp/python/ 3.11.4 Python-3.11.4.tgz 
                        fi
                        if [ $piver33 = "11.5" ]
                        then
                          pyupgrade https://www.python.org/ftp/python/ 3.11.5 Python-3.11.5.tgz 
                        fi
                        if [ $piver33 = "12.0" ]
                        then
                          pyupgrade https://www.python.org/ftp/python/ 3.12.0 Python-3.12.0a1.tgz  
                        fi
		;;
                2)
			 echo "Upgrading Python Version 2"
                         pyupgrade https://www.python.org/ftp/python/ 3.6.12 Python-3.6.12.tgz
                ;;
           	*) 
			echo "Doing Nothing"
	esac
             if [[ -z $r1 &&  -z $c1 && -z $a1 && ( ! -z $d1 || ! -z $u1 ) ]]
             then
	     lbrelease
             fi
 	     pipupgrade $cm1
             declare -i pipver1
             
	     pythonwhich 
             piver=`(echo "$pyt" -V 2>&1)`
             piver11=$( echo "${piver}" | awk '{split($0,a," ");print a[2]}')
	     piver35=$( echo "${piver11}" | awk '{l=split($0,a,".");for(i=1;i<l-1;i++) print a[i]"."a[i+1];}')
	     #piver33=$( echo "${piver11}" | awk '{l=split($0,a,".");for(i=1;i<l-1;i++) print a[i]"."a[i+1];})')
	     piver33=$( echo "${piver}" | awk '{split($0,a,".");print a[2]}')
             pipadd="pip${piver35}"
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
	      pythonwhich
              piver=`(echo "$pyt" -V 2>&1)`
              piverec=$(echo "$?")
              piver34=$(echo "${piver}" | awk '{split($0,a," "); print a[2]}')
	     # piver34=$( echo "${piver}" | awk '{split($0,a,".");print a[2]}')
	      piverwh=$(which pyt)
	      piverwhec=$(echo "$?")
	      if [[ ( ! -z "$u1" || ! -z "$d1" ) && ( $piver34 = "6" ) && ( $piverwhec < 1) && ($piverec < 1) ]]
              then
              eval "sudo ln -sf /usr/local/bin/python3.6 /usr/bin/python3"
              eval "sudo ln -sf /usr/bin/python /usr/bin/python3"
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
	      eval "pip3 install --upgrade pip"
              eval "pip3 install awscli"
              eval "pip3 install boto"
              eval "pip3 install boto3"
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
	      nw="pip"
	      #ne="."
              newpip="${nw}${piver35}"
	      piprelease ${piver35}
 	      echo `${newpip} -V`


   pythonwhich
   if [[ "$pyt" == "python3" ]]
   then
	   sudo ln -sf /usr/bin/python /usr/bin/python3
   fi

fi

