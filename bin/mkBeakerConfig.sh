#!/bin/sh
# use $1 as config template; inject node names from showvm
# TODO: add alias to host config file that gets printed in log so showvm works after mkConfig
# TODO: find name of config file from logs

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

[ -f log/latest/*-run.log ] || { echo "no logs found"; exit 3; }
HOSTNAMES=($(ack -oh '[0-9a-z]{15} \((?!speed,).*?\)' log/latest/*-run.log | sort | uniq | awk '{print $1}'))
CONFNAMES=($(ack -oh '[0-9a-z]{15} \((?!speed,).*?\)' log/latest/*-run.log | sort | uniq | awk '{print $2}'))
#echo  ${#HOSTNAMES[@]}
#echo  ${#CONFNAMES[@]}

if [ ${#HOSTNAMES[@]} -ne ${#CONFNAMES[@]} ]; then echo "problem reading log/latest/*-run.log"; exit 1; fi

#echo ${HOSTNAMES[0]}
#echo ${CONFNAMES[0]}
#echo ${HOSTNAMES[1]}
#echo ${ROLES[1]}

[ -f ${1} ] || { echo "config file '${1}' not found"; exit 2; }
cp ${1} hosts.cfg

#parse_yaml hosts.cfg
#eval $(parse_yaml hosts.cfg)

# TODO count confnames in file, if not all repla`ced, warn user
# grep  -ce '    .{15}' hosts.cfg

# for CONFNAMES
i=0
for THISCONF in "${CONFNAMES[@]}"; do
  # strip the parens
  TEMPCONF=($(echo ${THISCONF} | cut -d "(" -f 2))
  TEMPCONF=($(echo ${TEMPCONF}     | cut -d ")" -f 1))
  #echo ${TEMPCONF}
  # substitute CONFNAME{i} in hosts.cfg in place with HOSTNAME{i}
  sed -i '' "s/^  ${TEMPCONF}:$/  ${HOSTNAMES[i]}:/" hosts.cfg
  ((i = i + 1))
done

