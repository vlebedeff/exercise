require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new
RuboCop::RakeTask.new

task default: :test

task :console do
  require 'pry'

  $LOAD_PATH << './lib'
  require 'exercise'

  Pry.start
end

file 'dist/gaussian' => 'c/gaussian.c' do
  sh 'gcc --std=c11 -pipe -Wall -pedantic -lm -g c/gaussian.c -o dist/gaussian'
end

task test: [:spec, :rubocop, 'dist/gaussian'] do
  sh('echo "0" | ./dist/gaussian')
end

task format: :astyle do
  FileList['c/**/*.c'].each do |f|
    sh("astyle --project #{f}")
  end
end

task :astyle do
  sh('command -v astyle > /dev/null || sudo apt install -y astyle')
end
