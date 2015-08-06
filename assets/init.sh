#!/bin/sh

GRAPHHOPPER_DIR=/graphhopper
DATA_DIR=/data
TEMP_DIR=/tmp/
TEMP_GRAPH_DIR=~/tmp/graphhopper/

mkdir $GRAPHHOPPER_DIR
cd $GRAPHHOPPER_DIR

wget https://github.com/graphhopper/graphhopper/archive/master.zip
unzip *.zip
rm *.zip
mv -f graphhopper-master/* ./
rm -Rf graphhopper-master

if [ "$MAVEN_HOME" = "" ]; then
    # not existent but probably is maven in the path?
    MAVEN_HOME=$(mvn -v | grep "Maven home" | cut -d' ' -f3)
    if [ "$MAVEN_HOME" = "" ]; then
      # try to detect previous downloaded version
      MAVEN_HOME="$GRAPHHOPPER_DIR/maven"
      if [ ! -f "$MAVEN_HOME/bin/mvn" ]; then
        echo "No Maven found in the PATH. Now downloading+installing it to $MAVEN_HOME"
        cd "$GRAPHHOPPER_DIR"
        MVN_PACKAGE=apache-maven-3.2.5
        wget -O maven.zip http://archive.apache.org/dist/maven/maven-3/3.2.5/binaries/$MVN_PACKAGE-bin.zip
        unzip maven.zip
        mv $MVN_PACKAGE maven
        rm maven.zip
      fi
    fi
  fi

if [ ! -d "./target" ]; then
    echo "## building parent"
    "$MAVEN_HOME/bin/mvn" --non-recursive install > /tmp/graphhopper-compile.log
     returncode=$?
     if [[ $returncode != 0 ]] ; then
       echo "## compilation of parent failed"
       cat /tmp/graphhopper-compile.log
       exit $returncode
     fi                                     
  fi
  
  if [ ! -f "$JAR" ]; then
    echo "## now building graphhopper jar: $JAR"
    echo "## using maven at $MAVEN_HOME"
    #mvn clean
    "$MAVEN_HOME/bin/mvn" --projects core,tools -DskipTests=true install assembly:single > /tmp/graphhopper-compile.log
    returncode=$?
    if [[ $returncode != 0 ]] ; then
        echo "## compilation of core failed"
        cat /tmp/graphhopper-compile.log
        exit $returncode
    fi      
  else
    echo "## existing jar found $JAR"
  fi

mv /tmp/config.properties $GRAPHHOPPER_DIR
mv /tmp/start.sh $GRAPHHOPPER_DIR

echo "Showing contents of ${GRAPHHOPPER_DIR}"
ls $GRAPHHOPPER_DIR

echo "Showing contents of ${DATA_DIR}"
ls $DATA_DIR

echo "Showing contents of ${TEMP_DIR}"
ls $TEMP_DIR

