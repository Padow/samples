#!/bin/bash -e
source $commons/commons.sh

require_envs "SHARE_PATH SHARE_NAME"

## create the shared path
sudo mkdir -p $SHARE_PATH
sudo chmod 777 $SHARE_PATH
if [[ "$(which yum)" != "" ]]
  then
    sudo chmod -R 0755 $SHARE_PATH
    sudo chown -R nobody:nobody $SHARE_PATH
    sudo chcon -t samba_share_t $SHARE_PATH
elif [[ "$(which apt-get)" != "" ]]
  then
  sudo chown nobody.nogroup $SHARE_PATH
fi



## build the config file
CONFIG_FILE=/etc/samba/smb.conf
sudo cp $config $CONFIG_FILE
escaped_share_path=$(echo "$SHARE_PATH" | sed 's/\//\\\//g')
sudo sed -i -e "s/SHARE_NAME/$SHARE_NAME/g" $CONFIG_FILE
sudo sed -i -e "s/SHARE_PATH/$escaped_share_path/g" $CONFIG_FILE
