
#!/bin/sh

wget https://s3.amazonaws.com/metro-extracts.mapzen.com/charlotte_north-carolina.osm.pbf

# Create variable for Graph Hopper Directory
GRAPHHOPPER_DIR=/graphhopper

# Make the directory, then Change directory
mkdir $GRAPHHOPPER_DIR
cd $GRAPHHOPPER_DIR

# Get .zip file from web, then unzip the .zip file, then remove (delete) the .zip file
wget https://oss.sonatype.org/content/groups/public/com/graphhopper/graphhopper-web/0.3/graphhopper-web-0.3-bin.zip
unzip *.zip
rm *.zip

echo "Showing contents of ${GRAPHHOPPER_DIR}"
ls $GRAPHHOPPER_DIR