# frozen_string_literal: true

# See https://relishapp.com/rspec/rspec-rails/docs/file-fixture
module Common::Testing
  module FileFixtureHelper
    def fixture_file_path(*paths)
      File.join(RSpec.configuration.file_fixture_path, *paths)
    end
  end
end

RSpec.configure do |config|
  config.include Common::Testing::FileFixtureHelper
end
