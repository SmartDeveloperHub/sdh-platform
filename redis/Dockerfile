FROM ubuntu:14.04
RUN apt-get update && apt-get install -y redis-server

# Database with gitlab information
COPY dump_db0_gitlab.rdb /dump.rdb

EXPOSE 6379
ENTRYPOINT ["/usr/bin/redis-server"]
