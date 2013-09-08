unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end


lib_dir_path = File.dirname(File.expand_path(__FILE__))
resource_dir = File.expand_path(File.join(lib_dir_path, '..', 'resources'))

p lib_dir_path
p File.join(File.dirname(__FILE__), 'resources')

p File.join(lib_dir_path, "project/StatusBar.rb")
p File.join(lib_dir_path, "project/StatusBarHelper.rb")
p "resource_dir: #{resource_dir}"


Motion::Project::App.setup do |app|
  # app.files_dependencies File.join(lib_dir_path, "project/StatusBar.rb") => File.join(lib_dir_path, "project/StatusBarHelper.rb")
  app.files.unshift Dir.glob(File.join(lib_dir_path, "project/**/*.rb"))
  app.resources_dirs << File.join(File.dirname(__FILE__), 'resources')

  app.pods do
    pod 'UIImage+RTTint', '~> 1.0.0'
  end
end