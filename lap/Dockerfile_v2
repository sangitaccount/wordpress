FROM ubuntu:14.04
MAINTAINER SantoshChituprolu

ENV WORDPRESS_DB_NAME wordpressdb
ENV WORDPRESS_DB_HOST wordpressdb
ENV WORDPRESS_DB_USER wordpress
ENV WORDPRESS_DB_PASSWORD wordpress

ARG DEBIAN_FRONTEND=noninteractive

RUN \
    apt-get update && \
    apt-get install -y language-pack-en-base && \
    export LC_ALL=en_US.UTF-8 && \
    export LANG=en_US.UTF-8 && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:ondrej/php

RUN \
    apt-get update && \
    apt-get install -y apache2 apache2-utils curl && \
    apt-get install -y php libapache2-mod-php php-mcrypt php-mysql php-cli php-gd php-cgi && \
    rm -r /var/lib/apt/lists/*

#ADD http://wordpress.org/latest.tar.gz /tmp/

COPY install_wordpress.sh /root/install_wordpress.sh
RUN chmod +x /root/install_wordpress.sh

VOLUME [ "/var/www/html" ]
WORKDIR /var/www/html

#COPY wp-config.php /var/www/html/wp-config.php
#CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

CMD ["/root/install_wordpress.sh"]

EXPOSE 80
