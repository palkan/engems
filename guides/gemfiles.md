# Gemfiles and gemspecs organization

## `Gemfile.dev`, `Gemfile.runtime` and `.gemspec`

We use the following approach to define gems/engines dependencies and requirements:

- `<gem>/<gem>.gemspec` – this is Gem specification; it defines **requirements** for this gem (for runtime and development); all required libraries (even _local_) must be specified in the gemspec: we use this information when checking _dirtyness_ of gems on CI (see [dirty-ci](../scripts/dirty-ci/README.md))
- `<gem>/Gemfile.runtime` – defines where to find non-RubyGems **runtime** dependencies (local and GitHub); this file is used by other gems via the [`eval_gemfile`](../scripts/bundler/README.md#eval_gemfile) method.
- `<gem>/Gemfile.dev` – defines where to find non-RubyGems **development** dependencies (local and GitHub); always _includes_ (via `eval_gemfile`) the `Gemfile.runtime` file.
- `<gem>/Gemfile` – only used for isolated development and contains the following:

```ruby
source "https://rubygems.org"

gemspec

eval_gemfile "./Gemfile.dev"
eval_gemfile "./Gemfile.runtime"
```

## Universal Gemfile

One of the problems of component-based architecture is dependencies synchronization between engines (including the root application).

One possible solution for that is to use a **single lockfile** (`Gemfile.lock`) for all apps. We use the root application `Gemfile.lock` (since that's the one used in production).

To do that, we need to configure a Gemfile path for components. It could be done via:

- `BUNDLE_GEMFILE="../../Gemfile"` env variable (assuming your component is located at `<root>/engines/<component>`).
- Alternatively, you can update a local bundler config: `bundle config --local gemfile="../../Gemfile"` (Make sure your `BUNDLE_APP_CONFIG` env var is not set or equal to `"/.bundle"`).

To take into account components development dependencies, we need to specify them in the root Gemfile (see [`component`](../scripts/bundler/README.md#component)).

Then, we need to make sure that we test our components in isolation. For that we use a custom bundle group (named as component).

If you're using dummy Rails apps to test engines, you need to change the `config/application.rb` file the following way:

```diff
- Bundler.require(*Rails.groups)
+ Bundler.require(:my_component)
```

If you're using [Combustion](./testing.md), then you need to [patch it](../scripts/combustion/README.md):

```ruby
Combustion.initialize! :active_record, bundler_groups: :my_component do
  # ...
end
```
