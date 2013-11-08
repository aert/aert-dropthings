#!/bin/bash
set -e
LOGFILE=/opt/aert/webfolder/log/aert-webfolder.log
LOGDIR=$(dirname $LOGFILE)
NUM_WORKERS=3
# user/group to run as
USER=root
GROUP=root
PORT=8060
IP=0.0.0.0
SITE=/opt/aert/webfolder/env
cd $SITE
source ./bin/activate
export AERT_WEBFOLDER_CONFIG=/opt/aert/webfolder/etc/config_vagrant.ini
test -d $LOGDIR || mkdir -p $LOGDIR
exec ./bin/gunicorn -b $IP:$PORT -w $NUM_WORKERS \
  --user=$USER --group=$GROUP --log-level=debug --log-file=$LOGFILE \
  webfolder.webui.wsgi:application 2>>$LOGFILE
