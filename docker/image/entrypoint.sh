#!/bin/sh

echo $SAMZA_JOB_CONFIG > /samza/job.json

export SAMZA_COORDINATOR_URL="file:///samza/job.json"
export SAMZA_LOG_DIR="/samza/log"

cd /samza/bin
ls start-playing.sh

if [ $? -eq 0 ] ; then
  exec /samza/bin/start-playing.sh
else
  exec /samza/bin/run-wikipedia-zk-application.sh
fi
