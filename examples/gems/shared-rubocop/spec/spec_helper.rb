# frozen_string_literal: true

require "bundler/setup"
require "pry-byebug"
require "rspec"

require "rubocop"
require "rubocop/rspec/support"

RSpec.configure do |config|
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "tmp/rspec_examples.txt"

  if config.files_to_run.one?
    config.default_formatter = "doc"
  end

  config.order = :random
  Kernel.srand config.seed
end
