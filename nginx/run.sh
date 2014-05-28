#!/bin/bash

UPSTREAMS_FILE=/etc/nginx/upstreams.conf
REGEX="(.*_UPSTREAM)_PORT=tcp://(.*)$"

function write_upstream {
	echo -n "Installing upstream $1:$2"
	cat >> $UPSTREAMS_FILE <<EOF
		upstream $1 {
			server $2;
		}
EOF
}

# Always start with an empty file
echo > $UPSTREAMS_FILE
env | while read name; do
	[[ $name =~ $REGEX ]]
	if [ -n "${BASH_REMATCH[1]}" ]; then
		write_upstream ${BASH_REMATCH[1]} ${BASH_REMATCH[2]}
	fi
done


/usr/sbin/nginx -c /etc/nginx/nginx.conf
