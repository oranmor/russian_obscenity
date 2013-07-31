# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'russian_obscenity/version'

Gem::Specification.new do |spec|
  spec.name          = 'russian_obscenity'
  spec.version       = RussianObscenity::VERSION
  spec.authors       = ['Denis Kurochkin']
  spec.email         = ['deniskuro@gmail.com']
  spec.summary       = 'Gem for filtering russian obscene language'
  spec.homepage      = 'http://github.com/oranmor/russian_obscenity'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib", "config"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
