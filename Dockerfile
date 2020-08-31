FROM ubuntu:18.04
# Todo: Use direct Tomcat container

ARG username=atsuser
ARG password=atspassword
ARG workdir=/home/$username/work

USER root

RUN adduser --disabled-password $username

RUN echo "$username:$password" | chpasswd

RUN usermod -a -G sudo $username

ADD ./docker_files $workdir

RUN apt-get update && apt-get -y install postgresql-client wget unzip openjdk-8-jre-headless zip sudo

RUN cd $workdir
RUN chmod +x $workdir/config $workdir/entrypoint

RUN $workdir/config

RUN chown -R $username /home/$username

USER $username

# EXPOSE 8080

ENV ENTRYPOINT_SCRIPT=$workdir/entrypoint

CMD ["bash","-c","$ENTRYPOINT_SCRIPT"]

