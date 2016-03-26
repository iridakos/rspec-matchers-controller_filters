# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec/matchers/controller_filters/version'

Gem::Specification.new do |spec|
  spec.name          = 'rspec-matchers-controller_filters'
  spec.version       = Rspec::Matchers::ControllerFilters::VERSION
  spec.authors       = ['Lazarus Lazaridis']
  spec.summary       = 'Test execution of before/around/after action filters with RSpec'
  spec.description   = 'This gem defines custom matchers that can be used to test execution of filters before, around or after controller actions.'
  spec.homepage      = 'https://github.com/iridakos/rspec-matchers-controller_filters'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_runtime_dependency 'rspec-rails', '~> 3', '>= 3.1'
end
