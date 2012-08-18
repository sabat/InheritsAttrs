# -*- encoding: utf-8 -*-

require File.expand_path('../lib/inherits_attrs/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "inherits_attrs"
  gem.version       = InheritsAttrs::VERSION
  gem.summary       = %q{Summary}
  gem.description   = %q{Description}
  gem.license       = "MIT"
  gem.authors       = ["Steve Abatangle"]
  gem.email         = "sabat@area51.org"
  gem.homepage      = "https://github.com/sabat/inherits_attrs#readme"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rdoc', '~> 3.0'
  gem.add_development_dependency 'rspec', '~> 2.4'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
end
