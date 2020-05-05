# frozen_string_literal: true

# Disable Isolator in n_plus_one_control examples
#
# Rails 5 triggers `after_commit` callbacks depending on the properties of the outer transaction:
# if it has `joinable: false` then callbacks are triggered.
# `n_plus_one_control` also  uses a non-joinable transaction, but it's not counted as _safe_ by Isolator,
# 'cause it opens after the test example transaction (`transactional_tests` feature).
#
# Links:
#  - https://github.com/palkan/n_plus_one_control/blob/d13567e60c18bb2e85e606abee4c096383623992/lib/n_plus_one_control/executor.rb#L59
NPlusOneControl::Executor.singleton_class.prepend(Module.new do
  def with_transaction(*)
    Isolator.disable { super }
  end
end)
