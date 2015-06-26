#!/bin/sh
 
ROOT=$(pwd)
SDHNAME="sdh-platform"

Update() {
    VC_DIR=$1/.git
 
    if [ ! -d $VC_DIR ]
    then
        echo "Repository is not present, need to clone."
        git clone $2 $1
    else
        echo "Pulling..."
        cd $1
        git pull $2
        cd $ROOT
    fi
}

echo "> SDH Platform"
Update $SDHNAME https://github.com/smartdeveloperhub/$SDHNAME.git

cd $SDHNAME
sudo docker-compose build
