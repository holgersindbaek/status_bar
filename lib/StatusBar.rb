unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

lib_dir_path = File.dirname(File.expand_path(__FILE__))
resource_dir = File.expand_path(File.join(lib_dir_path, '..', 'resources'))
Motion::Project::App.setup do |app|
  app.files.unshift(Dir.glob(File.join(lib_dir_path, "project/**/*.rb")))
  app.resources_dirs.unshift << resource_dir

  app.pods do
    pod 'UIImage+RTTint', '~> 1.0.0'
  end
end