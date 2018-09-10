#!/bin/sh

#  Clover↓.sh
#  
#
#  Created by Xc233 on 2018/9/10.
#


#set RGB
gR="\033[31m"
gG="\033[32m"
gB="\033[34m"
gD="\033[0m"
GC="\033[1;32m"
BC="\033[1;34m"
RC="\033[1;31m"

#Head
clear
echo ""
echo "$GC                           CLOVER LATEST VERSION ↓ v1.0"
echo "                                                               -Xc233 $gD"
echo ""

# get SF info
 svn info https://svn.code.SF.net/p/cloverefiboot/code >SFclover.xml

#get SF release version
release=`curl -s https://sourceforge.net/projects/cloverefiboot/files/latest/download >SFrelease.xml && grep Installer SFrelease.xml|awk -F'_r' '{print $3}'|awk -F'.' '{print $1}'`

#get SF release date
curl -s https://sourceforge.net/projects/cloverefiboot/files/Installer/ >releasedate.xml
releasedate=`grep released releasedate.xml|awk -F'released on' '{print $2}'|awk '{print $1}'`


# Dids Revision
Didsver=`curl -O -s https://github.com/Dids/clover-builder/releases && grep tree releases|head -n 1|awk -F 'title' '{print $2}'|awk -F 'r' '{print $2}'|awk -F '\"' '{print $1}'`

# Dids Revision Date
 SFdate=`grep Date SFclover.xml|awk -F'+' '{print $1}'|awk -F'Date:' '{print $2}'|awk '{print $1}'`



echo " $BC INFO OF SOURCEFORGE RELEASE VERSION:  $gD"
echo "Release Version: $release  "
echo "Release Version Date: $releasedate "

echo "                              "
echo "$GC  INFO OF Did's GITHUB LATEST REVISION: $gD"
echo "Latest Revision: $Didsver "
echo "Last Changed Date: $SFdate "
echo "                           "

# Download latest pkg
function downSF()
{
echo "$RC  Downloading the SourceForge pkg......$gD"
cd ~/Desktop && mkdir Clover_v2.4k_r$release && cd Clover_v2.4k_r$release
curl -L -O   https://sourceforge.net/projects/cloverefiboot/files/latest/download --progress
mv ~/Desktop/Clover_v2.4k_r$release/download  ~/Desktop/Clover_v2.4k_r$release/Clover_v2.4k_r$release.zip
unzip ~/Desktop/Clover_v2.4k_r$release/Clover_v2.4k_r$release.zip && rm ~/Desktop/Clover_v2.4k_r$release/Clover_v2.4k_r$release.zip
open -a Finder ~/Desktop/Clover_v2.4k_r$release
echo "$RC Clover_v2.4k_r$release.pkg has been downloaded! $gD"
}

function downdids()
{
echo "$RC  Downloading the Dids's Github pkg......$gD"
cd ~/Desktop
curl -L -O https://github.com/Dids/clover-builder/releases/download/v2.4k_r4667/Clover_v2.4k_r4667.pkg --progress
echo "$RC Clover_v2.4k_r$Didsver.pkg has been downloaded! $gD"
}


#Which version should we download?
cat << EOF
SourceForge(SF)'s version is the latest release version,
Dids's version(Dids) is building for latest Clover revision,
for stability,we recommend that you download SF version.
EOF

function CHOOSE(){
echo "$BC  WHICH YOUR CHOOSE? $gD
(1) Download SF (Default)
(2) Downlolad Dids
(3) Go to Clover EFI bootloader website
(4) Go to Dids Github repository
(5) Exit "

read -p "(Your choose):" choose
case "$choose" in
1)
downSF
CHOOSE;;
2)
downdids
CHOOSE;;
3)
open -a Safari https://sourceforge.net/projects/cloverefiboot/files/Installer/
CHOOSE;;
4)
open -a Safari https://github.com/Dids/clover-builder/releases
CHOOSE;;
5)
exit 0 ;;
*)
downSF
CHOOSE;;
esac
}

CHOOSE


