# Graphhopper Dockerfile

This Dockerfile builds image with grapphopper web app installed. You need to provide .pbf files through /data mount point. Please refer to instructions bellow.

### Building image

Take a look on files in assets directory:
* config.properties - graphhopper properties.
* start.sh - graphhopper run script. You can customize JAVA\_OPTS here (heap size, etc.).
* init.sh -  downloads and extracts installation .zip file to /graphhopper directory.

Make necessary changes in config files and build image:

```
$ sudo docker build -t bghtrbb/uio .
```

### Downloading pbf files

You need to download .pbf files and put them in directory on your host. Then mount this directory to container /data volume.

Example (North Carolina):

```
mkdir -p /private/osm-data/
cd /private/osm-data/
wget http://download.geofabrik.de/north-america/us/north-carolina-latest.osm.pbf
```

### Running container

When running container, you have to mount directory where .pbf file is placed to container /data volume. Moreover do not forget about port mapping.

Initial container run might take some time as GraphHopper needs to processes .pbf file and create additional work files. Tail logs till you see that server is started.


```
$ sudo docker run \
      -d \
      --name=graphhopper-northcarolina \
      -v /private/osm-data/:/data \
      -p 8990:8989 \
      bghtrbb/uio \
      /graphhopper/start.sh
$ sudo docker logs -f graphhopper-northcarolina
...
2014-10-04 11:21:30,110 [main] INFO  graphhopper.http.DefaultModule - loaded graph at:/data/berlin-latest.osm-gh, source:/data/berlin-latest.osm.pbf, acceptWay:car, class:LevelGraphStorage
2014-10-04 11:21:30,611 [main] INFO  graphhopper.http.GHServer - Started server at HTTP 8989
```

Check if web interface is available: [http://localhost:8990/](http://localhost:8990/)

You can easily run more instances of Grapphopper on different ports. Please make sure that you use separate directories for .pbf file and additional graphhopper work files. 

### Customizing JAVA\_OPTS

You can change JAVA\_OPTS by creating env.sh file in mounted directory. This can be usefull when you want to change heap size.

Example (use only 128MB for heap):

```
$ cat /home/stanislaw/private/graphhopper-data/berlin/env.sh
JAVA_OPTS="-Xms128m -Xmx128m -XX:MaxPermSize=64m -Djava.net.preferIPv4Stack=true -server -Djava.awt.headless=true -Xconcurrentio"
```
