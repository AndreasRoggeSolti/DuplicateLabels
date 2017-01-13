#!/bin/bash
RAWPATH=/home/andreas/Papers/EntropyOfModels/figures/raw
cd $RAWPATH

if test $# -eq 1
then
  FILES=$RAWPATH/$1
else
#  FILES=$RAWPATH/*.svg
  FILES=$(find $RAWPATH -name '*.pdf' -or -name '*.svg')
fi

for f in $FILES
do
  filename=$(basename "$f")
  extension="${filename##*.}"
  filename="${filename%.*}"
  echo "processing file $filename... with extension $extension"
  if [ $extension = "svg" ]
  then
    inkscape --without-gui --file=$f --export-pdf=$filename.pdf
  fi
  if [ $extension = "png" ]
  then
    cp $filename.png ../$filename.png
  else 
    pdfcrop -hires $filename.pdf $filename.crop.pdf
    mv $filename.crop.pdf ../$filename.pdf
  fi
  if [ $extension = "svg" ]
  then
    rm $filename.pdf
  fi
done
