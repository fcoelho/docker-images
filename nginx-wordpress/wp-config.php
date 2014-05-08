<?php

define('DB_NAME', getenv('MYSQL_DATABASE_NAME'));
define('DB_USER', getenv('MYSQL_DATABASE_USER'));
define('DB_PASSWORD', getenv('MYSQL_DATABASE_PASSWORD'));
define('DB_HOST', getenv('MYSQL_DATABASE_HOST'));
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

define('AUTH_KEY',         '{{random_string()}}');
define('SECURE_AUTH_KEY',  '{{random_string()}}');
define('LOGGED_IN_KEY',    '{{random_string()}}');
define('NONCE_KEY',        '{{random_string()}}');
define('AUTH_SALT',        '{{random_string()}}');
define('SECURE_AUTH_SALT', '{{random_string()}}');
define('LOGGED_IN_SALT',   '{{random_string()}}');
define('NONCE_SALT',       '{{random_string()}}');

$table_prefix  = 'wp_';
define('WPLANG', '');
define('WP_DEBUG', false);

if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

require_once(ABSPATH . 'wp-settings.php');
