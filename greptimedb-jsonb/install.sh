#!/bin/bash

RELEASE_VERSION=v1.1.4

# download greptimedb
wget -N "https://github.com/GreptimeTeam/greptimedb/releases/download/${RELEASE_VERSION}/greptime-linux-amd64-${RELEASE_VERSION}.tar.gz"
tar xzf greptime-linux-amd64-${RELEASE_VERSION}.tar.gz
mv greptime-linux-amd64-${RELEASE_VERSION}/greptime ./
rm -rf greptime-linux-amd64-${RELEASE_VERSION}
