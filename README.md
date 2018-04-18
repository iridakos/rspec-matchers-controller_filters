# Rspec::Matchers::ControllerFilters [![Gem Version](https://badge.fury.io/rb/rspec-matchers-controller_filters.png)](https://badge.fury.io/rb/rspec-matchers-controller_filters) [![Build Status](https://travis-ci.org/iridakos/rspec-matchers-controller_filters.svg?branch=master)](https://travis-ci.org/iridakos/rspec-matchers-controller_filters)

Use this gem to test the execution of before/around/after filters of your controller actions with RSpec.

Here's a post describing the general idea of the gem:
[https://iridakos.com/how-to/2014/10/14/testing-execution-of-filters-with-rspec.html](https://iridakos.com/how-to/2014/10/14/testing-execution-of-filters-with-rspec.html)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-matchers-controller_filters'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-matchers-controller_filters

## Usage

In your controller specs you may use the new matchers:

```ruby
it { should execute_before_action :your_filter, :on => :your_action, :with => { :parameter_name => 'parameter_value'} }
it { should_not execute_around_action :your_filter, :on => :your_action, :with => { :parameter_name => 'parameter_value'} }
it { should execute_after_action :your_filter, :on => :your_action, :with => { :parameter_name => 'parameter_value'} }
```

The **with** parameter is optional.

## Contributing

1. Fork it ( https://github.com/iridakos/rspec-matchers-controller_filters/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

This gem is open source under the [MIT License](https://opensource.org/licenses/MIT) terms.
