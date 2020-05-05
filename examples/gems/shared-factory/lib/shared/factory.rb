# frozen_string_literal: true

require "shared/factory/faker"
require "factory_bot"

# Run load hooks before loading definitions to
# allow engines to register their factories
ActiveSupport.run_load_hooks(:factory_bot, FactoryBot)

# And only after that load Rails integration
require "factory_bot_rails"
