FROM ubuntu:18.04	

#Install required software
RUN apt-get update && apt-get install -y \
    git \
    openjdk-11-jdk 
 

#Add user 
RUN useradd -ms /bin/bash dev

#Add user
USER dev
WORKDIR /home/dev

ENTRYPOINT ["bash"]


