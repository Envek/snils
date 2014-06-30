# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'snils/version'

Gem::Specification.new do |spec|
  spec.name          = 'snils'
  spec.version       = Snils::VERSION
  spec.authors       = ['Andrey Novikov']
  spec.email         = ['envek@envek.name']
  spec.summary       = %q{Generating, validating and formatting SNILS number (Russian pension insurance number)}
  spec.homepage      = 'https://github.com/Envek/snils'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rdoc'

  spec.extra_rdoc_files = ['README.md', 'README.ru.md', 'LICENSE.txt']
  spec.rdoc_options << '--main' << 'README.md'
end
