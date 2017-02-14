# BART LITE

This app is a lightweight json wrapper of the Bart Api. It's meant to provide an easy url (perhaps to be bookmarked) to show what trains will be arriving at a Bart station in a given station. Below are the sample links for how this app might be used.

Bart Lite was built because I needed something lightweight that I could bookmark in my phone to check when the Bart was coming for my commute. Bart Lite was built because: 
1) existing bart mobile apps come and go frequently and are unreliable 
2) more traditional travel apps (ex. google maps) are too heavy weight

It just returns json. Nothing pretty.

Live:
https://bartlite.herokuapp.com/arrivals?station=MONT&direction=n

Resources: 

* https://bartlite.herokuapp.com/arrivals?station=<station-code>&direction=<n (for North) or s (for South) 
* https://bartlite.herokuapp.com/valid_station_codes => returns valid station codes for above query

Info:

* Ruby version: 2.3
* Rails version: 5.0.1
* postgresql - to get rails to behave, nothing is actually persisted in the db

How to use:

* bundle install
* bundle exec rake db:create
* be rake db:migrate RAILS_ENV=development
* bundle exec rails s
