# Minitest::Parameterized

Minitest::Parameterized can help Minitest to run parameterized tests.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'minitest-parameterized'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install minitest-parameterized

## Usage

```ruby
class Minitest::ParameterizedTest < Minitest::Test
  describe 'Price' do
    extend Minitest::Parameterized
    parameterized 'with params:' do |spec|
      spec.when { TicketPrice.price(age) }
      spec.then do
        assert { subject == price }
      end

      spec.where \
        %w(  age || price )
      data [ 15  ,  600 ]
      data [ 20  , 1800 ]
      data [  0  ,    0 ]
    end
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sunaot/minitest-parameterized. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Minitest::Parameterized project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/sunaot/minitest-parameterized/blob/master/CODE_OF_CONDUCT.md).
