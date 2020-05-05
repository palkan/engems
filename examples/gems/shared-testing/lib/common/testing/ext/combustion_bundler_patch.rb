# frozen_string_literal: true

# Hijack Bundler.require from Combustion.initialize! to load engine-specific group
Combustion.singleton_class.prepend(Module.new do
  def initialize!(*args, bundler_groups: nil, **kwargs)
    if bundler_groups
      original_require = Bundler.method(:require)
      Bundler.define_singleton_method(:require) { |*| original_require.call(*bundler_groups) }
    end

    super
  ensure
    Bundler.define_singleton_method(:require, original_require) if bundler_groups
  end
end)
