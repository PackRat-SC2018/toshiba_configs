#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#edeaea/g' \
         -e 's/rgb(100%,100%,100%)/#050505/g' \
    -e 's/rgb(50%,0%,0%)/#e5e3e3/g' \
     -e 's/rgb(0%,50%,0%)/#c2c5c6/g' \
 -e 's/rgb(0%,50.196078%,0%)/#c2c5c6/g' \
     -e 's/rgb(50%,0%,50%)/#f5f5f5/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#f5f5f5/g' \
     -e 's/rgb(0%,0%,50%)/#303030/g' \
	$@