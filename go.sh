#!/bin/bash

# todo Switch over to the new template style
# todo Break-apart this file into its peaces

print $(date "+%Y-%m-%d_%H:%M:%S")

echo "[*] Starting ${SCRIPT_NAME} $@ ..."

count=0
htmlOut='images.html'
listIn='old-photos.lst'

# todo-Feature Need to figure out have to have this valdate every now and then

if [ ! -f $listIn ]; then

    echo "[*] $listIn Does not exesits ..."
    (find . -type f | grep photos/ | xargs -I{} echo "{}" > $listIn)

fi

printf "<html>" > $htmlOut
while read -r image; do
    ((count ++))
    user=$(cut -d/ -f4 <<< $image)
    dir=$(dirname $image)
    base=$(basename $image)
    new=$(echo "$base")

    echo "[*] #$count $base"

    printf "$new" >> list.lst
    # todo enable grouping and sorting
    printf "<a href='./$dir/$base ' ><img title='$user' src='./Thumb/$new' /></a>\n" >> $htmlOut

done < $listIn

echo "[*]"
echo "[*]"
echo "[*] Compleated $count lines."     # todo-Feature This shoulod give more information
echo "[*]"

echo "[*] Done. " . $(date "+%Y-%m-%d_%H:%M:%S")