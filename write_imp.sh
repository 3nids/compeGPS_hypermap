#!/bin/bash

# write imp for map using gdalinfo

set -e

for f in $1/*.png; do
  filename=$(basename "$f")
  IMP="${filename%.*}.imp"

  size=`gdalinfo $f | grep "Size is"`
  width=`echo $size | awk '{print $3}' | rev | cut -c 2- | rev`
  height=`echo $size | awk '{print $4}'`
  ul=`gdalinfo $f | grep "Upper Left"`
  ulx=`echo $ul | awk '{print $4}' | rev | cut -c 2- | rev`
  uly=`echo $ul | awk '{print $5}' | rev | cut -c 2- | rev`
  lr=`gdalinfo $f | grep "Lower Right"`
  lrx=`echo $lr | awk '{print $4}' | rev | cut -c 2- | rev`
  lry=`echo $lr | awk '{print $5}' | rev | cut -c 2- | rev`
  ps=`gdalinfo $f | grep "Pixel Size" | cut -d "(" -f 2 | cut -d "," -f 1`
  P01=`echo "$ulx + $ps/2" | bc -l`
  P02=`echo "$uly - $ps/2" | bc -l`
  P11=`echo "$lrx + $ps/2" | bc -l`
  P12=`echo "$lry - $ps/2" | bc -l`
  
  echo "CompeGPS MAP File
<Header>
Version=2
VerCompeGPS=7.7.0
Projection=14,Swiss Grid,
Coordinates=-1
Datum=CH-1903
</Header>
<Map>
Bitmap=$filename
BitsPerPixel=0
BitmapWidth=$width
BitmapHeight=$height
Type=10
</Map>
<Calibration>
P0=0.00000000,0.00000000,A,$P01,$P02
P1=$width.00000000,$height.00000000,A,$P11,$P12
P2=$width.00000000,0.00000000,A,$P11,$P02
</Calibration>
" > $1/$IMP

done

