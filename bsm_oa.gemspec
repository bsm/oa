$:.push File.expand_path('../lib', __FILE__)

require 'bsm_oa/version'

Gem::Specification.new do |s|
  s.name        = 'bsm_oa'
  s.version     = BsmOa::VERSION
  s.authors     = ['Andy Born', 'Dimitrij Denissenko']
  s.email       = 'info@blacksquaremedia.com'
  s.homepage    = 'https://github.org/bsm/oa'
  s.summary     = 'Rails Open Authority engine'
  s.description = 'Opinionated toolbox for building centralised authorities'
  s.licenses    = ['MIT']
  s.required_ruby_version = '>= 2.3.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency 'railties', '~> 5.0'
  s.add_dependency 'doorkeeper', '~> 4.2.0'
  s.add_dependency 'responders', '~> 2.1'
  s.add_dependency 'has_scope', '~> 0.6'

  s.add_development_dependency 'rails', '>= 5.0'
  s.add_development_dependency 'combustion', '~> 0.7.0'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'faker'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rails-controller-testing'
end
