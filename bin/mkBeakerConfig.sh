#!/bin/sh
# use $1 as config template; inject node names from showvm
# TODO: add alias to host config file that gets printed in log so showvm works after mkConfig
# TODO: find name of config file from logs
# TODO: if no hosts found in logs, look in log for --hosts and look in there

# print usage if no args
[ $# -eq 0 ] && { echo "Usage: $0 node_config_file"; exit 1; }

#[ -f log/latest/*-run.log ] || { echo "no logs found"; exit 3; }
# TODO: store this pattern separtely
# TODO: combine with showvm and killvm, etc
HOSTNAMES=($(ack -oh '[0-9a-z]{15}(\.delivery\.puppetlabs\.net)? \((?!speed,).*?\)' log/latest/*-run.log | sort | uniq | awk '{print $1}'))
CONFNAMES=($(ack -oh '[0-9a-z]{15}(\.delivery\.puppetlabs\.net)? \((?!speed,).*?\)' log/latest/*-run.log | sort | uniq | awk '{print $2}'))
#echo  ${#HOSTNAMES[@]}
#echo  ${#CONFNAMES[@]}

if [ ${#HOSTNAMES[@]} -ne ${#CONFNAMES[@]} ]; then echo "problem reading log/latest/*-run.log"; exit 1; fi

#echo ${HOSTNAMES[0]}
#echo ${CONFNAMES[0]}
#echo ${HOSTNAMES[1]}
#echo ${ROLES[1]}

[ -f ${1} ] || { echo "config file '${1}' not found"; exit 2; }
HOSTS_PRESERVED_FILE='hosts_preserved.cfg'
cp ${1} $HOSTS_PRESERVED_FILE

# TODO count confnames in file, if not all replaced, warn user
# grep  -ce '    .{15}' $HOSTS_PRESERVED_FILE

# for CONFNAMES
i=0
for THISCONF in "${CONFNAMES[@]}"; do
  # strip the parens
  TEMPCONF=($(echo ${THISCONF} | cut -d "(" -f 2))
  TEMPCONF=($(echo ${TEMPCONF} | cut -d ")" -f 1))
  #echo ${TEMPCONF}
  # substitute CONFNAME{i} in $HOSTS_PRESERVED_FILE in place with HOSTNAME{i}
  sed -i '' "s/^  ${TEMPCONF}:$/  ${HOSTNAMES[i]}:/" $HOSTS_PRESERVED_FILE
  ((i = i + 1))
done

