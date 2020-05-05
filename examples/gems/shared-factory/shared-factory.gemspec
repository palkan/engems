# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

rails_version = File.read(File.join(__dir__, "../../.rails-version"))

Gem::Specification.new do |s|
  s.name = "shared-factory"
  s.version = "0.1.0"
  s.authors = ["Vicinity"]
  s.summary = "Common factory bot utils"

  s.files = Dir["{config,lib}/**/*", "Rakefile"]
  s.require_paths = ["lib"]

  s.add_dependency "rails", rails_version

  s.add_dependency "factory_bot_rails", "~> 5.1"
  s.add_dependency "faker", "~> 2.7"

  s.add_development_dependency "bundler", ">= 2"
  s.add_development_dependency "pry-byebug", ">= 3.4"
  s.add_development_dependency "rake", "~> 13.0"

  # Internal
  s.add_development_dependency "shared-rubocop"
end
