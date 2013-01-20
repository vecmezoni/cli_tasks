#!/bin/bash

start() {
         ./screenshotd.sh > screenshotd.log 2>&1
        echo 'Screenshot service started.'
        touch /var/lock/screenshotd
        echo
}
stop() {
        killall screenshotd.sh
        echo 'Screenshot service stopped'
        rm -f /var/lock/screenshotd
}
case "$1" in
        start)
                start
                ;;
        stop)
                stop
                ;;
        restart)
                stop
                sleep 5s
                start
                ;;
        *)
                echo $"Usage: $0 {start|stop|restart}"
                exit 1
esac
exit 0