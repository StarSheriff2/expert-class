# syntax=docker/dockerfile:1

FROM ruby:3.0.2
RUN apt-get update -qq && apt-get install -y postgresql-client
ENV RAILS_LOG_TO_STDOUT true
# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
COPY . .
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3001
CMD ["rails", "server", "-b", "0.0.0.0"]
