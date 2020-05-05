return if Bundler::Dsl.instance_methods.include?(:component)

class Bundler::Dsl
  def component(name, namespace: "engines")
    Dir.chdir(__dir__) do
      component_group = name.to_sym
        group :default, component_group do
          # Add engine as a dependency
          gem name, path: "#{namespace}/#{name}"

          # Add runtime non-RubyGems specs
          if File.readable?("#{namespace}/#{name}/Gemfile.runtime")
            eval_gemfile "#{namespace}/#{name}/Gemfile.runtime"
          end
        end

        group component_group do
          # First, add gems from the component's Gemfile
          eval_gemfile "#{namespace}/#{name}/Gemfile"

          # Add development deps to development and test groups
          expanded_spec_path = Pathname.new("#{namespace}/#{name}/#{name}.gemspec").expand_path(@gemfile&.parent)

          spec = Gem::Specification.load(expanded_spec_path.to_s)

          spec.dependencies.select { |s| s.type == :development }.each do |dep|
            current = @dependencies.find { |current_dep| current_dep.name == dep.name }

            if current
              next if current.source.is_a?(Bundler::Source::Path)
            end

            gem dep.name, *dep.requirement.to_s.split(/,\s*/)
          end
        end
      end
    end
  end
end
