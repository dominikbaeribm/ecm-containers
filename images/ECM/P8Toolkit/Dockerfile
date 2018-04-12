FROM ubuntu
RUN apt-get update && \
apt-get upgrade -y && \
apt-get install -y  software-properties-common && \
add-apt-repository ppa:webupd8team/java -y && \
apt-get update && \
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
apt-get install -y oracle-java8-installer && \
apt-get clean
ENV p8toolkit /p8toolkit
RUN mkdir  ${p8toolkit} 
ADD . $p8toolkit
WORKDIR ${p8toolkit}/DEPLOY-DeploymentToolkit/test
RUN apt-get update
RUN apt-get install 
