FROM phusion/baseimage
MAINTAINER Alejandro F. Carrera <alej4fc@gmail.com>

# set UTF-8 locale
RUN locale-gen en_US.UTF-8 && \
    echo 'LANG="en_US.UTF-8"' > /etc/default/locale

RUN apt-get -qq update

# Exports
ENV CATALINA_HOME="/opt/tomcat" \
	DEBIAN_FRONTEND="noninteractive" \
	LANGUAGE="en_US.UTF-8" \
	LANG="en_US.UTF-8" \
	LC_ALL="en_US.UTF-8" \
	JAVA_HOME="/usr/lib/jvm/java-7-oracle" \
	TOMCAT_FOLDER="apache-tomcat-7.0.63" \
	TOMCAT="http://apache.rediris.es/tomcat/tomcat-7/v7.0.63/bin/apache-tomcat-7.0.63.tar.gz" \
	MAVEN_FOLDER="apache-maven-3.3.3" \
	MAVEN="http://ftp.cixug.es/apache/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz"
ENV PATH $CATALINA_HOME/bin:$PATH

# Install Java and Libraries.
RUN \
	apt-get update && \
	apt-get install -y curl unzip wget git nano && \
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

# Install Tomcat 7
RUN \
	curl -L "$TOMCAT" -o $(basename "$TOMCAT") && \
	tar -zxvf $(basename "$TOMCAT") && \
	rm $(basename "$TOMCAT") && \
	mv $TOMCAT_FOLDER $CATALINA_HOME && \
	rm $CATALINA_HOME/bin/*.bat
COPY files/tomcat-users.xml $CATALINA_HOME/conf/tomcat-users.xml

WORKDIR $CATALINA_HOME/webapps
COPY files/pom.xml pom.xml
COPY files/web.xml web.xml

# Configure runit
ADD ./my_init.d/ /etc/my_init.d/
ONBUILD ./my_init.d/ /etc/my_init.d/

CMD ["/sbin/my_init"]

EXPOSE 8080

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

