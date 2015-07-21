FROM phusion/baseimage
MAINTAINER Fernando Serena

# set UTF-8 locale
RUN locale-gen en_US.UTF-8 && \
    echo 'LANG="en_US.UTF-8"' > /etc/default/locale

RUN apt-get -qq update

# Install required packages
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq -y install \
        python-minimal \
        python-dev \
        python-virtualenv \
        libevent-dev \
        libpq-dev \
        libxml2-dev \
        libxslt1-dev \
        build-essential

# Install required packages
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq -y install \
        apache2 \
        libapache2-mod-wsgi \
        postfix \
        git \
        libgeos-c1 \
        supervisor

ENV HOME /usr/lib/metrics
ENV CONFIG sdh.metrics.ci.config.ProductionConfig

# Create directories & virtual env for the Planner
RUN virtualenv $HOME/.env
WORKDIR /usr/lib/metrics

# Configure runit
ADD ./my_init.d/ /etc/my_init.d/
ONBUILD ./my_init.d/ /etc/my_init.d/

CMD ["/sbin/my_init"]

VOLUME ["/usr/lib/metrics"]
EXPOSE 5003

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

