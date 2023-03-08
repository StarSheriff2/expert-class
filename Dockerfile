# syntax=docker/dockerfile:1

FROM ruby:3.0.2
RUN apt-get update -qq && apt-get install -y postgresql-client
ENV PORT=3001 \
  RAILS_ENV=production \
  RAILS_LOG_TO_STDOUT=true
# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN gem update --system \
  && gem install bundler
RUN bundle config set --local without 'development test' \
  && bundle install \
  && bundle exec rails db:prepare
COPY . .
COPY production.entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/production.entrypoint.sh
ENTRYPOINT ["production.entrypoint.sh"]
EXPOSE 3001
CMD ["rails", "server", "-b", "0.0.0.0"]
