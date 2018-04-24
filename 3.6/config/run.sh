#!/bin/bash
set -m

mongodb_cmd="mongod --storageEngine $STORAGE_ENGINE"
cmd="$mongodb_cmd --bind_ip_all"
if [ "$AUTH" == "yes" ]; then
    cmd="$cmd --auth"
fi

if [ "$JOURNALING" == "no" ]; then
    cmd="$cmd --nojournal"
fi

if [ "$OPLOG_SIZE" != "" ]; then
    cmd="$cmd --oplogSize $OPLOG_SIZE"
fi

DT_BEGIN=`date`;
echo "******************************************************************************"
echo " WENIT MONGO DB                                                               "
echo " STARTING: $DT_BEGIN                                                          "
echo "******************************************************************************"
echo " Inicializando com as opções:                                                 "
echo " > STORAGE_ENGINE: $STORAGE_ENGINE                                            "
echo " > AUTH: $AUTH                                                                "
echo " > JOURNALING: $JOURNALING                                                    "
echo " > OPLOG_SIZE: $OPLOG_SIZE                                                    "
echo " > CUSTOM_SCRIPT: $CUSTOM_SCRIPT                                              "
echo "******************************************************************************"

$cmd &

if [ ! -f /data/configdb/.setup ]; then
    /setup.sh
fi

if [ -f $CUSTOM_SCRIPT ]; then
    $CUSTOM_SCRIPT
fi

fg