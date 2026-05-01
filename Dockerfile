ARG RUBY_VERSION=3.3.5
FROM ruby:$RUBY_VERSION

# 必要なパッケージをインストール
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    curl \
    git \
    libpq-dev \
    libyaml-dev \
    pkg-config \
    nodejs \
    npm \
    postgresql-client \
    imagemagick \
    libmagickwand-dev \
    vim \
    fonts-noto-cjk && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# タイムゾーンをJSTに設定
ENV TZ=Asia/Tokyo

RUN mkdir /app_name
ENV APP_ROOT=/app_name
WORKDIR $APP_ROOT

# Gemfile をコピーして依存関係をインストール
COPY Gemfile Gemfile.lock $APP_ROOT/
RUN bundle install

# アプリケーションをコピー
COPY . $APP_ROOT

ENV BINDING="0.0.0.0"
