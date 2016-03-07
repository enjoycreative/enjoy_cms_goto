# EnjoyCmsGoto

URL redirect dispatcher (goto-system) for [enjoy_cms](https://github.com/enjoycreative/enjoy_cms). You will know all about transfers to other sites.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'enjoy_cms_goto'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install enjoy_cms_goto

## Usage

Add in config/routes.rb

```ruby
  enjoy_cms_goto_routes
```

and in config/application.rb

```ruby
  config.middleware.use Enjoy::Goto::Middleware, {excluded_hosts: []}
```

Also you can specify excluded_hosts. This are hosts you don't want go through this system.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/enjoycreative/enjoy_cms_goto.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
