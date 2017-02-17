#!/bin/bash

echo "Whee!"

mustache /data/data.json /etc/caddyfile.mustache /etc/caddyfile

cat /etc/caddyfile

