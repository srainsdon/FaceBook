#!/bin/bash

print $(date "+%Y-%m-%d_%H:%M:%S")

echo "[*] Starting ${SCRIPT_NAME} $@ ..."

count=0
htmlOut='images.html'
listIn='old-photos.lst'

if [ ! -f $listIn ]; then

    echo "[*] $listIn Does not exesits ..."
    (find . -type f | grep photos/ | xargs -I{} echo "{}" > $listIn)

fi

echo "[*] $listIn existes so skiping that..."


printf "<html>" > $htmlOut
while read -r image; do
    ((count ++))
    user=$(cut -d/ -f4 <<< $image)
    dir=$(dirname $image)
    base=$(basename $image)
    new=$(echo "$base")

    echo "[*] #$count $base"

    printf "$new" >> list.lst

    printf "<a href='./$dir/$base ' ><img title='$user' src='./Thumb/$new' /></a>\n" >> $htmlOut

done < $listIn

echo "[*]"
echo "[*]"
echo "[*] Compleated $count lines."
echo "[*]"

echo "[*] Done. " . $(date "+%Y-%m-%d_%H:%M:%S")