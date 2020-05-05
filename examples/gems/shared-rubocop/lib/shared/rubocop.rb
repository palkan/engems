# frozen_string_literal: true

require "rubocop"
require "standard"

module Shared
  module Rubocop
  end
end

# Do not use the root app RuboCop exclusions in
# isolated gems stored in the same repo
# See https://github.com/rubocop-hq/rubocop/pull/4329
RuboCop::ConfigLoader.ignore_parent_exclusion = true
