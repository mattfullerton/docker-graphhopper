#!/bin/sh

GRAPHHOPPER_DIR=/graphhopper

mkdir $GRAPHHOPPER_DIR
cd $GRAPHHOPPER_DIR

wget https://oss.sonatype.org/content/groups/public/com/graphhopper/graphhopper-web/0.3/graphhopper-web-0.3-bin.zip
unzip *.zip
rm *.zip

mv /tmp/config.properties $GRAPHHOPPER_DIR
mv /tmp/start.sh $GRAPHHOPPER_DIR

mkdir -p ~/private/graphhopper-data/berlin/
cd ~/private/graphhopper-data/berlin/
wget http://download.geofabrik.de/north-america/us/north-carolina-latest.osm.pbf

echo "Showing contents of ${GRAPHHOPPER_DIR}"
ls $GRAPHHOPPER_DIR
