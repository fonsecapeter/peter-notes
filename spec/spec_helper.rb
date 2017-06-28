require 'simplecov'
require 'simplecov-console'
require 'bundler/setup'

SimpleCov.formatter = SimpleCov::Formatter::Console
SimpleCov.start do
  add_filter 'models/console_app'  # just implements optparse
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
