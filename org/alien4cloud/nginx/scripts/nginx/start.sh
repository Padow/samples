#!/bin/bash

start_nginx () {
  if [[ "$(which yum)" != "" ]]
    then
    sudo systemctl start nginx
  elif [[ "$(which apt-get)" != "" ]]
    then
    sudo /etc/init.d/nginx reload
  fi
}

start_nginx
