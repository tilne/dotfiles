#!/bin/bash
set -ex
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder
