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

# Copy the PHP config files into etc
COPY conf/* /etc/

# COPY & RUN startup script
COPY start.sh /
CMD /start.sh
