FROM alejandrofcarrera/phusion.maven
MAINTAINER Alejandro F. Carrera

# Exports
ENV HARVESTER_HOME="/opt/scm-harvester"

COPY files/pom.xml $HARVESTER_HOME/pom.xml
COPY files/config.properties $HARVESTER_HOME/config.properties

# Configure runit
ADD ./my_init.d/ /etc/my_init.d/
ONBUILD ./my_init.d/ /etc/my_init.d/

CMD ["/sbin/my_init"]

EXPOSE 80

