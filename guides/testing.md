# Testing

## Combustion

[Combustion](https://github.com/pat/combustion) allows you to minimize the burden of keeping a dummy Rails app in an engine's test suite.

That's how we configure it:

```ruby
require "combustion"

begin
  Combustion.initialize! :active_record do
    config.logger = Logger.new(nil)
    config.log_level = :fatal

    # For Rails 6
    config.autoloader = :zeitwerk

    # Always use test adapter for active_job
    # config.active_job.queue_adapter = :test
    #
    # Always use test service to active_storage
    # config.active_storage.service = :test
    #
    # Enable verbose logging for active_record
    # config.active_record.verbose_query_logs = true
  end
rescue => e
  # Fail fast if application couldn't be loaded
  $stdout.puts "Failed to load the app: #{e.message}\n#{e.backtrace.take(5).join("\n")}"
  exit(1)
end
```

## CI

Component-based architecture has a benefit of isolated testing: each component has its test suite.
That means, that we can avoid running tests for components, which haven't been "changed", for every commit.

We use a helper tool ([is-dirty](../scripts/is-dirty/README.md)) for that.
