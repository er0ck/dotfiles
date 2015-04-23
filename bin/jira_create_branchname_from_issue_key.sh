#!/bin/sh
# eg: $1 == PUP-1234

#print the ticket number followed by dash
TICKET=`echo ${1} | tr '[:lower:]' '[:upper:]'`
echo "${TICKET}-`jira_get_issue_summary.sh ${1}`" | sed -e 's/ /_/g'
