[![Build Status](https://api.travis-ci.org/OsnaCS/drk-funk.svg)](https://travis-ci.org/OsnaCS/drk-funk)
[![License](https://img.shields.io/badge/license-GPLv3-blue.svg)](https://github.com/OsnaCS/drk-funk/blob/master/LICENSE)

# ![Logo](https://raw.githubusercontent.com/OsnaCS/drk-funk/dev/public/ims_logo.png)
Placeholder
Deployment Version (upstream/dev): https://rk-inventory.herokuapp.com/

# Development
__Requirements__
* [Ruby 2.2.2](http://www.ruby-lang.org/en/downloads/)
* [PostgreSQL 9.4+](http://www.postgresql.org/download/)
* [Bundler](http://gembundler.com/)

__Installation__
* Install Ruby, Postgres via installer or package manager of your system.
  * Use ```postgres``` as your superuser password. If you use an different one make sure you adjust the environment variables.
* Install Bundler via ```gem install bundler```.
* Install gems via ```bundler install```
* Run ```rake db:create```, ```rake db:migrate```, ```rake db:seed``` via terminal or Rubymine. All of the commands in __development__ mode.
* Start the rails server.

__Caveat__
ONLY ON WINDOWS (x86, x64)
The _brcypt_ extension is not working with ruby 2.2.2 and Windows systems. You have to manualy compile the extension. Corresponding [Issue](https://github.com/codahale/bcrypt-ruby/issues/116).
Here we assume you already have set up the rails installtion on windows correctly, including the dev kit!

* Run ```bundler install``` if you haven't already.
* Open an terminal and move the the bcrypt gem folder: ```(path to gem files)/\bcrypt-X.X.X-x86-mingw32\ext\mri```
* Run ```ruby extconf.rb```
* Then run ```make``` and ```make install```