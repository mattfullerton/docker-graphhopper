#!/bin/sh

# Create variable for Graph Hopper Directory
GRAPHHOPPER_DIR=/graphhopper

# Make the directory, then Change directory
mkdir $GRAPHHOPPER_DIR
cd $GRAPHHOPPER_DIR

# Get .zip file from web, then unzip the .zip file, then remove (delete) the .zip file
wget https://oss.sonatype.org/content/groups/public/com/graphhopper/graphhopper-web/0.3/graphhopper-web-0.3-bin.zip
unzip *.zip
rm *.zip

# Move files to the Graph Hopper Directory
mv /tmp/config.properties $GRAPHHOPPER_DIR
mv /tmp/start.sh $GRAPHHOPPER_DIR

# Make the directory, then Change directory, then get .pdf file from the web
mkdir -p /private/osm-data/
cd /private/osm-data/
wget http://download.geofabrik.de/north-america/us/north-carolina-latest.osm.pbf

echo "Showing contents of ${GRAPHHOPPER_DIR}"
ls $GRAPHHOPPER_DIR
