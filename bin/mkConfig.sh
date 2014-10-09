#!/bin/sh
# use $1 as config template; inject node names from showvm

# print usage if no args
[ $# -eq 0 ] && { echo "Usage: $0 node_config_file"; exit 1; }

function parse_yaml {
  local prefix=$2
  local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
  sed -ne "s|^\($s\):|\1|" \
    -e "s|^\($s\)\($w\)$s:$s[\"']\(.*\)[\"']$s\$|\1$fs\2$fs\3|p" \
    -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
  awk -F$fs '{
  indent = length($1)/2;
  vname[indent] = $2;
  for (i in vname) {if (i > indent) {delete vname[i]}}
    if (length($3) > 0) {
      vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
      printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
    }
  }'
}

# TODO: test on existence of config file
# TODO: test on existence of logs
# TODO: find name of config file from logs

HOSTNAMES=($(ack -ho '[0-9a-z]{15} \((?!speed,).*?\)' log/latest/*-run.log | sort | uniq | awk '{print $1}'))
CONFNAMES=($(ack -ho '[0-9a-z]{15} \((?!speed,).*?\)' log/latest/*-run.log | sort | uniq | awk '{print $2}'))
if [ ${#HOSTNAMES[@]} -ne ${#ROLES[@]} ]; then >&2 echo "error"; exit 1; fi

#echo ${HOSTNAMES[0]}
#echo ${ROLES[0]}
#echo ${HOSTNAMES[1]}
#echo ${ROLES[1]}

#cp ${1} hosts.cfg

parse_yaml ${1}
#eval $(parse_yaml hosts.cfg)

# for CONFNAMES
# find CONFNAME{i} in hosts.cfg
# replace with HOSTNAME{i}
# count confnames in file, if not all replaced, warn user

# TODO: add alias to host config file that gets printed in log so showvm works after mkConfig 
#sed -i '' "s/master:/${HOSTNAMES[1]}:/" hosts.cfg
#sed -i '' "s/agent:/${HOSTNAMES[0]}:/" hosts.cfg
