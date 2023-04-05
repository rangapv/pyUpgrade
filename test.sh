#!/bin/bash
set -E
li=$(uname -s)
pyt="t"



pythonwhich() {
echo "Inside pythonwhich"
pywh3=`(which python3)`
pywh3s="$?"
echo "pywh3 is $pywh3"
echo "pywh3s is $pywh3s"
if [[(( $pywh3s -ne 0 )) ]]
then
 echo "inside pywh3s check" 
       	pywh2=`(which python)`
   piver=$(python -V 2>&1)
   pywh2s ="$?"
   pyt="python"
else
  #piver=$(python3 -V 2>&1)
  pyt="python3"
  echo "inside else pywh3s check $pyt" 
fi

}


pythonwhich
echo "pyt now is $pyt"
piver=`($pyt -V 2>&1)`
piver1=$( echo "${piver}" | awk '{split($0,a," ");print a[2]}')
piver12=$( echo "${piver1}" | awk '{split($0,a,".");print a[1]}')
piver112=$( echo "${piver1}" | awk '{split($0,a,"."); for (i=1; i<2 ; i++) print a[i]"."a[i+1]; }')
piver33=$( echo "${piver}" | awk '{split($0,a,".");print a[2]}')


echo "piver is $piver"
echo "piver1 is $piver1"
echo "piver12 is $piver12"
echo "piver112 is $piver112"
echo "piver33 is $piver33"

pythonwhich
echo "pyt now is $pyt"
df="which"
pippy=`which $pyt`
piver=`(echo "$pyt" -V 2>&1)`
echo "piver is $piver"
pippys="$?"
echo "pippy is $pippy"
echo "pippys is $pippys"
stpippy=`echo "$pippy" | grep -oh "[a-z/]*"`
pyverpip=`$pyt -V | awk '{split($0,a," "); print a[2]}' | awk '{split($0,a,"."); for (i=1; i<2 ; i++) print a[1]"."a[2];}'`


echo "ppy is $pippy"
echo "stppippy is $stpippy"
echo "pyverpip is $pyverpip"

pythonwhich
piverwh=`which $pyt`

echo "pyverwh is $piverwh"
