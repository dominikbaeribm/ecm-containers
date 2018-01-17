#!/bin/sh

STARTING_FOLDER=/opt/IBM/CaseManagement
export STARTING_FOLDER
CLASSPATH=${STARTING_FOLDER}/lib/preconditionChecker.jar:${STARTING_FOLDER}/configure/lib/Jace.jar:${STARTING_FOLDER}/configure/lib/log4j-1.2.13.jar
export CLASSPATH
JAVA_HOME=${STARTING_FOLDER}/java/sdk/bin
export JAVA_HOME

cd ${STARTING_FOLDER}

${JAVA_HOME}/java -classpath "${CLASSPATH}" com.ibm.casemgmt.tools.preconditionChecker.PreconditionChecker "$@"
