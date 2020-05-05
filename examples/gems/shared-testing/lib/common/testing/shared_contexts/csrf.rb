# frozen_string_literal: true

# Turn on forgery protection for API requests
# (to make sure that we handle (=ignore) normal CSRF protection)
shared_context "csrf:on" do
  around do |ex|
    save = ActionController::Base.allow_forgery_protection
    ActionController::Base.allow_forgery_protection = true
    ex.run
    ActionController::Base.allow_forgery_protection = save
  end
end

RSpec.configure do |config|
  config.include_context "csrf:on", csrf: :on
end
