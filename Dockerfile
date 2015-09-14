FROM quay.io/ukhomeofficedigital/docker-centos-base

ENV PHPINI_SETTINGS "cgi.fix_pathinfo=0;"

# Install PHP-FPM and libs
RUN yum update -y && \
    yum install -y  \
      php-fpm \
      php-mbstring \
      php-mysql  \
      php-gd \
      php-xml \
      php-intl \
      php-pecl-zendopcache && \
    yum -y clean all

# Configure FPM
RUN sed -i '/^listen = /clisten = 0.0.0.0:9000' /etc/php-fpm.d/www.conf && \
    sed -i '/^listen.allowed_clients/c;listen.allowed_clients =' /etc/php-fpm.d/www.conf && \
    sed -i '/^;catch_workers_output/ccatch_workers_output = yes' /etc/php-fpm.d/www.conf

# Pass the php-fpm error log to stdout
RUN ln -sf /dev/stdout /var/log/php-fpm/error.log

# This is what PHP-FPM listens on.
EXPOSE 9000

# COPY & RUN startup script
COPY start.sh /
CMD /start.sh
