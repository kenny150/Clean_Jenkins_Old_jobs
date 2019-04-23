#!/bin/bash

function clean (){

        [ -f "$FILE" ] && ls "$FILE" || echo "Gerando lista..." ;
}

FILE='/tmp/exclude_list.txt'

#       clean
#       find /var/lib/jenkins/jobs/ -type d -name builds > $FILE
        while read line
        do

                echo "Entrando em $line" && cd $line
                number=$(ls | grep -E '^[0-9]+' | wc -l)
                count=30
                res=0
                        if [ "$count" -gt "$number" ];then
                                res=$(( $count - $number))
                                echo "$number pastas de builds, ignorando ..."

                        else
                                res=$(($number - $count))
                                echo "$number pastas de builds, realizando expurgo de $res"
                                echo "$line | Quantidade de builds = $number"
                                last_success=$(ls -l "$line" | grep 'lastSuccessfulBuild' | awk '{print $NF}')                
                                echo "Último build com sucesso = $last_success"
                                declare -a del=($(ls -t | grep -E '^[0-9]' | tail -n $res | xargs))
                                        for i in "${del[@]}"
                                        do
                                                if [[ $i -eq $last_success ]]; then
                                                        echo "Ignorando $i"
                                                fi
                                                else
                                                        echo "Mostrando vetor $i"
                                                fi
                                        done
                        fi
        done < $FILE