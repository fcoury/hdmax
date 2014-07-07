# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hdmax/version'

Gem::Specification.new do |spec|
  spec.name          = "hdmax"
  spec.version       = Hdmax::VERSION
  spec.authors       = ["Felipe Coury"]
  spec.email         = ["felipe.coury@gmail.com"]
  spec.description   = %q{Interacts with NET API}
  spec.summary       = %q{Interacts with NET API}
  spec.homepage      = "http://github.com/fcoury/hdmax"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "json"
  spec.add_runtime_dependency "rest-client", "~> 1.6.7"
  spec.add_runtime_dependency "tzinfo"
  spec.add_runtime_dependency "tzinfo-data"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "pry-meta"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "2.14.1"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock", "1.11"
end
