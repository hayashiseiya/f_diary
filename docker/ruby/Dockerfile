FROM ruby:2.7

ENV APP_PATH=/app
ENV BUNDLE_PATH=$APP_PATH/vendor/bundle

RUN bundle config path $BUNDLE_PATH

WORKDIR $APP_PATH
