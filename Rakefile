require 'rake/clean'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

CLOBBER.include('dist/*')

RSpec::Core::RakeTask.new
RuboCop::RakeTask.new

task default: %w[spec rubocop]

task :console do
  require 'pry'

  $LOAD_PATH << './lib'
  require 'exercise'

  Pry.start
end

file 'dist/gaussian' => 'c/gaussian.c' do
  sh 'gcc --std=c11 -pipe -Wall -pedantic -lm -g c/gaussian.c -o dist/gaussian', verbose: false
end

task format: :astyle do
  FileList['c/**/*.c'].each do |f|
    sh("astyle --project #{f}")
  end
end

task :astyle do
  sh('command -v astyle > /dev/null || sudo apt install -y astyle')
end
