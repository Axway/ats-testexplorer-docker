# syntax=docker/dockerfile:1

FROM ubuntu:18.04 AS te-base
# Todo: Use direct Tomcat container like amd64/tomcat:9.0-jre8-temurin-focal
LABEL maintainer="ats.team__@__axway.com"\
    product="Axway ATS TestExplorer with external DB"\
    version="4.0.11-SNAPSHOT"

ARG username=atsuser
ARG password=atspassword
ARG workdir=/home/$username/work

ARG TE_VERSION="4.0.11-log4j1-SNAPSHOT"
# For recent versions not in public repository put your local build location
ARG TE_DOWNLOAD_LOCATION="https://oss.sonatype.org/content/groups/public/com/axway/ats/testexplorer/ats-testexplorer/$TE_VERSION"

USER root

RUN adduser --disabled-password $username

RUN echo "$username:$password" | chpasswd

RUN usermod -a -G sudo $username

# Use automatically closest mirror - list in mirrors.txt. May have issues with recently added certificates of mirrors
#RUN sed -i -e 's/http:\/\/archive\.ubuntu\.com\/ubuntu\//mirror:\/\/mirrors\.ubuntu\.com\/mirrors\.txt/' /etc/apt/sources.list
# Use BG mirror
RUN sed -i -e 's/http:\/\/archive\.ubuntu\.com\/ubuntu\//http:\/\/bg\.archive\.ubuntu\.com\/ubuntu\//' /etc/apt/sources.list

RUN apt-get update && DEBIAN_FRONTEND="noninteractive" TZ="UTC" \
    apt-get -y install wget unzip openjdk-8-jre-headless zip sudo gnupg2

# Install PostgreSQL-12 (Default version in 18.04 is Postgre 10) and Ms SQL Tools
# Create the file repository configuration: ($(lsb_release -cs) not working for bionic - 18.04)
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt bionic-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
# Add MsSQL tools repository
RUN sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/ubuntu/18.04/prod bionic main" > /etc/apt/sources.list.d/msprod.list'

# Import the repository signing key
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
# Import Ms SQL repository signing key
RUN wget --quiet -O - https://packages.microsoft.com/keys/microsoft.asc | apt-key add

# Update the package lists, install PostgreSQL 12 client and Ms SQL Tools
RUN apt-get update && DEBIAN_FRONTEND="noninteractive" TZ="UTC" ACCEPT_EULA="y" \
    apt-get -y install postgresql-client-12  mssql-tools unixodbc-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


FROM te-base AS te-1

ARG username=atsuser
ARG password=atspassword
ARG workdir=/home/$username/work

ADD ./docker_files $workdir

RUN cd $workdir
RUN chmod +x $workdir/config $workdir/entrypoint

RUN $workdir/config

RUN chown -R $username /home/$username


USER $username

# EXPOSE 8080

ENV ENTRYPOINT_SCRIPT=$workdir/entrypoint

CMD ["bash","-c","$ENTRYPOINT_SCRIPT"]


