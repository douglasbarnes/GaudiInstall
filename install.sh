## Before executing, run "sudo -s"

## Dependencies
apt-get install -y python cmake g++ git libboost-all-dev zlib1g-dev python3.8 python-nose openssl python3-pip libtbb-dev liblzma5 uuid clang-10 gcc-8 g++-8 libssl-dev 

## Get CVMFS
cd /tmp/
wget https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest_all.deb
dpkg -i cvmfs-release-latest_all.deb
apt update -y
apt upgrade -y
apt autoremove -y
apt install cvmfs -y

## Configure CVMFS
echo 'CVMFS_HTTP_PROXY="DIRECT"
CVMFS_REPOSITORIES=atlas.cern.ch,sft.cern.ch,sft-nightlies.cern.ch' > /etc/cvmfs/default.local
cvmfs_config setup
cvmfs_config probe

## You may like to change the last two arguments in the future. http://lcginfo.cern.ch/
source /cvmfs/sft.cern.ch/lcg/views/setupViews.sh dev4/latest x86_64-ubuntu2004-gcc9-opt

cd /opt/
mkdir Gaudi
cd Gaudi

git clone https://gitlab.cern.ch/gaudi/Gaudi.git


## If there are problems in the setup, uncomment these lines to go back to the commit I tested this on. Try this on a new VM.
# cd Gaudi
# git checkout -q cc4e52b9b68c6efa13d23a9ee21593fb64cc6a13
# cd ..

mkdir build
cd build
cmake ../Gaudi
cmake --build . -j$(nproc)
ctest -j$(nproc)



