FROM ubuntu:16.04
MAINTAINER Jason Sun <jsun@autox.ai>
RUN apt update && apt install -y openssh-server fish vim git
RUN chsh -s `which fish`
RUN echo 'interview-infrastructure' > /etc/hostname
RUN mkdir /var/run/sshd
RUN echo 'root:autox' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
