#!/bin/sh
# eg: $1 == PUP-1234
# requires a .netrc file with creds all up in it

#print the ticket number followed by dash
curl --silent --header "Content-Type: application/json" --netrc "https://tickets.puppetlabs.com/rest/api/2/search?jql=key=${1}" | python -c 'import sys, json; print json.load(sys.stdin)["issues"][0]["fields"]["summary"]'
