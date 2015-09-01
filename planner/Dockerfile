FROM alejandrofcarrera/phusion.python
MAINTAINER Alejandro F. Carrera

ENV HOME /usr/lib/agora
ADD ./files/ont.ttl /usr/lib/agora/ont.ttl
ENV CONFIG agora.planner.server.config.ProductionConfig

# Create directories & virtual env for the Planner
RUN virtualenv $HOME/.env
WORKDIR /usr/lib/agora

# Configure runit
ADD ./my_init.d/ /etc/my_init.d/
ONBUILD ./my_init.d/ /etc/my_init.d/

CMD ["/sbin/my_init"]

VOLUME ["/usr/lib/agora"]
EXPOSE 5000
