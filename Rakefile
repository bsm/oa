require 'bundler/setup'
require 'rspec/core/rake_task'

desc 'Default: run specs.'
task :default => :spec

desc "Run all specs"
RSpec::Core::RakeTask.new(:spec) do |config|
  config.verbose = false
end

Bundler::GemHelper.install_tasks
