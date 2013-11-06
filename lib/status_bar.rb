require 'hs'
require 'bubble-wrap/core'
require 'bubble-wrap/reactor'
require 'teacup'
require 'sugarcube-uikit'
require 'sugarcube-color'
require 'sugarcube-numbers'
require 'sugarcube-animations'
require 'sugarcube-timer'
require 'sugarcube-image'

unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

lib_dir_path = File.dirname(File.expand_path(__FILE__))
resource_dir = File.expand_path(File.join(lib_dir_path, '..', 'resources'))

Motion::Project::App.setup do |app|
  teacup_insert_point = nil
  app.files.each_index do |index|
    file = app.files[index]
    if file =~ /teacup/
      teacup_insert_point = index + 1
    elsif teacup_insert_point
      # found one, so stop looking
      break
    end
  end

  Dir.glob(File.join(File.dirname(__FILE__), 'project/**/*.rb')).reverse.each do |file|
    app.files.insert(teacup_insert_point, file)
  end
  
  # app.files.unshift Dir.glob(File.join(lib_dir_path, "project/**/*.rb"))
  app.resources_dirs << File.join(File.dirname(__FILE__), 'resources')
end