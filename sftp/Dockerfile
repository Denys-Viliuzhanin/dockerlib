FROM ubuntu:latest

ENV DEFAULT_USER_PASSWORD="password"

RUN apt-get update && apt-get install -y openssh-server sudo

RUN mkdir /var/run/sshd

RUN useradd -m user && echo 'user:${DEFAULT_USER_PASSWORD}' | chpasswd
RUN usermod -aG sudo user

RUN echo "\nPasswordAuthentication yes\n" >> file.txt
RUN sed -i 's/#PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

RUN echo "\nPermitRootLogin no\n" >> file.txt
RUN sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

COPY ./entry.sh /

EXPOSE 22

ENTRYPOINT ["/entry.sh"]
