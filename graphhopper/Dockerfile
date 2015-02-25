FROM dockerfile/java:oracle-java7
MAINTAINER bghtrbb

ADD assets /tmp

VOLUME ["/data"]

EXPOSE 8989

WORKDIR /data

RUN /tmp/init.sh

RUN mkdir -p ~/tmp/graphhopper/
RUN cd ~/tmp/graphhopper/
RUN wget https://s3.amazonaws.com/metro-extracts.mapzen.com/charlotte_north-carolina.osm.pbf

ENTRYPOINT ["/tmp/start.sh", "-d", "--name=graphhopper", "-v ~/tmp/graphhopper/:/data", "-p 8990:8989"]
CMD ["/graphhopper/start.sh"]