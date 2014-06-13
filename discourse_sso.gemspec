# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'discourse_sso/version'

Gem::Specification.new do |spec|
  spec.name          = "discourse_sso"
  spec.version       = DiscourseSSO::VERSION
  spec.authors       = ["Tijmen Brommet"]
  spec.email         = ["tijmen@gmail.com"]
  spec.summary       = %q{SSO provider for Discourse in Ruby}
  spec.description   = %q{Sign in to a Discourse forum via your Ruby app.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # TODO: remove dependency on rack
  spec.add_dependency "rack"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
