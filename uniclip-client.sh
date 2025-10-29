#!/bin/bash
PIDFILE=/var/lock/uniclip.pid
remove_pidfile()
{
  rm -f "$PIDFILE"
}
another_instance()
{
  #echo "run uniclip 192.168.0.40:53701 on client"
  echo "There is another instance running, exiting"
  exit 1
}
if [ -f "$PIDFILE" ]; then
  kill -0 "$(cat $PIDFILE)" && another_instance
fi
trap remove_pidfile EXIT

echo $$ > "$PIDFILE"

#if [ "$(pgrep uniclip)" != $$ ]; then #$$ = the process ID of the current shell.
if pgrep -x "uniclip" > /dev/null
then
     another_instance
fi

cd /home/hgode/bin/uniclip/
./uniclip -d 192.168.0.40:53701 &
echo "uniclip 192.168.0.40:53701 started"

