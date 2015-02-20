FROM dockerfile/java:oracle-java7
MAINTAINER bghtrbb, na@na.com

ADD assets /tmp

VOLUME ["/data"]

EXPOSE 8989

WORKDIR /data

RUN /tmp/init.sh
