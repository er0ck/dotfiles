#!/bin/sh
# get latest complete sha from builds.puppetlabs.com
# TODO: optional $1: (master)/stable
latest=`curl -s 'http://builds.puppetlabs.lan/puppet/?C=M;O=D' | grep -ohE '[0-9a-f]{5,40}' | head -n 1`
if [ -n "$latest" ]; then
  numWindowsArtifacts=`curl -s "http://builds.puppetlabs.lan/puppet/${latest}/artifacts/windows/" | grep "<tr>" | wc -l`
  if [ $numWindowsArtifacts -ge 4 ]; then echo $latest; fi
fi
