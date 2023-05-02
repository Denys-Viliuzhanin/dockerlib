FROM ubuntu:latest

#Install required software
RUN  apt-get update \
  && apt-get install -y wget openssh-server nano sudo curl

# Install DigitalOcean CLI
WORKDIR /root
RUN pwd 
RUN wget https://github.com/digitalocean/doctl/releases/download/v1.92.0/doctl-1.92.0-linux-amd64.tar.gz
RUN ls /root/ 
RUN tar xf /root/doctl-1.92.0-linux-amd64.tar.gz
RUN mv /root/doctl /usr/local/bin


# Install digitalocean-cli sceipts
RUN mkdir /app
RUN mkdir /app/digitalocean-cli

# Copy tools
COPY ./scripts/ /app/digitalocean-cli/
RUN chmod +x -R /app/digitalocean-cli/*.sh
RUN chmod +x -R /app/digitalocean-cli/utils/*.sh

#Initialize
RUN /app/digitalocean-cli/digitalocean-cli-init.sh

## /usr/local/bin/


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