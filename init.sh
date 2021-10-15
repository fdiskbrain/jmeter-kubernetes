#!/usr/bin/env bash
if [ "x$1" = "xmaster" ]; then
    while true; do
        echo master running
        sleep 30
    done
fi
$JMETER_HOME/bin/jmeter-server \
    -Dserver.rmi.localport=50000 \
    -Dserver_port=1099 \
    -Jserver.rmi.ssl.disable=true
