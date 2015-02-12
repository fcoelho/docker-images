#!/bin/sh

if [ -n "$MAX_UPLOAD_SIZE" ]; then
	sed -i "s/upload_max_filesize =.*/upload_max_filesize = $MAX_UPLOAD_SIZE/g" /etc/php5/fpm/php.ini
	sed -i "s/post_max_size =.*/post_max_size = $MAX_UPLOAD_SIZE/g" /etc/php5/fpm/php.ini

	/phabricator/phabricator/bin/config set storage.upload-size-limit "$MAX_UPLOAD_SIZE"
fi

perl >>/etc/php5/fpm/pool.d/www.conf <<EOF
foreach my \$key (keys %ENV) {
	next if \$key eq "_";
	next if \$key eq "module";
	print "env[\$key] = \\\$\$key\\n";
}
EOF

/usr/sbin/php5-fpm --fpm-config /etc/php5/fpm/php-fpm.conf
