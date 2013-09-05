unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

lib_dir_path = File.dirname(File.expand_path(__FILE__))
Motion::Project::App.setup do |app|
  app.files.unshift(Dir.glob(File.join(lib_dir_path, "project/**/*.rb")))
  # personally, I would move the resources folder *into* this lib folder
  resource_dir = File.expand_path(File.join(lib_dir_path, '..', 'resources'))
  app.resources_dirs << resource_dir
end
