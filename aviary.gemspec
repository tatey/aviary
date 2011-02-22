# -*- encoding: utf-8 -*-
require File.expand_path('../lib/aviary/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'aviary'
  s.version     = Aviary::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Tate Johnson']
  s.email       = ['tate@tatey.com']
  s.homepage    = 'https://github.com/tatey/aviary'
  s.summary     = %q{A static photo gallery generator for Twitter}
  s.description = %q{Aviary generates a static photo gallery using Twitter}

  s.rubyforge_project = s.name

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
  
  s.add_development_dependency('bundler', '~> 1.0.10')
  s.add_development_dependency('webmock', '~> 1.6.2')
  s.add_development_dependency('minitest', '~> 2.0.2')

  s.add_runtime_dependency('base58', '~> 0.1')
  s.add_runtime_dependency('dm-core', '~> 1.0.2')
  s.add_runtime_dependency('dm-sqlite-adapter', '~> 1.0.2')
  s.add_runtime_dependency('dm-migrations', '~> 1.0.2')
  s.add_runtime_dependency('dm-validations', '~> 1.0.2')
  s.add_runtime_dependency('nokogiri', '~> 1.4.4')
  s.add_runtime_dependency('twitter', '~> 1.1.2')
end
