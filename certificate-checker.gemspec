lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'certificate-checker/version'

Gem::Specification.new do |spec|
  spec.name          = 'certificate-checker'
  spec.version       = CertificateChecker::VERSION
  spec.authors       = ['Romain Tartière']
  spec.email         = ['romain@blogreen.org']
  spec.summary       = 'Report expired/about to expires certificates in a directory tree.'
  spec.homepage      = 'https://github.com/smortex/certificate-checker'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
end
