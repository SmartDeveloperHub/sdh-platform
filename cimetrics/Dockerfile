FROM alejandrofcarrera/phusion.python
MAINTAINER Alejandro F. Carrera

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
