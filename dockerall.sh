set -e +x

date

echo docker build
./dockerbuild.sh 
echo

echo docker run
./dockerrun.sh
echo

date
echo

