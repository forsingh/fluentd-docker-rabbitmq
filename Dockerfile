FROM ruby:2.2.0
RUN apt-get update
RUN gem install fluentd -v "~>0.12.3"
RUN mkdir /etc/fluent
RUN apt-get install -y libcurl4-gnutls-dev make
RUN /usr/local/bin/gem install fluent-plugin-elasticsearch
RUN /usr/local/bin/gem install fluent-plugin-amqp -v 0.7.1
RUN /usr/local/bin/gem install fluent-plugin-record-modifier
RUN /usr/local/bin/gem install fluent-plugin-s3

ADD fluent.conf /etc/fluent/

RUN mkdir -p /var/log/fluent/s3

RUN mkdir /source/
COPY * /source/

ENTRYPOINT ["/usr/local/bundle/bin/fluentd", "-c", "/etc/fluent/fluent.conf"]
