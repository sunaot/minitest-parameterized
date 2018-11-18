require "bundler/gem_tasks"
require "rake/testtask"
require "rake/clean"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end
CLOBBER.include('minitest-parameterized-*.gem', 'pkg/minitest-parameterized-*.gem')

task :default => :test
