FROM ubuntu:latest

ARG BUILD_NUMBER

EXPOSE 22

RUN apt-get update && apt-get install -y openssh-server sudo

RUN mkdir /var/run/sshd

#Create user
RUN useradd -m user 
RUN usermod -aG sudo user

#Copy resources
RUN mkdir /app
RUN mkdir /app/sshd
COPY ./app/ /app/sshd/

#Build number

RUN echo ${BUILD_NUMBER} >> /app/sshd/build_number.txt

# Configure SSH access for user
RUN echo "\nPasswordAuthentication yes\n" >> file.txt
RUN sed -i 's/#PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

#Configure SSH access for root
#Root access must be forbidden
RUN echo "\nPermitRootLogin no\n" >> file.txt
RUN sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config


ENTRYPOINT ["/app/sshd/entry.sh"]
