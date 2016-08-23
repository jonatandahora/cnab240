# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cnab240/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_dependency 'bindata', '~> 2.1.0'
  gem.add_dependency 'json', '~> 2.0', '>= 2.0.2'
  gem.add_dependency 'i18n', '~> 0.7.0'
  gem.authors       = ['Eduardo Mourao']
  gem.email         = ['eduardo.a20@gmail.com']
  gem.description   = 'Formato CNAB 240.'
  gem.summary       = 'Formato CNAB 240.'
  gem.homepage      = ''

  gem.rubyforge_project = 'cnab240'

  gem.files         = Dir.glob('lib/**/*') + Dir.glob('config/*') + ['Rakefile'] + ['cnab240.gemspec']
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'cnab240'
  gem.require_paths = ['lib']
  gem.version       = Cnab240::VERSION
end
