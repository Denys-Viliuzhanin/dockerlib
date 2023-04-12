FROM ubuntu:latest



EXPOSE 22

RUN apt-get update && apt-get install -y openssh-server sudo

RUN mkdir /var/run/sshd

#Create user
RUN useradd -m user 
RUN usermod -aG sudo user

#Copy resources
RUN mkdir /app
COPY ./app/ /app/

#Build number
RUN BUILD_NUMBER=$(date +%Y%m%d%H%M%S)
RUN echo "${BUILD_NUMBER}" >> /app/build_number.txt

# Configure SSH access for user
RUN echo "\nPasswordAuthentication yes\n" >> file.txt
RUN sed -i 's/#PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

#Configure SSH access for root
#Root access must be forbidden
RUN echo "\nPermitRootLogin no\n" >> file.txt
RUN sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config


ENTRYPOINT ["/app/entry.sh"]
