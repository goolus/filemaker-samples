json-to-mongodb
===========
It is a Rack Application that Simply register JSON data in MongoDB
Usage
==========
## Install the required dependencies: Ubuntu 16.04
```
$ sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
$ echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
$ sudo apt update
$ sudo apt install mongodb-org
```

## installation and run
```
$ git clone git@gitlab.goo-us.com:goolus/filemaker-course.git
$ cd filemaker-course/events
$ bundle install --path=vendor/bundle
$ bundle exec rack-console
[1] pry(main)> Event.create_indexes
=> true
[2] pry(main)> quit
$ bundle exec rackup
```

## test
```
$ curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d {"event_id": 1, "organizer": "test organizer", "title": "Event Title", "body": "bodybodybody", "image": "data:image/jpg:base64,#{BAE64Image} http://localhost:9292/"
$ open 'http://localhost:9292/'
```
or
```
$ cd filemaker-course/events
$ ./test_data.sh POST
```
