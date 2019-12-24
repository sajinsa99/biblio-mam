set -e +x

echo
echo ==== START ====
echo
date

echo docker build
./dockerbuild.sh 
echo

echo docker run
./dockerrunbash.sh
echo

echo
echo ==== STOP ====
date
echo

