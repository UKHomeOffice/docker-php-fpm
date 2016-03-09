FROM quay.io/ukhomeofficedigital/centos-base

# Pass the php-fpm error log to stdout
RUN ln -sf /dev/stderr /var/log/php-fpm.log && \
    ln -sf /dev/stderr /var/log/php-fpm/www-error.log && \
    ln -sf /dev/stderr /var/log/php-fpm/error.log && \
    ln -sf /dev/stderr /var/log/php-fpm/www-slow.log && \

# Install PHP-FPM and libs
    yum install -y  \
      php-fpm \
      php-mbstring \
      php-mysql  \
      php-gd \
      php-xml \
      php-intl \
      php-apc \
      php-cli && \
    yum -y clean all && \
    sed -e 's/listen = 127.0.0.1:9000/listen = \/var\/run\/php-fpm\/php-fpm.socket/' -i /etc/php-fpm.d/www.conf

# Pass default CMD
CMD ["/usr/sbin/php-fpm", "--nodaemonize", "-d", "cgi.fix_pathinfo=0;"]
