# Shared Testing

RSpec configurations and utils for usage in gems, engines and apps.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "shared-rubocop", path: "gems/shared-rubocop"
```

or to your engine's Gemfile and `.gemspec`:

```ruby
# Gemfile
gem "shared-rubocop", path: "../../gems/shared-rubocop"

# .gemspec
s.add_development_dependency "shared-rubocop"
```

## Usage

This gem provides two configurations, which could be loaded via:
- `require "shared/testing/rspec_configuration"` – this is RSpec core configuration,
which must be added to your `spec_helper.rb`; it doesn't contain anything Rails specific
- `require "shared/testing/rails_configuration" – typical RSpec config for Rails, which
includes a lot of usefule stuff (see below); require it in your `rails_helper.rb`.

### Tools

Here is the list of gems included into Rails config:
- [rspec-rails](https://relishapp.com/rspec/rspec-rails/docs)
- [shared-factory](../shared-factory/README.md)
- [isolator](https://github.com/palkan/isolator)
- [n_plus_one_control](https://github.com/palkan/n_plus_one_control) (verbose by default)
- [shoulda-matchers](https://matchers.shoulda.io)
- [test-prof](https://test-prof.evilmartians.io)
- [ActiveSupport::Testing::TimeHelpers](https://api.rubyonrails.org/classes/ActiveSupport/Testing/TimeHelpers.html)

You can also add a dummy Rails app (in case of gem/engine) using [`combustion`](https://github.com/pat/combustion) gem, which is included, too. For example:

```ruby
require "shared/testing/rails_configuration"

require "combustion"

Combustion.initialize! :action_controller, :active_record, :active_job, :action_mailer do
  config.logger = Logger.new(nil)
  config.log_level = :fatal

  config.active_record.raise_in_transactional_callbacks = true

  config.active_job.queue_adapter = :test
end
```

Additional configuration could be added under `spec/internal`.

### Helpers

- `fixture_file_path(*args)` – returns path to a file fixture (based on [`fixture_path`](https://relishapp.com/rspec/rspec-rails/docs/file-fixture))

- `mails_for(email_or_user)` - returns a proxy for user's emails; useful to test that an email
has been sent and it's contents, for example:

```ruby
mailbox = mails_for(user) # or mails_for(email)
expect { subject }.to change(mailbox, :size).by(1)
expect(mailbox.last.subject).to eq "Hey, you got an email!"
```

### Shared Contexts

- `"active_job:perform"` (`active_job: :perform`) – perform enqueued Active Job jobs automatically
- `"csrf:on"` (`csrf: :on`) – turn on CSRF protection for `ActionController::Base` (it's off by default in specs)
- `"shared:request"` (`type: :request`, i.e. included automatically) – add `json_response` method and declare `subject` for request specs (see [testing guide](../../docs/testing/rails_controllers_requests.md)).
