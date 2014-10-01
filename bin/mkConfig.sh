#!/bin/sh
# use $1 as config template; inject node names from showvm

# print usage if no args
[ $# -eq 0 ] && { echo "Usage: $0 node_config_file"; exit 1; }

# TODO: test on existence of config file
# TODO: test on existence of logs
# TODO: find name of config file from logs

HOSTNAMES=($(grep -oE "[0-9a-z]{15} \(.*?\)" log/latest/*-run.log | sort | uniq | awk '{print $1}')) 
ROLES=($(grep -oE "[0-9a-z]{15} \(.*?\)" log/latest/*-run.log | sort | uniq | awk '{print $2}')) 
#echo ${HOSTNAMES[0]}
#echo ${ROLES[0]}
#echo ${HOSTNAMES[1]}
#echo ${ROLES[1]}

cp ${1} temp.cfg

sed -i '' "s/master:/${HOSTNAMES[0]}:/" temp.cfg
sed -i '' "s/agent:/${HOSTNAMES[1]}:/" temp.cfg
