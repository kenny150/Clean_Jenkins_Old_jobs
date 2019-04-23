#!/bin/bash -x

FILE='/var/lib/jenkins/jobs/list_exclude.txt'

if [ -f $FILE ]; then
        echo "File $FILE exist ... Removendo"
        rm -f "$FILE"
else
        echo "File $FILE doesn't exist"
fi

ls -d /var/lib/jenkins/jobs/*/builds | cut -d '/' -f 6 > $FILE

while read line
do
        cd /var/lib/jenkins/jobs/$line/builds ; echo $line && n=$(ls | wc -l)
        if [ $n -gt 11 ];then
                echo "$line | $n"
        fi
done < $FILE