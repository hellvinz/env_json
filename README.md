# EnvJson

[![Build Status](https://travis-ci.org/hellvinz/env_json.png)](https://travis-ci.org/hellvinz/env_json)

Load ENV variables from a JSON file. (somehow similar to [dotenv](https://github.com/bkeepers/dotenv))

Intended to be used with [ejson](https://github.com/Shopify/ejson)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'env_json'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install env_json

## Usage

If you're using Rails create a config/env.json like this template

```json
{
    "DATABASE_URL": "mysql://@localhost/development_db",
    "test" : {
        "DATABASE_URL": "mysql://login:password@mysql.com/test_db"
    }
}
```

But really have a look at [ejson](https://github.com/Shopify/ejson) and [ejson-capistrano](https://github.com/Shopify/capistrano-ejson)

About the JSON format:

* keys prefixed with _ will be ignored
* keys development, test, staging, production will be ignored if they don't match with current environment

### ElasticBeanstalk

export env variables defined in config/env.json to Amazon ElasticBeanstalk environment

```
bundle exec rake env_json:eb
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hellvinz/env_json. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.
