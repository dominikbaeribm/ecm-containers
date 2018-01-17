@echo off

set STARTING_FOLDER=C:\Program Files\IBM\CaseManagement
set CLASSPATH=%STARTING_FOLDER%\lib\caseSynchronizer.jar;%STARTING_FOLDER%\configure\lib\jace.jar;%STARTING_FOLDER%\configure\lib\log4j-1.2.13.jar
set JAVA_HOME=%STARTING_FOLDER%\java\sdk\bin

cd "%STARTING_FOLDER%"

"%JAVA_HOME%\java" -cp "%CLASSPATH%" com.ibm.casemgmt.tools.caseSynchronizer.CaseSynchronizer %*

