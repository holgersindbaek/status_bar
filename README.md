# StatusBar

TODO: Write a gem description

## Installation

Add StatusBar to your Gemfile, and run `bundle install`:
```ruby

gem 'motion-cocoapods'
gem 'StatusBar'

```

## Usage

``` ruby

# Initilize the status bar
statusbar = Statusbar.new

# Show a notice... and hide it
statusbar.show_notice("Hello World")
statusbar.hide_notice

# Show notice with an indicator
statusbar.show_activity_notice("Somethings is happening")
statusbar.show_success_notice("Great success")
statusbar.show_error_notice("Awww... did't work out")

```

## Todo

* Make it work with a translucent status bar
* Make rotation work perfectly

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Thanks

* [Brian Partridge](https://github.com/brianpartridge) for [BPStatusBar](https://github.com/brianpartridge/BPStatusBar)