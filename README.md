##Build
docker build -t shols/r-learning .

##Remove 
docker rm -f r_server

##Run
docker run -td -p 80:80 -p 443:443 --name=r_server shols/r-learning

##Terminal
docker exec -it shols/r_server /bin/bash


############################
PICK UP HERE:

You got apache running but not r-studio server
# r-learning
