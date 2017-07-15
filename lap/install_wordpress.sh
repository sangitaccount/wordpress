#!/bin/bash

FILE=$1
SALT=`curl https://api.wordpress.org/secret-key/1.1/salt/`

curl -SL http://wordpress.org/latest.tar.gz | tar -xzC /tmp/ 
mv /tmp/wordpress/* /var/www/html/ 
rm -rf /tmp/wordpress 
rm -rf /var/www/html/index.html

cd /var/www/html

sed -i "/define('DB_NAME'/c\define('DB_NAME',$WORDPRESS_DB_NAME);" wp-config-sample.php
sed -i "/define('DB_USER'/c\define('DB_USER',$WORDPRESS_DB_USER);" wp-config-sample.php
sed -i "/define('DB_PASSWORD'/c\define('DB_PASSWORD',$WORDPRESS_DB_PASSWORD);" wp-config-sample.php
sed -i "/define('DB_HOST'/c\define('DB_HOST',$WORDPRESS_DB_HOST);" wp-config-sample.php

LINE_NUMBER=`grep -n "define('AUTH_KEY'" wp-config-sample.php | cut -d ':' -f1`

sed -i "/define('AUTH_KEY'/d" wp-config-sample.php
sed -i "/define('SECURE_AUTH_KEY'/d" wp-config-sample.php
sed -i "/define('LOGGED_IN_KEY'/d" wp-config-sample.php
sed -i "/define('NONCE_KEY'/d" wp-config-sample.php
sed -i "/define('AUTH_SALT'/d" wp-config-sample.php
sed -i "/define('SECURE_AUTH_SALT'/d" wp-config-sample.php
sed -i "/define('LOGGED_IN_SALT'/d" wp-config-sample.php
sed -i "/define('NONCE_SALT'/d" wp-config-sample.php

split -l $LINE_NUMBER wp-config-sample.php

cat xaa > wp-config.php
echo $SALT >> wp-config.php
cat xab >> wp-config.php 
rm -rf xa*

mkdir -p /var/www/html/wp-content/uploads
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

/usr/sbin/apache2ctl -D FOREGROUND
