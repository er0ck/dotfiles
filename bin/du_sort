#!/bin/sh
# TODO: take an argument for base dir
# TODO: conditional on gnu sort or non
#du -h --max-depth 1 . | sort -rh | head -20
#du -d 1 . | sort -rn | head -20

# this might work
du -k -d 1 . | sort -rn | awk '
function human(x) {
    s="kMGTEPYZ";
    while (x>=1000 && length(s)>1)
        {x/=1024; s=substr(s,2)}
    return int(x+0.5) substr(s,1,1)
}
{gsub(/^[0-9]+/, human($1)); print}'
