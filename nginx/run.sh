#!/bin/bash

# Check for php-fpm and build upstream if needed
echo -n "Checking for PHPFPM upstream: "
if [ -n "$PHPFPM_PORT" ]; then
	cat > /etc/nginx/upstream-phpfpm.conf <<EOF
		upstream php {
			server ${PHPFPM_PORT_9000_TCP#tcp://};
		}
EOF
	echo "[YES]"
else
	echo "[NO]"
fi

usr/sbin/nginx -c /etc/nginx/nginx.conf
