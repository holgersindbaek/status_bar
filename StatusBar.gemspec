# -*- encoding: utf-8 -*-
VERSION = "0.1"

Gem::Specification.new do |spec|
  spec.name          = "StatusBar"
  spec.version       = VERSION
  spec.authors       = ["Holger Sindbaek"]
  spec.email         = ["holgersindbaek@gmail.com"]
  spec.description   = %q{This RubyMotion gem can show status updates in the status bar. Heavily inspired by https://github.com/brianpartridge/BPStatusBar.}
  spec.summary       = %q{RubyMoion status bar wrapper.}
  spec.homepage      = ""
  spec.license       = ""

  files = []
  files << 'README.md'
  files.concat(Dir.glob('lib/**/*.rb'))
  spec.files         = files
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
end
