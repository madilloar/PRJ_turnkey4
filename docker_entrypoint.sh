#!/bin/sh
FILE="/opt/turnkey4/conf/tk4-.cnf"

if [ ! -e ${FILE} ]; then
  cp -r /tmp/src/turnkey4 /opt && \
  cd /opt/turnkey4
fi
exec "$@"
