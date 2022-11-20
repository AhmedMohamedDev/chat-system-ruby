FROM ruby:2.3.5

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN apt-get -y install mysql-client

ENV RAILS_ROOT /app
RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT

ENV BUNDLE_PATH /gems

COPY Gemfile Gemfile.lock ./
RUN gem update --system
RUN gem install bundler && bundle install
RUN bundle update rake
RUN gem update bundler
COPY . ./

