# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")

require 'motion/project/template/ios'

require 'awesome_print_motion'
require 'guard/motion'
require 'teacup'
require 'sugarcube-repl'

begin
  require 'bundler'
  require 'motion/project/template/gem/gem_tasks'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'status_bar'
  app.info_plist['UIStatusBarHidden'] = false
  app.info_plist['UIViewControllerBasedStatusBarAppearance'] =  false
  app.info_plist['UIStatusBarStyle'] =  'UIStatusBarStyleLightContent'
end