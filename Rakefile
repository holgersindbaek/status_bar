# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")

require 'motion/project/template/ios'

require 'sugarcube-repl'
require 'sugarcube-foundation'
require 'sugarcube-color'
require 'sugarcube-constants'
require 'sugarcube-568'
require 'sugarcube-uikit'
require 'sugarcube-gestures'
require 'sugarcube-nsdata'
require 'sugarcube-timer'
require 'sugarcube-animations'
require 'sugarcube-events'
require 'awesome_print_motion'
require 'guard/motion'
require 'teacup'

begin
  require 'bundler'
  require 'motion/project/template/gem/gem_tasks'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'status_bar'
end