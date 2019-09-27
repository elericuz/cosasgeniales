FROM ruby:2.5.0
RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y dirmngr gnupg
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
RUN apt-get install -y apt-transport-https ca-certificates
RUN sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger xenial main > /etc/apt/sources.list.d/passenger.list'
RUN apt-get update
RUN apt-get install -y perl5.22 perl-base libperl-dev libssl-dev libstdc++6 libcrypto++-dev libsasl2-dev memcached libmemcached-tools libc6-dev
RUN apt-get install -y passenger
WORKDIR /var/www/
RUN gem install bundler