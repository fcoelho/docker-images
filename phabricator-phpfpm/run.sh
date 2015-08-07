#!/bin/sh

if [ -n "$MAX_UPLOAD_SIZE" ]; then
	sed -i "s/^upload_max_filesize =.*/upload_max_filesize = $MAX_UPLOAD_SIZE/g" /etc/php.ini
	sed -i "s/^post_max_size =.*/post_max_size = $MAX_UPLOAD_SIZE/g" /etc/php.ini

fi

perl >>/etc/php-fpm.d/www.conf <<EOF
foreach my \$key (keys %ENV) {
	next if \$key eq "_";
	next if \$key eq "module";
	print "env[\$key] = \\\$\$key\\n";
}
EOF

/usr/sbin/php-fpm --fpm-config /etc/php-fpm.conf
