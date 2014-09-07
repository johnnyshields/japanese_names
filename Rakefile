require 'rake'
require 'rspec/core'
require 'rspec/core/rake_task'

Dir['tasks/*.rake'].each{|f| load f }

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
  spec.rspec_opts = '--color --format progress'
end

task default: :spec
