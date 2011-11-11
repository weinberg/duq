#!/bin/bash
#
# duqd  This starts and stops duqd
#
# chkconfig: 2345 12 88
# description: duqd is the daemon process for duq which performs quick du operations.
# processname: duqd
# pidfile: /var/run/duqd.pid
### BEGIN INIT INFO
# Provides: $duqd
### END INIT INFO

# Source function library.
. /etc/init.d/functions

binary="/path/to/duqd"

[ -x $binary ] || exit 0

RETVAL=0

start() {
    echo -n "Starting duqd: "
    daemon $binary
    RETVAL=$?
    PID=$!
    echo
    [ $RETVAL -eq 0 ] && touch /var/lock/subsys/duqd

    echo $PID > /var/run/duqd.pid
}

stop() {
    echo -n "Shutting down duqd: "
    killproc duqd
    RETVAL=$?
    echo
    if [ $RETVAL -eq 0 ]; then
        rm -f /var/lock/subsys/duqd
        rm -f /var/run/duqd.pid
    fi
}

restart() {
    echo -n "Restarting duqd: "
    stop
    sleep 2
    start
}

case "$1" in
    start)
        start
    ;;
    stop)
        stop
    ;;
    status)
        status duqd
    ;;
    restart)
        restart
    ;;
    *)
        echo "Usage: $0 {start|stop|status|restart}"
    ;;
esac

exit 0
