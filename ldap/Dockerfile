FROM phusion/baseimage
MAINTAINER Alejandro F. Carrera <alej4fc@gmail.com>

# Exports
ENV VAGRANT_PROV="provisioning" \
	VAGRANT_CONF="configuration" \
	LDAP_SERVER="sdh" \
	LDAP_DOMAIN="ldap.smartdeveloperhub.org" \
	LDAP_PASSWD="ldapsdh12345" \
	APACHE_RUN_USER="www-data" \
	APACHE_RUN_GROUP="www-data" \
	APACHE_LOG_DIR="/var/log/apache2" \
	APACHE_PID_FILE="/var/run/apache2.pid" \
	APACHE_RUN_DIR="/var/run/apache2" \
	APACHE_LOCK_DIR="/var/lock/apache2" \
	APACHE_SERVERADMIN="admin@$LDAP_DOMAIN" \
	APACHE_SERVERNAME="$LDAP_SERVER" \
	APACHE_SERVERALIAS="docker.sdh" \
	APACHE_DOCUMENTROOT="/usr/share/phpldapadmin/htdocs" \
	DEBIAN_FRONTEND="noninteractive" \
	LANGUAGE="en_US.UTF-8" \
	LANG="en_US.UTF-8"

# Language Environment
COPY $VAGRANT_PROV/bash.bashrc /etc/bash.bashrc
COPY $VAGRANT_PROV/lang.sh /etc/profile.d/lang.sh
RUN apt-get -qq update && apt-get install -qq -y apt-utils locales && locale-gen en_US.UTF-8

# Dependencies
RUN apt-get -qq -y install \ 
	build-essential \
	openssh-server \
	pkg-config \
	cmake \
        nano

# Install - LDAP
RUN echo "slapd slapd/internal/adminpw password $LDAP_PASSWD" | debconf-set-selections \
	&& echo "slapd slapd/password1 password $LDAP_PASSWD" | debconf-set-selections \
	&& echo "slapd slapd/password2 password $LDAP_PASSWD" | debconf-set-selections \
	&& echo "slapd slapd/internal/generated_adminpw password $LDAP_PASSWD" | debconf-set-selections \
	&& echo "slapd shared/organization string $LDAP_SERVER" | debconf-set-selections \
	&& echo "slapd slapd/domain string $LDAP_DOMAIN" | debconf-set-selections
RUN apt-get -q -y install slapd ldapscripts phpldapadmin
RUN echo "$LDAP_PASSWD" > /etc/ldapscripts/ldapscripts.passwd
RUN chmod 400 /etc/ldapscripts/ldapscripts.passwd
COPY $VAGRANT_CONF/conf_ldap /etc/ldap/ldap.conf

# Install - LDAP Admin
COPY $VAGRANT_CONF/conf_php /etc/phpldapadmin/config.php
RUN chmod +x /etc/phpldapadmin/config.php
COPY $VAGRANT_CONF/conf_apache /etc/apache2/sites-enabled/000-default.conf
RUN service slapd restart && service apache2 restart

# Ports
EXPOSE 80 389 636

# Init Apache & LDAP
ADD $VAGRANT_CONF/init/ /etc/my_init.d/
ONBUILD COPY _etc/my_init.d/ /etc/my_init.d/
RUN chmod +x /etc/my_init.d/*
CMD ["/sbin/my_init"]
	
# Clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
