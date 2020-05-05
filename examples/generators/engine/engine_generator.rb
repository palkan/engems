# frozen_string_literal: true

class EngineGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  def create_engine_file
    directory(".", "engines/#{name}")

    chmod "engines/#{name}/bin/console", 0o755, verbose: false
    chmod "engines/#{name}/bin/rails", 0o755, verbose: false
  end
end
