begin
  require 'rspec/core/rake_task'
  require 'rubocop/rake_task'

  namespace :ci do
    desc 'Run factory specs.'
    RSpec::Core::RakeTask.new(:factory_specs) do |t|
      t.verbose = false
      t.pattern = './spec/factories_spec.rb'
      t.rspec_opts = ['--format documentation',
                      '-t ~@skip-ci',
                      '--failure-exit-code 1']
    end

    desc 'Run specs'
    RSpec::Core::RakeTask.new(:specs) do |t|
      t.verbose = false
      t.exclude_pattern = './spec/factories_spec.rb'
      t.rspec_opts = ['--format documentation',
                      '-t ~@skip-ci',
                      '--failure-exit-code 1']
    end

    desc 'Run rubocop'
    RuboCop::RakeTask.new(:rubocop) do |t|
      t.fail_on_error = true
      t.verbose = false
      t.formatters = ['RuboCop::Formatter::SimpleTextFormatter']
      t.options = ['-D']
    end

    desc 'Run things for ci'
    task :build do
      puts "\033[34mRunning rubocop:\033[0m"
      Rake::Task['ci:rubocop'].invoke

      puts

      puts "\033[34mRunning rspec:\033[0m"
      Rake::Task['ci:factory_specs'].invoke
      Rake::Task['ci:specs'].invoke
    end
  end
rescue => e
  puts "Error #{e.message}"
end
