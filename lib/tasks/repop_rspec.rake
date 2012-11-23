require 'rspec/core/rake_task'
task :repop do
  RSpec::Core::RakeTask.new('spec')
  task :default => :spec
end
