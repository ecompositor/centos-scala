#!/bin/bash

SBT_OPTS="-Xms512M -Xmx2G -Xss1M -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=2G -Dfile.encoding=UTF8 -Dscalac.patmat.analysisBudget=512"

java $SBT_OPTS -jar `dirname $0`/sbt-launch.jar "$@"







