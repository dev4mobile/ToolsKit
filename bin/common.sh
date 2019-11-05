#!/bin/sh
set -e

# query route ip
route_ip=`ip route | awk '/default/{print $3}'`
echo "route ip is:$route_ip"
