FROM ubuntu:latest
MAINTAINER Kirsten Hunter (khunter@akamai.com)
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes -q curl python-all wget vim python-pip ruby ruby-dev perl npm nano 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes mongodb-server mongodb httpie
RUN curl -sL https://deb.nodesource.com/setup_4.x |  bash -
RUN apt-get install -y --force-yes nodejs
RUN mkdir -p /data/db
ADD . /opt
WORKDIR /opt/Chapter5
RUN gem install bundler
RUN bundle install
WORKDIR /opt/Chapter4
RUN pip install -r requirements.txt
WORKDIR /opt/Chapter2
RUN npm install
WORKDIR /opt/Chapter3
RUN cpan -i -f Dancer Dancer::Plugin::CRUD MongoDB JSON YAML
WORKDIR /opt/Chapter1
EXPOSE 8080
ADD ./MOTD /opt/MOTD
RUN echo "cat /opt/MOTD" >> /root/.bashrc
ENTRYPOINT ["/bin/bash"]
