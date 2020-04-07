require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new
RuboCop::RakeTask.new

task default: %i[spec rubocop]

task :console do
  require 'pry'

  $LOAD_PATH << './lib'
  require 'exercise'

  Pry.start
end
