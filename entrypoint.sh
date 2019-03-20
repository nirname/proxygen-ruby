#!/bin/sh
set -a
[ -f /local/env ] && . /local/env
set +a

./gen routes.yml > /etc/nginx/nginx.conf

exec "$@"
