source 'https://rubygems.org'

gemspec

# TODO! shoulda matcher support for rails5 is on a specific branch
# I needed to extract the dependency from the gemspec into the Gemfile to ensure it would include the correct one
group :test do
  gem 'shoulda-matchers', git: 'https://github.com/thoughtbot/shoulda-matchers.git', branch: 'rails-5'
end
