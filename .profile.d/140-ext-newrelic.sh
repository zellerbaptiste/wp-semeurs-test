export NEW_RELIC_APP_NAME=${NEW_RELIC_APP_NAME:-${HEROKU_APP_NAME:-"PHP Application on Heroku"}}
export NEW_RELIC_LOG_LEVEL=${NEW_RELIC_LOG_LEVEL:-"warning"}
export NEW_RELIC_DAEMON_LOG_LEVEL="$NEW_RELIC_LOG_LEVEL"
if [[ "$NEW_RELIC_DAEMON_LOG_LEVEL" == verbose* || "$NEW_RELIC_DAEMON_LOG_LEVEL" == *debug ]]; then
	NEW_RELIC_DAEMON_LOG_LEVEL="debug"
fi

# The daemon is a started in foreground mode so it will not daemonize
# (i.e. disassociate from the controlling TTY and disappear into the
# background).
# we use the pidfile to wait for it to be up
newrelic_pidfile=/tmp/newrelic-daemon.pid

# daemon start
/app/.heroku/php/bin/newrelic-daemon --watchdog-foreground --port "@newrelic-daemon" --logfile "/dev/stderr" --loglevel "${NEW_RELIC_DAEMON_LOG_LEVEL}" --pidfile "$newrelic_pidfile" &
newrelic_pid=$!

# give it a moment to start up...
while ! test -f "$newrelic_pidfile"; do
	# ...unless it somehow crashes on start, then we have to bail to prevent an infite loop
	if ! kill -0 $newrelic_pid 2> /dev/null; then # kill -0 checks if process exists
		echo "Failed to start newrelic-daemon!" >&2
		break;
	fi
	if [[ "$NEW_RELIC_DAEMON_LOG_LEVEL" == "info" || "$NEW_RELIC_DAEMON_LOG_LEVEL" == "debug" ]]; then
		echo "Waiting for newrelic-daemon..." >&2
	fi
	sleep 0.1
done
