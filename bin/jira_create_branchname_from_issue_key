#!/bin/sh
# eg: $1 == PUP-1234

#print the ticket number followed by dash
TICKET=`echo ${1} | tr '[:lower:]' '[:upper:]'`

# force to check-ref-format standards, then check it
# https://www.kernel.org/pub/software/scm/git/docs/git-check-ref-format.html
BRANCH=`echo "${TICKET}-\`jira_get_issue_summary.sh ${1}\`" | sed -e 's/[ ~^:?*\[\\.]/_/g'`
echo $BRANCH

# get parent branch name (current branch)
# git rev-parse --abbrev-ref HEAD

# this requires a leading catagory/hierarchical grouping, which we don't yet support in this script
#ref=$(git check-ref-format --normalize "maint/$BRANCH") ||
#die "we do not like '$BRANCH' as a branch name."

#echo $ref
