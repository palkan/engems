# frozen_string_literal: true

# Faker load tons of useless locales by default
# (see https://github.com/stympy/faker/tree/master/lib/locales)
#
# And it's impossible to configure it(
# (see https://github.com/stympy/faker/blob/v1.9.3/lib/faker.rb#L14-L15)
#
# It's likely that we'll start using Estonian or Armenian or Mandarin
# for test/seed data in the nearest future.

# Read also https://evilmartians.com/chronicles/rails-profiling-story-or-how-i-caught-faker-trying-to-teach-my-app-australian-slang

# First, ensure i18n is loaded
require "i18n"

# Then, stub the `I18n` module with no-op one
save_i18n = Object.__send__(:const_get, :I18n)

# rubocop:disable Style/MethodMissingSuper, Style/MissingRespondToMissing
i18n_stub = Module.new do
  class << self
    def load_path
      []
    end

    def backend
      self
    end

    def initialized?
      false
    end

    def method_missing(*)
    end
  end
end
# rubocop:enable Style/MethodMissingSuper, Style/MissingRespondToMissing

# We don't want to show warnings
Kernel.silence_warnings do
  Object.__send__(:const_set, :I18n, i18n_stub)

  # Load fake and make it think like it's loading all the locales
  # to i18n
  require "faker"

  # Restore the original `I18n` module
  Object.__send__(:const_set, :I18n, save_i18n)
end

# Load only `en` locales
faker_spec = Gem.loaded_specs["faker"]
I18n.load_path += Dir[File.join(faker_spec.full_gem_path, "lib", "locales", "en/*.yml")]
I18n.reload! if I18n.backend.initialized?
