require 'bundler/setup'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

desc 'Default: run specs.'
task :default => :spec

desc "Run all specs"
RSpec::Core::RakeTask.new(:spec) do |config|
  config.verbose = false
end

desc "Show test app routes"
task :routes do
  require File.expand_path('../spec/spec_helper', __FILE__)
  require 'action_dispatch/routing/inspector'

  all_routes = Rails.application.routes.routes
  inspector  = ActionDispatch::Routing::RoutesInspector.new(all_routes)
  puts inspector.format(ActionDispatch::Routing::ConsoleFormatter.new, ENV['CONTROLLER'])
end
