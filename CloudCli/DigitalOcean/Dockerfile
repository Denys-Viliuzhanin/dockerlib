FROM ubuntu:latest

#Install required software
RUN  apt-get update \
  && apt-get install -y wget

# Install DigitalOcean CLI
WORKDIR /root
RUN pwd 
RUN wget https://github.com/digitalocean/doctl/releases/download/v1.92.0/doctl-1.92.0-linux-amd64.tar.gz
RUN ls /root/ 
RUN tar xf /root/doctl-1.92.0-linux-amd64.tar.gz
RUN mv /root/doctl /usr/local/bin

# Copy tools
COPY ./scripts/ /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

#Create user
ARG UNAME=user
ARG UID=1000
ARG GID=1000

RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME
USER $UNAME


USER user

WORKDIR /home/user

ENTRYPOINT [ "/bin/bash" ]