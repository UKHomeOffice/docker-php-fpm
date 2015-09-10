#!/bin/bash -xe

# Start PHP as PID 1
exec /usr/sbin/php-fpm --nodaemonize -d ${PHPINI_SETTINGS}
