#!/bin/sh

GRAPHHOPPER_DIR=/graphhopper
DATA_DIR=/data
TEMP_DIR=/tmp/
TEMP_GRAPH_DIR=~/tmp/graphhopper/

mkdir $GRAPHHOPPER_DIR
cd $GRAPHHOPPER_DIR

wget https://oss.sonatype.org/content/groups/public/com/graphhopper/graphhopper-web/0.3/graphhopper-web-0.3-bin.zip
unzip *.zip
rm *.zip

mv /tmp/config.properties $GRAPHHOPPER_DIR
mv /tmp/start.sh $GRAPHHOPPER_DIR

echo "Showing contents of ${GRAPHHOPPER_DIR}"
ls $GRAPHHOPPER_DIR

echo "Showing contents of ${DATA_DIR}"
ls $DATA_DIR

echo "Showing contents of ${TEMP_DIR}"
ls $TEMP_DIR

