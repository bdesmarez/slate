FROM ruby:2.4
MAINTAINER Adrian Perez <adrian@adrianperez.org>
VOLUME /usr/src/app/source
EXPOSE 4567

#ENV http_proxy "gateway.zscaler.net:80"
#ENV https_proxy "gateway.zscaler.net:443"
#ENV HTTP_PROXY "gateway.zscaler.net:80"
#ENV HTTPS_PROXY "gateway.zscaler.net:443"

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install

COPY . /usr/src/app

RUN apt-get update && apt-get install -y nodejs \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["bundle", "exec", "middleman", "server", "--watcher-force-polling"]

