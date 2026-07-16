FROM jekyll/jekyll:pages

WORKDIR /usr/src/app

COPY Gemfile* ./

RUN bundle install
