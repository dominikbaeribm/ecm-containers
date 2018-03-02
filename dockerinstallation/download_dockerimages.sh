#!/usr/bin/env bash
# docker pull ibmcom/db2express-c
docker login 
docker pull ibmcorp/filenet_content_platform_engine:latest
docker pull ibmcorp/content_navigator:latest
docker pull ibmcorp/content_management_interoperability_services:latest
docker pull ibmcorp/content_search_services:latest
