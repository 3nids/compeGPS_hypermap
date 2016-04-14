#!/bin/bash

# convert RGB PNG maps with swisstopo palette

set -e

PAL=$1"_pal"

mkdir -p $PAL

for f in $1/*.tif
do
  filename=$(basename "$f")
  fname="${filename%.*}"
  #if [[ `gdalinfo $f | grep Palette | wc -l` -eq 0 ]]; then
    gdal_translate -a_srs EPSG:21781 -of PNG $f $PAL/$fname.png
    mogrify -remap palette-swisstopo.png -type Palette -colors 7 $PAL/$fname.png
    rm $f
  #fi
done
    
