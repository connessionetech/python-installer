#!/bin/bash
# chkconfig: 345 85 15

# source function lib
. /etc/init.d/functions 

start(){
    echo -n "Starting pysetenv"
    nohup /usr/local/bin/pysetenv
    touch /var/lock/subsys/pysetenv
    return 0
}

# stop(){
#     echo -n "Shutting down pysetenv"
#     nohup 
# }