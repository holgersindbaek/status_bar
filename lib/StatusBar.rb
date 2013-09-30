require 'geomotion'
require 'sugarcube-legacy'
require 'sugarcube-image'
require 'sugarcube-uikit'
# require 'formotion'

unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

lib_dir_path = File.dirname(File.expand_path(__FILE__))
resource_dir = File.expand_path(File.join(lib_dir_path, '..', 'resources'))

p __FILE__
p File.join(File.dirname(__FILE__), 'resources')
p File.join('../resources')

p File.join(lib_dir_path, "project/StatusBar.rb")
p File.join(lib_dir_path, "project/StatusBarHelper.rb")
p "resource_dir: #{resource_dir}"

require 'motion-require'

Motion::Require.all(Dir.glob(File.expand_path('../StatusBar/**/*.rb', __FILE__)))

Motion::Project::App.setup do |app|
  # app.files_dependencies File.join(lib_dir_path, "project/StatusBar.rb") => File.join(lib_dir_path, "project/StatusBarHelper.rb")
  app.files.unshift Dir.glob(File.join(lib_dir_path, "project/**/*.rb"))
  app.resources_dirs << File.join(File.dirname(__FILE__), '../resources')
  
  p app.resources_dirs
end