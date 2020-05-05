# Local gems

These are the examples of _local_ gems used by engines in the component-based Rails applications:

- [shared-rubocop](./shared-rubocop)—One RuboCop configuraiton to use in all libraries.
- [shared-testing](./shared-testing)—RSpec & testing tools configuration.
- [shared-factory](./shared-factory)—A tiny wrapper over `factory_bot`.

**NOTE:** All these gems could be generalized and pushed to a public or private package registry to share between the projects.
(We actually did this with some of them and already released 😉).
