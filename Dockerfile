FROM ruby:2.6.0-alpine

RUN apk --no-cache add build-base

RUN mkdir /app
WORKDIR /app

COPY Gemfile* ./
RUN bundle install --jobs 4 --retry 4

COPY . .

EXPOSE 4000

CMD ["jekyll", "serve", "-H", "0.0.0.0"]
