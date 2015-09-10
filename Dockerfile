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

# Pass the php-fpm error log to stdout
RUN ln -sf /dev/stdout /var/log/php-fpm.log

# This is what PHP-FPM listens on.
EXPOSE 9000

# COPY & RUN startup script
COPY start.sh /
CMD /start.sh
