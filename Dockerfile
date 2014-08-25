#
# Based off of https://github.com/dockerfile/java
#

# Pull base image.
FROM dockerfile/ubuntu
MAINTAINER Nikhil Vaze

# Install Java.
RUN \
  echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java7-installer

# Define JETTY_VERSION
ENV JETTY_VERSION 8.1.15.v20140411

# Jetty
RUN adduser --system jetty

RUN mkdir /opt/jetty

# Install wget
RUN apt-get install wget -y

# Grab jetty
RUN wget -O /tmp/jetty.tar.gz http://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/$JETTY_VERSION/jetty-distribution-$JETTY_VERSION.tar.gz

# Untar and place in /opt/jetty
RUN tar xfz /tmp/jetty.tar.gz -C /tmp; cp -Rf /tmp/jetty-distribution-$JETTY_VERSION/* /opt/jetty

RUN chown -R jetty /opt/jetty


# Define default command.
CMD ["/opt/jetty/bin/jetty.sh", "run"]
