#!/usr/bin/env bash

echo "$(date --iso=ns): wait for zookeeper to start up"
zkServer.sh status
exitCode=$?
if [ $exitCode -ne 0 ]; then
    echo "zkServer.sh status exitCode: $exitCode"
    sleep 1
    exit
else
    echo "zookeeper started, about to start kafka"
    /opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties
    echo "kafka stoppppppppppppppppppppppppppppppppppppppppppppppppppppped"
fi
