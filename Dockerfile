FROM maven:3-jdk-7

MAINTAINER Golfen Guo "golfen.guo@daocloud.io"

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

ENV TOMCAT_MAJOR 7
ENV TOMCAT_VERSION 7.0.64
ENV TOMCAT_TGZ_URL https://www.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz

RUN curl -sSL "$TOMCAT_TGZ_URL" -o tomcat.tar.gz \
        && tar -xf tomcat.tar.gz --strip-components=1 \
        && rm bin/*.bat \
        && rm tomcat.tar.gz*

# Prepare settings.xml for internal Maven reposiroty
ONBUILD ADD settings.xml /root/.m2/settings.xml

# Expose port
EXPOSE 8080

# Start Tomcat
WORKDIR $CATALINA_HOME
CMD ["catalina.sh", "run"]
