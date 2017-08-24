require "bundler/setup"
require "sass_updater"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  #config.disable_monkey_patching!


  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

  config.mock_with :rspec do |mocks|
    #mocks.expect_with :rspec do |c|
    mocks.syntax = [:should, :expect]
    #end
  end
  
end 
