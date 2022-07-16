#!/bin/bash

if [ -f ".mvn" ]; then
    booster="./mvnw"
else
    booster="mvn"
fi

case "$1" in
"init")
    mvn archetype:generate
    mvn -N io.takari:maven:wrapper
    ;;
"move")
    for dir in *; do
        if [ -d "$dir" ] && [[ "$dir" != *"\."* ]]; then
            mv ./"$dir"/* .
            rm -r ./"$dir"
        fi
    done
    ;;
"build")
    "$booster" compile
    ;;
"exe")
    if [[ "$2" == *"@"* ]]; then
        "$booster" exec:java"$2" -Dexec.args="$3 $4 $5 $6 $7 $8 $9"
    elif [[ "$2" == *"-"* ]]; then
        "$booster" exec:java "$2" -Dexec.args="$3 $4 $5 $6 $7 $8 $9"
    else
        "$booster" exec:java -Dexec.args="$2 $3 $4 $5 $6 $7 $8 $9"
    fi
    ;;
"test")
    "$booster" test
    ;;
"clean")
    "$booster" clean
    ;;
"pack")
    "$booster" package assembly:single
    ;;
"spring")
    "$booster" spring-boot:run
    ;;
"class")
    javac -Xlint:all "$2"
    ;;
esac
