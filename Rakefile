require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc "Open an irb session preloaded with this library"
task :console do
  system "irb -rubygems -I lib/active_record/gsheets -r oauth.rb"
end