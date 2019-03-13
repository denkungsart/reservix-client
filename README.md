# Reservix::Client

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/reservix/client`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'reservix-client'
```

And then execute:

    $ bundle

## Requirements

- Ruby 2.3+

## Usage

To get the events from the [Reservix](https://www.reservix.de/) you'll have to get an API key.
The key could be obtained from the Reservix itself.

```ruby
require 'reservix-client'

Reservix.api_key = "xxx"

# Fetch all events (limit 200)

client = Reservix::Client.new
client.events

# Fetch events for specific genre

params = { genreid: 19 } # Chormusik
client.events(params)

```

#### Event

Event is a class which represents Event object from the Reservix API. It is built on top of OpenStruct so every field from the API could be accessed as a method call, for example:

```ruby
event.name
#=> "Moskauer Kathedralchor"

event.artist
#=> "Nicolay Azarov (Leitung)"
```

`Event#starts_at` and `Events#ends_at` two methods which returns start/end dates of the event as [Time object](https://ruby-doc.org/core-2.3.0/Time.html) and in UTC time zone.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/denkungsart/reservix-client.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
