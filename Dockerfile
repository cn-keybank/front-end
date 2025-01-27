FROM ubuntu:16.04

# Update Ubuntu
RUN apt-get update ; apt-get dist-upgrade -y -qq 

# Install Apache + modules
RUN apt-get install -y -qq apache2 && \
    a2enmod proxy proxy_http proxy_ajp rewrite deflate headers proxy_connect proxy_html lbmethod_byrequests && \
    mkdir /var/lock/apache2 && mkdir /var/run/apache2

# Config Apache
COPY index.html /var/www/html/index.html
COPY keybank_logo.jpg /var/www/html/keybank_logo.jpg
COPY keybank_cloud.jpg /var/www/html/keybank_cloud.jpg
COPY 000-default.conf  /etc/apache2/sites-enabled/000-default.conf

EXPOSE 80
CMD apache2ctl -D FOREGROUND
