docker rm $(docker ps -a | grep Exit | cut -d ' ' -f 1)
