# run all tests and run them in one batch
%w[default test].each { |task| Rake::Task[task].clear }
Rake::TestTask.new(:default => "test:prepare") do |test|
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end