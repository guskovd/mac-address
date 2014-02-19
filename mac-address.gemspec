# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mac-address/version'

Gem::Specification.new do |spec|
  spec.name          = 'mac-address'
  spec.version       = MacAddress::VERSION
  spec.authors       = ['Ara T. Howard', 'Ryan Biesemeyer']
  spec.email         = ["ryan@yaauie.com"]
  spec.summary       = 'cross platform mac address determination for ruby'
  spec.description   = 'based on @ahoward\'s macaddr gem'
  spec.homepage      = 'https://github.com/yaauie/mac-address'
  spec.license       = 'ruby'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '>= 2.14.1'

  spec.add_runtime_dependency 'systemu', '~> 2.5.0'
end
