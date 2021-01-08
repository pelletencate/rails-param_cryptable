# Rails::ParamCryptable

A simple gem for Rails >= 5.2, that can encrypt URL parameters, intentionally meant to help you obfuscate
ordinary IDs without having to rely on a separate database-stored secret token.

Turns your

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails-param_cryptable'
```

And then execute:

    $ bundle install

## Usage

In this example, we will encrypt the ID of our OrdersController, turning **example.com/orders/123** into **example.com/orders/203e39202d326d13**

In your credentials (`rails credentials:edit --environment=production`), add a 16-bytes long value for param_cryptable_key.

```ruby
param_cryptable_key: CTYcQtYN3ELVM5Lu
```

In your controller:

```ruby
class OrdersController < ApplicationController
  include ParamCryptable

  crypt_param :id
```

This will automagically expect the `:id` param to be encrypted, and decrypt it for you.

And wherever you want to create an URL:

```ruby
# From within the controller
  orders_path(encrypt(@order.id))

# From everywhere else
module OrdersHelper
  def my_link_href_helper
    order_path(ParamCryptable.encrypt(@order.id))
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rails-param_cryptable. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/rails-param_cryptable/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).s
