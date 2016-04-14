#!/bin/bash

# create main hypermap file combining 4 scales (25, 50, 100, 1000)

set -e

outfile=swiss_hypermap.imp

echo "CompeGPS MAP File
<Header>
Version=2
VerCompeGPS=7.7.0
Projection=14,Swiss Grid,
Coordinates=1
Datum=CH-1903
</Header>
<HiperMapLayers>" > $outfile

for f in CN25/*.imp; do
  filename=$(basename "$f")
  echo "  <HLayer File=\"CN25\\$f\" MaxZoomLevel=\"3.000\"/>" >> $outfile
done
for f in CN50/*.imp; do
  filename=$(basename "$f")
  echo "  <HLayer File=\"CN50\\$f\" MaxZoomLevel=\"7.000\" MinZoomLevel=\"3.000\"/>" >> $outfile
done
for f in CN100/*.imp; do
  filename=$(basename "$f")
  echo "  <HLayer File=\"CN100\\$f\" MaxZoomLevel=\"20.000\" MinZoomLevel=\"7.000\"/>" >> $outfile
done
for f in CN1000/*.imp; do
  filename=$(basename "$f")
  echo "  <HLayer File=\"CN1000\\$f\" MinZoomLevel=\"20.000\"/>" >> $outfile
done

echo '</HiperMapLayers>' >> $outfile
