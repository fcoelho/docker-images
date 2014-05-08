#!/bin/sh

perl >>/etc/php5/fpm/pool.d/www.conf <<EOF
foreach my \$key (keys %ENV) {
	next if \$key eq "_";
	next if \$key eq "module";
	print "env[\$key] = \\\$\$key\\n";
}
EOF

/usr/sbin/php5-fpm --fpm-config /etc/php5/fpm/php-fpm.conf
