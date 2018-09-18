# filemaker-samples/events_rails
================================
本プロジェクトはFilemakerによって作成されたJSONデータを入出力するサンプルプロジェクトです。

# インストール方法(Ubuntu18.04向け)
## 実行環境準備(iot_rails)
```
$ sudo apt install libxslt1-dev libxml2-dev build-essential patch libsqlite3-dev libcurl4-openssl-dev curl git  nodejs ruby2.5 ruby2.5-dev
$ echo -e 'install: --no-document\nupdate: --no-document' ~/.gemrc
$ sudo gem install bundle --no-ri --no-rdoc
```
## プロジェクトのセットアップ
```
$ git clone https://github.com/goolus/filemaker-samples
$ cd filemaker-samples/events_rails
$ bundle install --path=vendor/bundle --without development test
$ bundle exec rails db:migrate RAILS_ENV=production
$ bundle exec rails assets:precompile RAILS_ENV=production
```

# 起動
```
$ bundle exec rails s -b 0.0.0.0 -e production
```

