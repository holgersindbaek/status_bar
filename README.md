# StatusBar

TODO: Write a gem description

## Installation

Add simple_si to your Gemfile, and run `bundle install`:
```ruby
gem 'motion-cocoapods'
gem 'simple_si'
```

## Usage

``` ruby

# Initilize the status bar
statusbar = Statusbar.new


statusbar.show_notice("Hello World")

statusbar.show_activity_notice("Somethings is happening")
statusbar.show_success_notice("Great success")
statusbar.show_error_notice("Awww... did't work out")

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Thanks

* [Brian Partridge](https://github.com/brianpartridge) for [BPStatusBar](https://github.com/brianpartridge/BPStatusBar)