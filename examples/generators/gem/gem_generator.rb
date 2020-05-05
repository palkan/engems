# frozen_string_literal: true

class GemGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  def create_engine_file
    directory(".", "gems/#{name}")

    chmod "gems/#{name}/bin/console", 0o755, verbose: false
  end
end
