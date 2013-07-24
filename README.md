# pulse_gem

## Installation

Add this line to your application's Gemfile:

    gem 'pulse', git: 'git@github.com:PowerToChange/pulse_gem.git'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pulse

## Getting started

```ruby
Pulse.api_base = 'https://pulse.powertochange.com'
Pulse.api_key = 'YOUR API KEY'

Pulse::MinistryInvolvement.where(guid: 'YOUR GUID')
```

## Testing
```
rake spec
```
