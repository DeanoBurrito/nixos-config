#!/bin/sh
allfreqs="$(cat /proc/cpuinfo | grep MHz | cut -d: -f 2 | cut -d. -f 1 | sort -g)"
freqs=($allfreqs)

echo "{\
    \"min\":\"${freqs[0]}\",
    \"max\":\"${freqs[-1]}\"
}"
