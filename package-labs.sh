#!/bin/bash

## install nbconvert as
##      conda install nbconvert
##              or
##      pip install nbconvert

## cleanup html
find . -name "*.html" -print0 | xargs -0 rm -f

## convert ipynb notebooks into HTML
notebooks=$(find . -type f -name "*.ipynb" | grep -v ".ipynb_checkpoints" )

jupyter nbconvert ${notebooks}

# move files in right place
mv -f private/README-python.html  .

## Change all the links from README.html
sed 's/ipynb/html/g' < Spark-python.html > a.html
mv -f a.html  Spark-python.html

# create a zipfile

zip_file_name=$(basename `pwd`)
rm -f *.zip
zip -x '*.DS_Store*'  -x "*.log" -x '*.git*'  -x '*zip*'  -x '*metastore_db*' -x '*out' -x '*.ipynb_checkpoints*' -x '*not-using*' -r "$zip_file_name" .
