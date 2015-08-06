#!/bin/sh

GRAPHHOPPER_DIR=/graphhopper
DATA_DIR=/data
TEMP_DIR=/tmp/
TEMP_GRAPH_DIR=~/tmp/graphhopper/
MAVEN_HOME="$GRAPHHOPPER_DIR/maven"
JAVA=$JAVA_HOME/bin/java
if [ "$JAVA_HOME" = "" ]; then
 JAVA=java
fi

mkdir -p /data
cd /data
#wget http://download.geofabrik.de/europe/germany/hessen-latest.osm.pbf
wget http://download.geofabrik.de/europe/germany/nordrhein-westfalen/koeln-regbez-latest.osm.pbf

echo "Showing contents of ${GRAPHHOPPER_DIR}"
ls $GRAPHHOPPER_DIR

echo "Showing contents of ${DATA_DIR}"
ls $DATA_DIR

OSM_FILE=`ls /data/*.pbf`

if [ -f /data/env.sh  ]; then
    . /data/env.sh
fi

if [ -z "${JAVA_OPTS}" ]; then
    JAVA_OPTS="$JAVA_OPTS -Xms64m -Xmx256m -XX:MaxPermSize=256m -Djava.net.preferIPv4Stack=true"
    JAVA_OPTS="$JAVA_OPTS -server -Djava.awt.headless=true -Xconcurrentio"
    echo "Setting default JAVA_OPTS"
fi

echo "JAVA_OPTS= ${JAVA_OPTS}"

NAME="${OSM_FILE%.*}"
GRAPH=$NAME-gh

export MAVEN_OPTS="$MAVEN_OPTS $JAVA_OPTS"
  if [ "$JETTY_PORT" = "" ]; then  
    JETTY_PORT=8989
  fi
  cd "$GRAPHHOPPER_DIR"
  VERSION=$(grep  "<name>" -A 1 pom.xml | grep version | cut -d'>' -f2 | cut -d'<' -f1)
  WEB_JAR="$GRAPHHOPPER_DIR/web/target/graphhopper-web-$VERSION-with-dep.jar"
  if [ ! -s "$WEB_JAR" ]; then         
    "$MAVEN_HOME/bin/mvn" --projects web -DskipTests=true install assembly:single > /tmp/graphhopper-web-compile.log
    returncode=$?
    if [[ $returncode != 0 ]] ; then
      echo "## compilation of web failed"
      cat /tmp/graphhopper-web-compile.log
      exit $returncode
    fi
  fi

  RC_BASE=./web/src/main/webapp

    exec "$JAVA" $JAVA_OPTS -jar "$WEB_JAR" jetty.resourcebase=$RC_BASE \
	jetty.port=$JETTY_PORT jetty.host=$JETTY_HOST \
    	config=/graphhopper/config.properties graph.location="$GRAPH" osmreader.osm="$OSM_FILE"
