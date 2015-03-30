#!/usr/bin/ksh

case ${1} in;
	'start')
		dladm create-bridge -l e1000g0 vmwarebr
		;;
	'stop')
		dladm remove-bridge -l e1000g0 vmwarebr
		dladm delete-bridge vmwarebr
		;;
	*)
		echo "Usage: ${0} <start|stop>"
		exit 1
		;;
esac

exit 0
