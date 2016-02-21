require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = "spec/*/*_spec.rb"
end

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r rubies.rb"
end

task default: :spec
