#!/bin/sh
sed -i \
         -e 's/#eaeaea/rgb(0%,0%,0%)/g' \
         -e 's/#050505/rgb(100%,100%,100%)/g' \
    -e 's/#dbdbdb/rgb(50%,0%,0%)/g' \
     -e 's/#c1b9ac/rgb(0%,50%,0%)/g' \
     -e 's/#f5f5f5/rgb(50%,0%,50%)/g' \
     -e 's/#161616/rgb(0%,0%,50%)/g' \
	$@
