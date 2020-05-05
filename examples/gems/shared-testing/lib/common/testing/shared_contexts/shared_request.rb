# frozen_string_literal: true

shared_context "shared:request" do
  subject { request; response } # rubocop:disable Style/Semicolon
end

RSpec.configure do |config|
  config.include_context "shared:request", type: :request
  config.include Common::Testing::JSONResponse, type: :request
end
