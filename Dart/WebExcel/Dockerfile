FROM ubuntu:16.04

ADD . /app/

WORKDIR /app/

RUN apt-get update && apt-get install -y apt-transport-https curl
RUN sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
RUN sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
RUN apt-get update && apt-get install -y dart
RUN /usr/lib/dart/bin/pub get

CMD ["/usr/lib/dart/bin/pub", "serve", "--hostname=0.0.0.0"]
