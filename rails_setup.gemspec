# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_setup/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_setup"
  spec.version       = RailsSetup::VERSION
  spec.authors       = ["Mikhli, Uri"]
  spec.email         = ["urimikhli@gmail.com"]
  spec.summary       = %q{Generators for setting up common development needs for rails}
  spec.description   = %q{Topics covered: \n Multiple DBs \n Database credential managment \n SSL in development \n Session Managment Via 3rd Party authentication service.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib","lib/generators"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
