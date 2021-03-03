# Bundler extensions for Engems

## `#component` method

[Source](./component.rb)

This helper method is used to define a component (engine) as a dependency when using a [shared Gemfile.lock](../../guides/gemfiles.md) for all engines.

It does the following three things:

- Define the component as a dependency for `:default` and its own **named group** (`gem "component", path: "engines/component"`, group: [:default, :component]).
- Loads the component's `Gemfile.runtime` if any to the same groups (`eval_gemfile "engines/component/Gemfile.runtime"`).
- Loads the component's `Gemfile.dev` if any to the same groups (`eval_gemfile "engines/component/Gemfile.dev"`).
- Adds all development dependencies from the `component.gemspec` **only to the component group** (similar to `gem "dev-dep", group: [:component]).

## `#eval_gemfile` patch

[Source](./eval_gemfile_patch.rb)

This patch helps to avoid Bundler warnings regarding duplicate gems. It checks whether a Gemfile has been already
included and skip it, if so.
