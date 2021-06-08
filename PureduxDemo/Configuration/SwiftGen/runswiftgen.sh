#!/bin/sh

#  runswiftgen.sh
#  Portfolius-iOS
#
#  Created by Sergey Kazakov on 03.08.2020.
#  Copyright © 2020 kazaimazai. All rights reserved.

SRCROOT="$1"
OUTPUT_FILES=()

COUNTER=0
while [ $COUNTER -lt ${SCRIPT_OUTPUT_FILE_COUNT} ];
do
    tmp="SCRIPT_OUTPUT_FILE_$COUNTER"
    OUTPUT_FILES+=(${!tmp})
    COUNTER=$[$COUNTER+1]
done

for file in "${OUTPUT_FILES[@]}"
do
    if [ -f $file ]
    then
        chmod a=rw "$file"
    fi
done

$SRCROOT/PureduxDemo/Configuration/SwiftGen/swiftgen/bin/swiftgen config run --config $SRCROOT/PureduxDemo/Configuration/SwiftGen/swiftgen.yml

for file in "${OUTPUT_FILES[@]}"
do
    chmod a=r "$file"
done

