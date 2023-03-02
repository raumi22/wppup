#!/bin/bash

# Set unique key phrases
AUTH_KEY=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 64 ; echo '')
SECURE_AUTH_KEY=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 64 ; echo '')
LOGGED_IN_KEY=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 64 ; echo '')
NONCE_KEY=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 64 ; echo '')
AUTH_SALT=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 64 ; echo '')
SECURE_AUTH_SALT=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 64 ; echo '')
LOGGED_IN_SALT=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 64 ; echo '')
NONCE_SALT=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 64 ; echo '')

# Find and replace key phrases in wp-config.php file
if [ -f /var/www/html/wordpress/wp-config.php ]; then
  sed -i "s/define( 'AUTH_KEY',         'put your unique phrase here' );/define( 'AUTH_KEY', '$AUTH_KEY' );/" /var/www/html/wordpress/wp-config.php
  sed -i "s/define( 'SECURE_AUTH_KEY',  'put your unique phrase here' );/define( 'SECURE_AUTH_KEY', '$SECURE_AUTH_KEY' );/" /var/www/html/wordpress/wp-config.php
  sed -i "s/define( 'LOGGED_IN_KEY',    'put your unique phrase here' );/define( 'LOGGED_IN_KEY', '$LOGGED_IN_KEY' );/" /var/www/html/wordpress/wp-config.php
  sed -i "s/define( 'NONCE_KEY',        'put your unique phrase here' );/define( 'NONCE_KEY', '$NONCE_KEY' );/" /var/www/html/wordpress/wp-config.php
  sed -i "s/define( 'AUTH_SALT',        'put your unique phrase here' );/define( 'AUTH_SALT', '$AUTH_SALT' );/" /var/www/html/wordpress/wp-config.php
  sed -i "s/define( 'SECURE_AUTH_SALT', 'put your unique phrase here' );/define( 'SECURE_AUTH_SALT', '$SECURE_AUTH_SALT' );/" /var/www/html/wordpress/wp-config.php
  sed -i "s/define( 'LOGGED_IN_SALT',   'put your unique phrase here' );/define( 'LOGGED_IN_SALT',   '$LOGGED_IN_SALT' );/" /var/www/html/wordpress/wp-config.php
  sed -i "s/define( 'NONCE_SALT',       'put your unique phrase here' );/define( 'NONCE_SALT',       '$NONCE_SALT' );/" /var/www/html/wordpress/wp-config.php
  sed -i "s/<?php/<?php\ndefine('WP_FAIL2BAN_PROXIES','10.1.0.100');\nif (\$_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https') \$_SERVER['HTTPS']='on';/" /var/www/html/wordpress/wp-config.php
else
  echo "wp-config.php file not found in /var/www/html/wordpress directory."
fi
