FROM phusion/baseimage
MAINTAINER Alejandro F. Carrera <alej4fc@gmail.com>

# set UTF-8 locale
RUN locale-gen en_US.UTF-8 && \
    echo 'LANG="en_US.UTF-8"' > /etc/default/locale

RUN apt-get -qq update

# Exports
ENV DEBIAN_FRONTEND="noninteractive" \
	LANGUAGE="en_US.UTF-8" \
	LANG="en_US.UTF-8" \
	LC_ALL="en_US.UTF-8" \
	JAVA_HOME="/usr/lib/jvm/java-7-oracle" \
	MAVEN_FOLDER="apache-maven-3.3.3" \
	MAVEN="http://ftp.cixug.es/apache/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz" \
	HARVESTER_HOME="/opt/ci-harvester"

# Install Java and Libraries.
RUN \
	apt-get update && \
	apt-get install -y curl unzip wget make gcc git gperf bison automake debconf-utils && \
	echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
	add-apt-repository -y ppa:webupd8team/java && \
	apt-get update && \
	apt-get install -y oracle-java7-installer && \
	apt-get install -y oracle-java7-set-default && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk7-installer

# Install Maven
RUN \
	curl -L "$MAVEN" -o $(basename "$MAVEN") && \
	tar -zxvf $(basename "$MAVEN") && \
	rm $(basename "$MAVEN") && \
	cp -r $MAVEN_FOLDER/bin /usr/local/ && \
	cp -r $MAVEN_FOLDER/boot /usr/local/ && \
	cp -r $MAVEN_FOLDER/conf /usr/local/ && \
	cp -r $MAVEN_FOLDER/lib /usr/local/ && \
	rm -rf $MAVEN_FOLDER

COPY files/pom.xml $HARVESTER_HOME/pom.xml

# Configure runit
ADD ./my_init.d/ /etc/my_init.d/
ONBUILD ./my_init.d/ /etc/my_init.d/

CMD ["/sbin/my_init"]

EXPOSE 80

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

