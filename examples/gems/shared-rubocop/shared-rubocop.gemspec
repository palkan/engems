# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name = "shared-rubocop"
  s.version = "0.1.0"
  s.authors = ["Vicinity"]
  s.summary = "Common RuboCop plugins and configuration"
  s.description = "Common RuboCop plugins and configuration"
  s.license = "MIT"

  s.files = Dir["{config,lib}/**/*", "Rakefile"]

  s.add_dependency "rubocop-rails"
  s.add_dependency "rubocop-rspec"
  s.add_dependency "standard", "~> 0.3.0"

  s.add_development_dependency "bundler", ">= 2"
  s.add_development_dependency "pry-byebug", ">= 3.6"
  s.add_development_dependency "rake", ">= 10.0"
  s.add_development_dependency "rspec", ">= 3.9"

  # Formatters
  # Progressbar-like formatter for RSpec
  s.add_dependency "fuubar", ">= 2.5"
  s.add_dependency "rspec-instafail", ">= 1.0"
  s.add_dependency "rspec_junit_formatter", ">= 0.4"
end
