# -*- encoding: utf-8 -*-
STATUSBAR_VERSION = "0.1"

Gem::Specification.new do |spec|
  spec.name          = "StatusBar"
  spec.version       = STATUSBAR_VERSION
  spec.authors       = ["Holger Sindbaek"]
  spec.email         = ["holgersindbaek@gmail.com"]
  spec.description   = %q{This RubyMotion gem can show status updates in the status bar. Heavily inspired by https://github.com/brianpartridge/BPStatusBar.}
  spec.summary       = %q{RubyMotion status bar wrapper.}
  spec.homepage      = "https://github.com/holgersindbaek/StatusBar"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($\)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib", "statusbar_resources"]

  spec.add_development_dependency("bubblewrap")
  spec.add_development_dependency("sugarcube")

  spec.add_development_dependency "rake"
end
