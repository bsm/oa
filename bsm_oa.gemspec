$:.push File.expand_path('../lib', __FILE__)

require 'bsm_oa/version'

Gem::Specification.new do |s|
  s.name        = 'bsm_oa'
  s.version     = BsmOa::VERSION
  s.authors     = ['Andy Born', 'Dimitrij Denissenko']
  s.email       = 'info@blacksquaremedia.com'
  s.homepage    = 'https://github.org/bsm/bsm_oa'
  s.summary     = ''
  s.description = ''
  s.licenses    = ['MIT']

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency 'railties', '>= 4.1', '< 5.0'
  s.add_dependency 'doorkeeper', '~> 2.2.1'
  s.add_dependency 'responders', '~> 2.0'
  s.add_dependency 'jbuilder', '~> 2.2'
  s.add_dependency 'bsm-models'
  s.add_dependency 'has_scope', '~> 0.6'
  s.add_dependency 'simple_form', '~> 3.1.0'
  s.add_dependency 'jquery-rails'

  s.add_development_dependency 'rails', '>= 4.1'
  s.add_development_dependency 'combustion', '~> 0.5.3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'json_spec'
  s.add_development_dependency 'faker'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'sqlite3'
end
