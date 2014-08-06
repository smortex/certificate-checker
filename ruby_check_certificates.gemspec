# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_check_certificates/version'

Gem::Specification.new do |spec|
  spec.name          = 'ruby_check_certificates'
  spec.version       = RubyCheckCertificates::VERSION
  spec.authors       = ['Romain Tartière']
  spec.email         = ['r.tartiere@santelink.fr']
  spec.summary       = 'Report expired/about to expires certificates in a directory tree.'
  spec.homepage      = 'https://github.com/sante-link/ruby_check_certificates'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
