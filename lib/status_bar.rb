require 'bubble-wrap/core'
require 'teacup'
require 'sugarcube-uikit'
require 'sugarcube-color'
require 'sugarcube-numbers'
require 'sugarcube-animations'
require 'sugarcube-timer'

unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

lib_dir_path = File.dirname(File.expand_path(__FILE__))
# resource_dir = File.expand_path(File.join(lib_dir_path, '..', 'resources'))

Motion::Project::App.setup do |app|
  # app.files_dependencies File.join(lib_dir_path, "project/StatusBar.rb") => File.join(lib_dir_path, "project/StatusBarHelper.rb")
  app.files.unshift Dir.glob(File.join(lib_dir_path, "project/**/*.rb"))
  app.resources_dirs << File.join(File.dirname(__FILE__), 'resources')
end