#!/bin/bash

echo "Whee!"

mustache /data/data.json /caddy/template.mustache /etc/Caddyfile

cat /etc/Caddyfile

