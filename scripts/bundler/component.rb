return if Bundler::Dsl.instance_methods.include?(:component)

class Bundler::Dsl
  def component(name, namespace: "engines")
    # NOTE: Change to the project root path.
    Dir.chdir(__dir__) do
      component_group = name.to_sym

      group :default do
        # Add engine as a dependency
        gemspec name: name, path: "#{namespace}/#{name}", development_group: component_group

        # Add runtime non-RubyGems specs
        if File.readable?("#{namespace}/#{name}/Gemfile.runtime")
          eval_gemfile "#{namespace}/#{name}/Gemfile.runtime"
        end
      end

      group component_group do
        # Add dev non-RubyGems specs
        if File.readable?("#{namespace}/#{name}/Gemfile.dev")
          eval_gemfile "#{namespace}/#{name}/Gemfile.dev"
        end
      end
    end
  end
end
