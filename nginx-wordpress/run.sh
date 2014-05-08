#!/bin/bash

sed -i "s/PHP_FPM_ADDRESS/$PHPFPM_BACKEND_HOST:$PHPFPM_BACKEND_PHPFPM_PORT/g" /etc/nginx/nginx.conf
sed -i "s/WORDPRESS_SERVER_NAME/${WORDPRESS_SERVER_NAME:-_}/g" /etc/nginx/conf.d/wordpress.conf

if [ ! -e /wordpress/index.php ]; then
	cd /wordpress

	# download new wordpress
	rm -rf /wordpress/*
	curl http://wordpress.org/latest.tar.gz | tar xzf -
	mv wordpress/* .
	rm -rf wordpress
fi

if [ ! -e /wordpress/wp-config.php ]; then
	# use jinja2 to create all the keys the application needs
	# this only happens when the volume is populated the first time,
	# not every time the container is rebuilt
	python - <<EOF
import jinja2, random, string

def random_string():
	chars = string.letters + string.digits + string.punctuation
	chars = chars.translate(None, '\\'\\\\"')
	
	length = 64
	return ''.join(random.choice(chars) for _ in range(length))

base = '/wp-config.php'
config = '/wordpress/wp-config.php'

template = jinja2.Template(open(base).read())
with open(config, 'w') as f:
    f.write(template.render(random_string=random_string))
EOF
fi

# start nginx, finally
/usr/sbin/nginx
