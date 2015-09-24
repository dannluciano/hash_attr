require './lib/hashed_attr/version'

Gem::Specification.new do |spec|
  spec.name          = 'hashed_attr'
  spec.version       = HashedAttr::VERSION
  spec.authors       = ['Dann Luciano']
  spec.email         = ['dannluciano@gmail.com']
  spec.summary       = 'Hash attributes using SHA512 (or your custom hash strategy). Works with and without ActiveRecord.'
  spec.description   = spec.summary
  spec.homepage      = 'http://rubygems.org/gems/hashed_attr'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'minitest-reporters'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'activerecord'
  spec.add_development_dependency 'codeclimate-test-reporter'
end
