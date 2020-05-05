# frozen_string_literal: true

require "rspec"
require "rspec/instafail"
require "rspec_junit_formatter"
require "rspec/support/spec/shell_out"

RSpec.configure do |config|
  include RSpec::Support::ShellOut

  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  # This option will default to `:apply_to_host_groups` in RSpec 4 (and will
  # have no way to turn it off -- the option exists only for backwards
  # compatibility in RSpec 3). It causes shared context metadata to be
  # inherited by the metadata hash of host groups and examples, rather than
  # triggering implicit auto-inclusion in groups with matching metadata.
  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.define_derived_metadata(file_path: %r{/spec/}) do |metadata|
    next if metadata.key?(:type)
    match = metadata[:location].match(%r{/spec/([^/]+)/})
    next unless match
    metadata[:type] = match[1].then do |path|
      next path unless path.respond_to?(:singularize)
      path.singularize
    end.to_sym
  end

  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "tmp/rspec_examples.txt"
  config.run_all_when_everything_filtered = true

  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = "doc"
  end

  unless ENV["FULLTRACE"]
    config.filter_gems_from_backtrace "factory_bot"
    config.filter_gems_from_backtrace "graphql"
    config.filter_gems_from_backtrace "test-prof"
  end

  # Always include the spec itself to the backtrace.
  # That also helps to avoid a full stack printing when
  # everything have been filtered out.
  config.backtrace_inclusion_patterns << %r{/spec/}

  config.order = :random
  Kernel.srand config.seed
end
