FROM java:7
MAINTAINER bghtrbb

ADD assets /tmp

EXPOSE 8989

WORKDIR /data

RUN /tmp/init.sh

ENTRYPOINT ["/graphhopper/start.sh", "-d", "--name=graphhopper", "-p 8990:8989"]
