FROM phusion/baseimage
MAINTAINER Alejandro F. Carrera <alej4fc@gmail.com>

# set UTF-8 locale
RUN locale-gen en_US.UTF-8 && \
    echo 'LANG="en_US.UTF-8"' > /etc/default/locale

RUN apt-get -qq update

# Install required packages and node
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq -y install \
        build-essential curl pkg-config supervisor \
        cmake git nodejs npm

RUN ln -s /usr/bin/nodejs /usr/bin/node
ADD ./files/config.json /home/config.json
ADD ./files/swagger.json /home/swagger.json

# Configure runit
ADD ./my_init.d/ /etc/my_init.d/
ONBUILD ./my_init.d/ /etc/my_init.d/

CMD ["/sbin/my_init"]

WORKDIR /usr/lib

EXPOSE 8080

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

