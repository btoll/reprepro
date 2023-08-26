#!/usr/bin/bash

set -eux

umask 022

apt-get update && \
apt-get install -y \
    curl \
    git \
    nginx \
    reprepro \
    tree

locale-gen en_US.UTF-8
localectl set-locale LANG=en_US.UTF-8

PORT=${PORT:-80}
REPO_DIR=${REPO_DIR:-base}

cat << EOF > /etc/nginx/sites-available/default
server {
    listen      $PORT;
    root		/home/vagrant/$REPO_DIR;

    access_log              /tmp/nginx_host.access.log;
    error_log 	            /tmp/nginx_host.error.log;
    client_body_temp_path   /tmp/client_body;
    fastcgi_temp_path       /tmp/fastcgi_temp;
    proxy_temp_path         /tmp/proxy_temp;
    scgi_temp_path          /tmp/scgi_temp;
    uwsgi_temp_path         /tmp/uwsgi_temp;

    ## Prevent access to Reprepro's files
    location ~ /(db|conf) {
        deny 		all;
        return 		404;
    }
}
EOF
systemctl restart nginx

echo "StreamLocalBindUnlink yes" >> /etc/ssh/sshd_config
systemctl restart sshd

# Fixes the "-bash: warning: setlocale: LC_ALL: cannot change locale (en_IN.UTF-8)" warning.
# Also, fixes the same warnings for Perl.
localedef -i en_US -f UTF-8 en_US.UTF-8

su -c "source /vagrant/scripts/user.sh" vagrant

