FROM ubuntu:trusty
MAINTAINER Santosh

RUN apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*

RUN \
    mkdir -p /etc/nginx/sites-available && \
    mkdir -p /etc/nginx/sites-enabled

COPY wp /etc/nginx/sites-available/wp
RUN ln -s /etc/nginx/sites-available/wp /etc/nginx/sites-enabled/wp

ENTRYPOINT ["/usr/sbin/nginx"]
CMD ["-g","daemon off;"]

EXPOSE 80
