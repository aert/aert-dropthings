#!/bin/bash
set -e
LOGFILE=/var/www/aert-webfolder/log/aert-webfolder.log
LOGDIR=$(dirname $LOGFILE)
NUM_WORKERS=3
# user/group to run as
USER=root
GROUP=root
PORT=8060
IP=0.0.0.0
SITE=/usr/share/python/aert-webfolder
cd $SITE
source ./bin/activate
export AERT_WEBFOLDER_CONFIG=/var/www/aert-webfolder/config.ini
test -d $LOGDIR || mkdir -p $LOGDIR
exec ./bin/gunicorn -b $IP:$PORT -w $NUM_WORKERS \
  --user=$USER --group=$GROUP --log-level=debug --log-file=$LOGFILE \
  webfolder.webui.wsgi:application 2>>$LOGFILE
