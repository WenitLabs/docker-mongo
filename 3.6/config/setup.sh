#!/bin/bash

PASS=${MONGODB_ADMIN_PASS:-$(pwgen -s 12 1)}
_word=$( [ ${MONGODB_ADMIN_PASS} ] && echo "preset" || echo "random" )

DT_BEGIN=`date`;
echo "******************************************************************************"
echo " WENIT MONGO DB                                                               "
echo " STARTING: $DT_BEGIN                                                          "
echo "******************************************************************************"
echo " Configurando acesso administrativo                                           "
echo " > MONGODB_ADMIN_PASS: $_word                                                 "
echo "******************************************************************************"

RET=1
while [[ RET -ne 0 ]]; do
    echo " > Waiting for confirmation of MongoDB service startup"
    sleep 5
    mongo admin --eval "help" >/dev/null 2>&1
    RET=$?
done

if [ "$_word" == "random" ]; then
    echo "$PASS" >> /data/configdb/.admin_random
    echo " > Random pass was generated in /data/configdb/.admin_random"
    echo " > Run this command from the host:"
    echo " > docker exec [container id] cat /data/configdb/.admin_random"
fi

mongo admin --eval "db.createUser({user: 'admin', pwd: '$PASS', roles:[{role:'root',db:'admin'}]});" && \
touch /data/configdb/.setup
