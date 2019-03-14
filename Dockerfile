FROM ruby:2.3.4

RUN mkdir /var/exercise
WORKDIR /var/exercise
RUN gem install bundler
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
CMD ["bin/console"]
