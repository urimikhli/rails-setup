# RailsSetup

This is a collection of generators to help setup rails development in an enterprise environment.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_enterprise_setup'
```

And then execute:

    $ bundle install

## Usage

```ruby
rails generate setup_rails
```

You will have the option of choosing all or any of the setups:

```ruby
  all[Aa]:
  db_connect[Cc]:
  db_credentials[Rr]:
  ssl_mode[Ss]:
  none[]:
```

Note: You can enter more then 1 letter.

e.g.
  "What setup would you like to run. (Default: none)[AaCcRsSs]:" cr

typing 'cr' will run db_connect and db_credentials sequentially. running 'crs' will be the same as 'a' 

## More Info

```ruby
    rails generate setup_rails -h

    rails generate db_connect -h
    rails generate db_credentials -h
    rails generate ssl_mode -h
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rails_setup/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
